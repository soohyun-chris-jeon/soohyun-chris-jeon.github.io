---
layout: post
title:  "15-(2) 양자화 기법인 Post-Training Quantization과 Quantization-Aware Training의 차이를 설명해보세요."
date:   2025-10-20 01:00:00 +0900
categories: [Quantization]
tags: [Docker, Deep Learning, AI]
comments: true     # 댓글 기능 사용 (옵션)
image:
    path: https://www.ibm.com/content/dam/connectedassets-adobe-cms/worldwide-content/creative-assets/s-migr/ul/g/db/e8/quantization-aware-training-1.component.lightbox.ts=1747847841587.png/content/adobe-cms/us/en/think/topics/quantization-aware-training/jcr:content/root/table_of_contents/body-article-8/image

---
## 🟢 양자화 기법인 Post-Training Quantization과 Quantization-Aware Training의 차이

모델을 가볍게 만드는 양자화(Quantization) 기법 중에서 가장 대표적인 두 가지, **PTQ(Post-Training Quantization)**와 **QAT(Quantization-Aware Training)**의 차이에 대해 알아보겠다.

핵심부터 말하면, **언제 양자화를 적용하느냐**가 가장 큰 차이이다. PTQ는 **학습이 끝난 후**에, QAT는 **학습하는 과정 속**에 양자화를 적용한다. 이 시점의 차이가 정확도, 복잡성 등 여러 면에서 뚜렷한 장단점을 만들어낸다고 한다.

---

#### ⚪ Post-Training Quantization (PTQ): "일단 끝내고 압축"

**PTQ (학습 후 양자화)**는 이름 그대로, 이미 학습이 완료된 32비트 부동소수점(FP32) 모델의 가중치(weights)와 활성화(activations)를 8비트 정수(INT8) 같은 저정밀도(low-precision)로 변환하는 방식이다.

* **작업 흐름**:
    1.  FP32 정밀도로 모델 학습을 **완전히 끝낸다.**
    2.  (선택 사항) 소량의 보정(calibration) 데이터를 사용해서 활성화 값의 범위를 측정하고, 양자화로 인한 오차를 최소화할 변환 스케일을 계산한다.
    3.  학습된 모델에 양자화를 **적용**하여 저정밀도 모델을 얻는다.

* **장점**:
    * **간단하고 빠르다**: 기존의 학습된 모델만 있으면 되므로, 적용하기가 매우 쉬워. 추가적인 학습 과정이 필요 없음.
    * **데이터가 거의 필요 없다**: 보정 과정이 필요하긴 하지만, 학습 데이터 전체가 아닌 아주 적은 양의 샘플 데이터만으로도 충분함.

* **단점**:
    * **정확도 하락 위험**: 학습이 끝난 모델을 강제로 저정밀도로 바꾸는 거라, 정보 손실이 발생하면서 모델의 정확도(accuracy)가 떨어질 수 있음. 특히 모델 크기가 작거나, 양자화에 민감한 구조(예: MobileNet)일수록 성능 하락이 클 수 있음.

PTQ는 "일단 빨리 양자화를 적용해보고 싶을 때"나 "정확도 하락이 크지 않은 큰 모델"에 적합한 방식.



---

#### ⚪ Quantization-Aware Training (QAT): "압축할 걸 미리 염두에 두고 훈련"

**QAT (양자화 인지 훈련)**는 학습 과정 자체에 '가짜' 양자화 연산(fake quantization)을 추가해서, 모델이 **양자화로 인한 오차에 미리 적응하도록** 훈련시키는 방식이다.

* **작업 흐름**:
    1.  미리 학습된 FP32 모델로 시작하거나, 처음부터 학습을 시작한다.
    2.  모델의 순전파(forward pass) 과정에 양자화와 역양자화(quant-dequant) 노드를 삽입한다. 이 노드는 FP32 값을 INT8로 변환했다가 다시 FP32로 되돌리는 시뮬레이션을 해.
    3.  이 '가짜' 양자화로 인한 오차까지 손실 함수(loss function)에 반영되므로, 모델은 이 오차를 최소화하는 방향으로 가중치를 업데이트하며 **학습**한다.
    4.  학습이 끝나면, 시뮬레이션 과정에서 얻은 정보를 바탕으로 실제 저정밀도 모델로 변환한다.

* **장점**:
    * **높은 정확도 유지**: 학습 과정에서 양자화 오류에 미리 대비하기 때문에, PTQ에 비해 정확도 하락이 훨씬 적어. 거의 FP32 모델과 유사한 성능을 낼 수 있음.
    * **안정적인 성능**: 양자화로 인한 성능 저하를 최소화하도록 훈련되었기 때문에, 다양한 모델 아키텍처에서 안정적인 결과를 보여줌.

* **단점**:
    * **복잡하고 오래 걸린다**: 전체 학습 파이프라인을 수정해야 하고, 모델을 다시 학습시키거나 추가로 미세 조정(fine-tuning)해야 하므로 시간과 컴퓨팅 자원이 훨씬 많이 듦.

QAT는 "조금 번거롭더라도 모델의 정확도를 최대한 지키고 싶을 때" 사용하는 최적의 방법이다.

---

#### ⚪ 비교

![QAT vs PTQ](https://www.researchgate.net/publication/394595078/figure/fig3/AS:11431281597413211@1755631929116/Llustration-of-PTQ-and-QAT-Quantization-is-further-categorized-by-application-stage.ppm)



| 구분 | Post-Training Quantization (PTQ) | Quantization-Aware Training (QAT) |
| :--- | :--- | :--- |
| **적용 시점** | **학습 완료 후** | **학습 과정 중** |
| **정확도** | 다소 하락할 수 있음 (특히 소형 모델) | 거의 원본 수준으로 **유지 가능** |
| **복잡성** | **낮음** (간단하고 빠름) | **높음** (재학습/미세조정 필요) |
| **필요 데이터** | 소량의 보정 데이터 (선택) | 전체 학습 데이터셋 |
| **추천 상황** | 빠른 적용이 필요할 때, 정확도 하락이 적은 대형 모델 | **정확도 유지가 매우 중요**할 때 |

정리하자면, 보통 **먼저 PTQ를 시도**해보고, 만약 정확도 하락이 허용 범위를 넘어선다면 그때 **QAT를 적용**하는 것이 일반적인 접근 방식이다. 둘의 장단점이 명확하니, 상황에 맞게 적절한 기법을 선택하는 게 중요할듯

---


## 🟢 예시 답안 (코드잇 제공)


>Post-Training Quantization(PTQ)과 Quantization-Aware Training(QAT)은 모두 모델을 경량화하고 추론 속도를 높이기 위한 양자화 방법이지만, 적용 시점과 방식에서 큰 차이가 있습니다.<br>
PTQ는 학습이 완료된 모델에 대해 사후적으로 양자화를 적용하는 방식입니다. 보통 float32 정밀도를 int8 등의 낮은 정밀도로 변환하며, 추가 학습 없이 빠르게 적용할 수 있다는 장점이 있지만, 정밀도가 떨어질 경우 성능 저하가 생길 수 있습니다.<br>
반면 QAT는 훈련 단계에서부터 양자화를 고려해서 모델을 학습합니다. 이 방식은 정밀도 손실을 줄이기 위해 가중치와 연산을 양자화된 상태로 시뮬레이션하면서 학습을 진행하므로, 일반적으로 PTQ보다 높은 정확도를 유지할 수 있습니다.<br>
즉, PTQ는 간편하지만 성능 저하 가능성이 있고, QAT는 복잡하지만 정확도 유지에 더 유리한 방법입니다.