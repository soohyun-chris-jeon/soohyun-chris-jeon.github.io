---
layout: post
title:  "7-(3) Transfer Learning(전이 학습)이란 무엇이며, 이미지 분류 모델에서 어떻게 활용할 수 있나요?"
date:   2025-06-27 13:00:00 +0900
categories: [Codeit AI 3기, Weekly Paper]
tags: [Transfer Learning, 전이학습, PyTorch, CNN, convolutional-neural-network, Deep Learning, AI, Computer Vision]
comments: true     # 댓글 기능 사용 (옵션)

---


### 🟢 7-(3). Transfer Learning(전이 학습)이란?

#### ⚪ Feature extraction vs. Fine-tuning?

- **Feature Extraction**: pretrained model의 중간 feature만 사용하고, classifier만 새로 학습.
- **Fine-tuning**: 전체 모델 또는 상위 일부 레이어를 재학습.

![tra](https://www.mdpi.com/sensors/sensors-23-00570/article_deploy/html/images/sensors-23-00570-g001.png)


---

#### ⚪ Computer vision 적용 사례

| 모델 | 기반 구조 | 학습 데이터셋 | 특징 / 용도 |
|------|-----------|----------------|------------------|
| **ResNet (50, 101)** | CNN | ImageNet (1000 classes, 1.2M images) | 거의 모든 비전 분야에서 사용됨. 안정적인 백본(backbone). |
| **VGG16 / VGG19** | CNN | ImageNet | 구조는 단순하지만 파라미터 수 많음. 주로 feature extraction용. |
| **EfficientNet (B0~B7)** | CNN (compound scaling) | ImageNet | 경량화 + 고성능. 모바일 환경에서 특히 좋음. |
| **DenseNet** | CNN | ImageNet | Dense connection으로 feature reuse 극대화. |
| **ViT (Vision Transformer)** | Transformer | ImageNet-21K, ImageNet-1K | patch 단위 attention. 최근 트렌드. 큰 데이터에서 학습 시 효과적. |
| **CLIP (by OpenAI)** | CNN + Transformer | 400M image-text pairs (web) | 이미지 + 텍스트 연결 학습. zero-shot 성능 강력함. |
| **SAM (Segment Anything by Meta)** | CNN + ViT | 11M images + 1B masks | segmentation 전이 학습에 특화된 foundation model |


---

#### ⚪ Transfer Learning 응용 전략

| 전략 | 설명 | 언제 사용하나 |
|------|------|----------------|
| **Feature extraction** | 백본은 freeze, 마지막 classifier만 학습 | 데이터 적고 라벨 신뢰도 높을 때 |
| **Fine-tuning** | 백본 일부 or 전체 재학습 | 라벨 수 많고 task가 기존과 조금 다를 때 |
| **Zero-shot** | 학습 없이 inference만 | CLIP, GPT 같은 대규모 사전학습 모델에서 가능 |

---

### 🟢 예시 답안 (코드잇 제공)
>   - 전이 학습(Transfer Learning)이란 이미 학습된 모델의 가중치를 활용하여 새로운 데이터나 문제에 적용하는 기법입니다. 딥러닝 모델을 처음부터 학습하려면 많은 데이터와 연산 자원이 필요하지만, 전이 학습을 사용하면 기존에 학습된 지식을 재사용하여 적은 데이터로도 좋은 성능을 얻을 수 있습니다.  
이미지 분류 모델에서 전이 학습을 활용하는 방법은 크게 두 가지가 있습니다.
  - 첫 번째는 특징 추출(Feature Extraction) 방식입니다. 사전 학습된 모델의 합성곱 층(Convolutional Layers)은 일반적인 이미지 특징(엣지, 패턴, 질감 등)을 잘 학습하고 있기 때문에, 이 부분을 그대로 사용하고 마지막 분류 층(Fully Connected Layer)만 새롭게 학습하는 방법입니다. 예를 들어, ResNet이나 VGG 같은 사전 학습된 모델을 로드한 후, 마지막 출력 층만 교체하고 새로운 데이터셋에 맞춰 학습시키는 방식이 이에 해당합니다.
  - 두 번째는 미세 조정(Fine-Tuning) 방식입니다. 이 방법은 사전 학습된 모델을 일부 수정하여 새로운 데이터에 맞춰 추가 학습하는 방식입니다. 특정 층(예: 상위 몇 개 층)은 고정하고, 나머지 층들은 새로운 데이터에 맞춰 학습할 수 있도록 설정하여 모델이 기존의 일반적인 특징뿐만 아니라 새로운 데이터셋의 특징도 학습할 수 있도록 합니다.  
  - 전이 학습은 특히 의료 영상 분석, 소규모 데이터셋을 활용한 산업별 특화 모델, 객체 탐지(Object Detection) 등의 다양한 이미지 분석 분야에서 널리 사용됩니다. 기존의 대규모 데이터셋(예: ImageNet)에서 학습된 모델을 활용함으로써, 학습 시간을 단축하고 일반화 성능을 높이는 데 큰 장점이 있습니다.