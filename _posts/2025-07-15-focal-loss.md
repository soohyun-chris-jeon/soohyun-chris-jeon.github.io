---
layout: post
title:  "Focal loss에 관하여"
date:   2025-07-15 11:00:00 +0900
categories: [Deep Learning, Generative Model]
tags: [Semantic Segmentation, Generative Model, PyTorch, CNN, convolutional-neural-network, Deep Learning, AI, Computer Vision]
comments: true     # ✅ 댓글 기능 사용 (옵션)
image:
  path: assets/img/focal.png
#   alt: 나의 멋진 썸네일 이미지
#   lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD... # 여기에 base64 코드를 넣어
#   shadow: true # 그림자 효과 켜기
math: true  # ✅ 요거 꼭 추가!
---

---

## 🟣  'Focal Loss' for Semantic Segmentation

#### ⚪ Focal Loss란?


딥러닝에서 가장 기본적인 loss 함수 중 하나는 **Cross Entropy Loss**다. 하지만 다음과 같은 상황에서는 성능이 떨어질 수 있다:

- **Class imbalance**가 심한 경우 (예: 배경 vs. 소수 클래스)
- 모델이 쉬운 예시(easy examples)에 너무 집중하고, 어려운 예(hard examples)를 무시할 때

이럴 때 등장하는 게 바로 **Focal Loss**이다.

> Focal Loss는 **어려운 예제(hard examples)**에 더 집중하도록 설계된 **Cross Entropy의 확장판**.

---

#### ⚪ 수식 정리

기본적인 Cross Entropy Loss는 다음과 같다:

$$
\text{CE}(p_t) = -\log(p_t)
$$

여기서:  
$p_t$는 정답 클래스에 대한 예측 확률 (0~1)

Focal Loss는 여기에 **조절 계수 modulating factor**를 곱해서, **쉬운 예제의 loss를 줄이고**, **어려운 예제의 loss는 유지**한다:

$$
\text{FL}(p_t) = -(1 - p_t)^{\gamma} \cdot \log(p_t)
$$
![Focal](https://substackcdn.com/image/fetch/$s_!8oIY!,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F3556b4a8-bead-41df-894f-38bcf5e29818_2738x1314.png)

여기서:
- $\gamma$는 focusing parameter (보통 2 사용)
- $(1 - p_t)^\gamma$는 예측이 쉬운 경우(= $p_t$가 클수록) loss를 줄이는 역할


---

#### ⚪ 해석 예시

| 상황             | $ p_t $ | Modulating Factor $ (1 - p_t)^\gamma $ | 결과                      |
|------------------|-----------|-----------------------------------------|---------------------------|
| 예측이 매우 정확함 | 0.95      | $ (1 - 0.95)^2 = 0.0025 $             | 거의 무시됨               |
| 예측이 매우 틀림  | 0.1       |  $(1 - 0.1)^2 = 0.81 $                | 강하게 페널티 부여       |

즉, **쉬운 샘플은 무시하고, 어려운 샘플에 집중한다!**

---

#### ⚪ PyTorch 코드 예시

```python
import torch
import torch.nn as nn
import torch.nn.functional as F

class FocalLoss(nn.Module):
    def __init__(self, gamma=2.0):
        super(FocalLoss, self).__init__()
        self.gamma = gamma
        self.ce = nn.CrossEntropyLoss(reduction='none')  # pixel별 loss 계산

    def forward(self, logits, targets):
        ce_loss = self.ce(logits, targets)  # shape: (B, H, W)
        pt = torch.exp(-ce_loss)            # pt = softmax score of true class
        focal_loss = ((1 - pt) ** self.gamma) * ce_loss
        return focal_loss.mean()
````

---

#### ⚪ 언제 사용하면 좋을까?

* **Semantic segmentation**에서 foreground 클래스가 매우 적을 때
* **Object detection** (ex: RetinaNet)에서도 Focal Loss가 공식적으로 사용됨
* 클래스 불균형이 심할수록 효과가 크다

---

## 🟣 정리

| 항목      | 내용                                      |
| ------- | --------------------------------------- |
| 이름      | Focal Loss                              |
| 공식      | $FL(p_t) = -(1 - p_t)^\gamma \log(p_t)$ |
| 하이퍼파라미터 | $\gamma \in [0, 5]$ (보통 2)              |
| 장점      | 어려운 샘플에 집중, 클래스 불균형 완화                  |
| 단점      | 일반적인 문제에서는 오히려 과적합을 유발할 수도 있음           |

---

##  Reference

* [Lin et al., "Focal Loss for Dense Object Detection", ICCV 2017](https://arxiv.org/abs/1708.02002)

