---
layout: post
title:  "7-(1) 이미지를 모델에 입력하기 전에 리사이징(Resizing)과 정규화(Normalization)를 하는 이유는 무엇인가요?"
date:   2025-06-27 10:00:00 +0900
categories: [Codeit AI 3기, Weekly Paper]
tags: [Resizing, Normalization, PyTorch, CNN, convolutional-neural-network, Deep Learning, AI, Computer Vision]
comments: true     # 댓글 기능 사용 (옵션)

---


### 🟢 7-(1). 리사이징(Resizing)과 정규화(Normalization)를 하는 이유?

#### 🟡 Resizing ?

- **모델 사전 학습 구조와 일치**: 사전 학습(pretrained)된 모델은 특정 크기(예: ImageNet 기준 224×224)로 학습되었기 때문에 동일한 입력 크기가 필요함.

- **데이터를 통일시킴**: 동일하지 않은 size에 대해서 데이터의 사이즈를 맞춰서 같은 모델에 학습이 가능하도록 함 (과제#5)

- **메모리와 연산 효율성**: 지나치게 큰 이미지는 연산 비용이 증가하므로, 적절한 크기로 줄이는 것이 중요.

![downsizing](https://lh7-rt.googleusercontent.com/docsz/AD_4nXdiIquu-HG9VOvRkRF77oQTAVo5zrqyMiqv_nNjD0s-cdITDyRABRZUZ3uJkdsj2QbfWkIUSXwbQ9HfNOoGeuvkB1mQpkbZegs3Zw9pArtr4nU1ObwgJ40z-ZOIsrlZomPAEvDnHISXZFd1CHcZb2v_ombo3fXtB3U49VYpaEi_qc4eGFWXPDs?key=uEmuBJpB05J9QlNdDSHDGw)


![upsizing](https://lh7-rt.googleusercontent.com/docsz/AD_4nXebc5xxGUkDgO9Rfp_78VuVw5Ms6wcF684ACgz6wukyKRxFxQOERHS56uNUvmKCWNmDpaNNXzqrSUgzNX2dnSoWdhCO-YEkH77dmvwTKFjjMbn4CmlqfZaz59LZafP3kX88CTqyQ0blKH1RGc_epRli_luq891cwC6CzEwQ5WgEIPPDdwttgw?key=uEmuBJpB05J9QlNdDSHDGw)



#### 🟡 Normalization ?
- **픽셀 값의 스케일 조정**: 일반적으로 픽셀 값은 [0, 255] 범위에 있으므로, 이를 [0, 1] 또는 평균 0, 표준편차 1 범위로 조정.
- 학습 데이터와 label의 데이터 값이 다르지만 같은 분포를 갖고 있다면 일반화 성능을 낼 수 있게 해줌
- **학습 안정성 증가**: 입력 값이 너무 크거나 작으면 Gradient Descent 과정에서 학습이 불안정해질 수 있음.

![normalization](https://i.ytimg.com/vi/HRsCGOUgiGA/maxresdefault.jpg)
> 딥러닝에서 중요한 건 입력의 절대 스케일보다는, 데이터가 가지는 분포의 균형과 정규성이다.
 Ioffe & Szegedy (2015)


#### 🟢 예시 답안 (코드잇 제공)
>  - 딥러닝 모델에 이미지를 입력하기 전에 리사이징(Resizing)과 정규화(Normalization)를 하는 이유는 모델 학습의 효율성과 성능을 높이기 위해서입니다.  
  - 먼저, 리사이징(Resizing)은 모든 입력 이미지의 크기를 통일하기 위해 필요합니다. 딥러닝 모델은 고정된 크기의 입력을 받도록 설계되므로, 다양한 크기의 이미지를 일관된 형태로 맞춰야 합니다. 예를 들어, ResNet과 같은 사전 학습된 모델은 일반적으로 224x224 크기의 이미지를 입력으로 받습니다. 따라서, 모델이 학습할 수 있도록 모든 이미지를 동일한 크기로 변환해야 합니다.  
  - 다음으로, 정규화(Normalization)는 이미지의 픽셀 값 범위를 조정하는 과정입니다. 일반적으로 이미지의 픽셀 값은 0에서 255 사이의 정수값을 가지는데, 이를 [0, 1] 범위 또는 평균을 0, 표준편차를 1로 조정하는 방식으로 정규화합니다. 이렇게 하면 모델이 더 안정적으로 학습할 수 있으며, 특히 경사 소실(vanishing gradient) 문제를 완화하는 데 도움이 됩니다. 또한, 정규화를 통해 데이터의 분포를 일정하게 맞춰주면 모델이 특정 값 범위에 편향되지 않고 더 효과적으로 특징을 학습할 수 있습니다.  
  - 결론적으로, 리사이징은 입력 형태를 맞춰주고, 정규화는 학습을 안정적으로 진행하도록 도와주는 과정이라고 볼 수 있습니다.