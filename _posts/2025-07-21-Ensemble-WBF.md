---
layout: post
title:  "Object Detection의 앙상블 기법: WBF"
date:   2025-07-21 11:00:00 +0900
categories: [Machine Learning, WBF]
tags: [WBF, sklearn, Deep Learning, AI, Computer Vision]
image:
  path: https://learnopencv.com/wp-content/uploads/2023/07/weighted-boxes-fusion-feature.png
#   alt: 나의 멋진 썸네일 이미지
#   lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD... # 여기에 base64 코드를 넣어
#   shadow: true # 그림자 효과 켜기
comments: true     # 댓글 기능 사용 (옵션)

---


## 🟣 Object Detection의 앙상블 기법: WBF (Weighted Boxes Fusion)
---
Object Detection 모델들은 동일한 이미지에 대해 서로 다른 위치에 bounding box를 예측하는 경우가 많음.  
이러한 불일치를 줄이고 성능을 향상시키기 위해 앙상블 기법을 적용할 수 있음.  
그 중 하나가 Weighted Boxes Fusion (WBF)임.

---

#### ⚪ 1. 기존 기법: NMS와 Soft-NMS

대부분의 Object Detection 모델은 **post-processing 단계**에서 NMS(Non-Maximum Suppression)를 사용함.

![WBF](https://www.researchgate.net/publication/379479349/figure/fig6/AS:11431281250163026@1717760637927/Visual-comparison-between-WBF-and-NMS-Soft-NMS.png)

- **NMS**는 겹치는 box들 중에서 가장 confidence score가 높은 box 하나만 남기고, 나머지를 제거함.
- **Soft-NMS**는 제거 대신, 겹치는 box들의 confidence를 감소시키는 방식임.

이 두 방법의 공통점은, 겹치는 box 중 **정보를 제거하는 방식**이라는 점임.  
따라서 복수의 모델을 앙상블할 때는 불리할 수 있음.

---

#### ⚪ 2. WBF (Weighted Boxes Fusion)의 아이디어

WBF는 다음과 같은 아이디어를 가짐:

> "비슷한 위치의 box는 하나로 **결합(fusion)**하고, confidence score를 가중치로 활용하여 평균을 냄."

즉, 각 모델이 예측한 box들 중 **유사한 위치에 있는 것들끼리 클러스터링**하고,  
그들의 좌표를 **가중평균(weighted average)**으로 계산함.  
confidence가 높을수록 해당 box의 위치를 더 반영함.

---

#### ⚪ 3. 수식적 정의

같은 객체를 예측한 box들이 다음과 같다고 하자:

- box 좌표: \( B_i = (x_i, y_i, w_i, h_i) \)
- confidence score: \( s_i \)
- 총 예측 box 수: \( N \)

이때 WBF는 최종 box \( B_{\text{fused}} \)를 다음과 같이 계산함:

\[
B_{\text{fused}} = \frac{\sum_{i=1}^{N} s_i \cdot B_i}{\sum_{i=1}^{N} s_i}
\]

즉, confidence가 높은 box일수록 box 좌표 평균에 더 크게 기여하게 됨.

---

#### ⚪ 4. 구현 예시 (Python)

`ensemble-boxes` 라이브러리를 이용하면 쉽게 구현할 수 있음:

```bash
pip install ensemble-boxes
````

```python
from ensemble_boxes import weighted_boxes_fusion

# 예시: 2개의 모델 예측 결과
boxes_list = [
    [[0.1, 0.1, 0.4, 0.4], [0.15, 0.15, 0.45, 0.45]],  # model1
    [[0.12, 0.1, 0.42, 0.4], [0.5, 0.5, 0.7, 0.7]]      # model2
]
scores_list = [
    [0.9, 0.75],  # model1
    [0.88, 0.6]   # model2
]
labels_list = [
    [0, 0],  # class 0
    [0, 1]   # class 0, class 1
]

boxes, scores, labels = weighted_boxes_fusion(
    boxes_list, scores_list, labels_list,
    weights=[1, 1],
    iou_thr=0.55,
    skip_box_thr=0.0
)

print("Fused Boxes:", boxes)
print("Fused Scores:", scores)
print("Fused Labels:", labels)
```

* box 좌표는 반드시 **normalized (0\~1)** 이어야 함
* `weights`는 모델별 가중치로, 필요 시 튜닝 가능함

---

#### ⚪ 5. WBF의 장점과 한계

##### 장점

* confidence를 반영해 더 **정확한 box 위치**를 예측할 수 있음
* box 제거가 없기 때문에 **정보 손실이 적음**
* 다양한 구조의 모델을 **조합 가능** (예: YOLO + Faster R-CNN)

##### 단점

* 입력 box 수가 많아지면 **속도가 느려질 수 있음**
* 앙상블 전 사전 정규화 필요
* 모델 간 예측 편차가 클 경우 **효과가 낮아질 수도 있음**

---

#### ⚪ 6. 결론

WBF는 object detection에서 단순한 post-processing 이상으로,
**모델 간 불확실성을 조화롭게 조합**할 수 있는 실용적인 앙상블 기법임.

특히 두 모델의 특성이 다를수록 (e.g. YOLO의 빠른 탐지 + Faster R-CNN의 정확한 localization)
WBF를 통해 서로의 약점을 보완하는 데 큰 도움이 될 수 있음.

---

## 🟣 Reference

* ZFTurbo, “Weighted Boxes Fusion”, GitHub:
  [https://github.com/ZFTurbo/Weighted-Boxes-Fusion](https://github.com/ZFTurbo/Weighted-Boxes-Fusion)
* Original Paper (arXiv): [https://arxiv.org/abs/1910.13302](https://arxiv.org/abs/1910.13302)
* YOLO vs Faster R-CNN 앙상블 실험: [AI03 Proect-1](https://github.com/soohyun-chris-jeon/AI03-Project-1)
