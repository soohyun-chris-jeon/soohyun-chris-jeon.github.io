---
layout: post
title:  "4-(2) 딥러닝의 성능향상을 위해 고려하는 하이퍼파라미터의 종류"
date:   2025-06-06 16:00:00 +0900
categories: [Codeit AI 3기, Weekly Paper]
tags: [Supervised Learning, Unsupervised Learning, Machine Learning, Deep Learning, AI]
comments: true     # 댓글 기능 사용 (옵션)

---

## (2) 딥러닝의 성능향상을 위해 고려하는 하이퍼파라미터의 종류에는 어떤 것들이 있는지 설명해주세요.

#### 예시 답안 (코드잇 제공)

> 딥러닝의 성능을 향상시키기 위해 조정할 수 있는 하이퍼파라미터에는 크게 모델 구조, 학습 과정, 정규화 관련 하이퍼파라미터가 있습니다. 
먼저 모델 구조와 관련된 하이퍼파라미터로는 레이어의 수와 뉴런의 개수가 있습니다. 예를 들어, 레이어 수가 너무 적으면 과소적합될 가능성이 있고, 너무 많으면 과적합이 발생할 수 있으므로 적절한 모델 크기를 설정하는 것이 중요합니다. 또 다른 예로 활성화 함수는 ReLU, sigmoid, tanh 등 여러 종류가 있는데, 문제의 특성과 데이터의 분포에 따라 적절히 선택해야 합니다. 
다음으로 학습 과정과 관련된 하이퍼파라미터에는 학습률과 배치 크기가 있습니다. 학습률은 모델의 학습 속도를 조정하는데, 값이 너무 크면 발산할 수 있고, 너무 작으면 학습 속도가 느려질 수 있습니다. 배치 크기는 한 번의 학습에서 처리하는 데이터 샘플의 수를 의미하며, 이를 조정함으로써 학습 속도와 모델의 안정성 사이의 균형을 맞출 수 있습니다. 
마지막으로 정규화와 관련된 하이퍼파라미터로는 드롭아웃 비율과 L1/L2 정규화가 있습니다. 드롭아웃은 과적합을 방지하기 위해 일부 뉴런을 랜덤하게 제거하는 방식이고, L1/L2 정규화는 가중치 크기를 제한하여 모델의 복잡도를 줄이는 역할을 합니다.