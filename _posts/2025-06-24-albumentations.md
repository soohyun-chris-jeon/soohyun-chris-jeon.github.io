---
layout: post
title:  "Albumentations vs. torchvision"
date:   2025-06-24 10:00:00 +0900
categories: [Albumentations]
tags: [Albumentations, Deep Learning, tensorboard, PyTorch]
pin: false
comments: true     # 댓글 기능 사용 (옵션)


---
## 🟣 Albumentations


#### ⚪

| 특징 (Feature) | Albumentations | Torchvision |
|:---:|:---:|:---:|
| **주요 장점** | **빠른 속도**<br> 다양한 변환(Augmentation) 기법<br> **다양한 CV Task 지원** | PyTorch와의 **완벽한 호환성**<br> 간편한 사용법 |
| **처리 속도** | **매우 빠름** (OpenCV 기반 최적화) | 상대적으로 느림 (PIL 기반) |
| **지원 Task** | Classification, Object Detection,<br>Segmentation, Keypoint Detection 등 | 주로 Classification에 중점 |
| **입력 데이터 타입** | NumPy Array | PIL Image 또는 Tensor |
| **변환 가짓수** | 70개 이상의 다채로운 변환 | 기본적인 핵심 변환 위주 |
| **사용 편의성** | 직관적인 `Compose` API | PyTorch 사용자에게 매우 익숙함 |



