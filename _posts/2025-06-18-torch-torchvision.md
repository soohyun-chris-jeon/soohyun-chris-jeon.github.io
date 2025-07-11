---
layout: post
title:  "[PyTorch] 컴퓨터 비전의 동반자, torchvision"
date:   2025-06-18 10:00:00 +0900
categories: [PyTorch]
tags: [PyTorch, torch.torchvision, Machine Learning, Deep Learning, AI]
pin: false
comments: true     # 댓글 기능 사용 (옵션)


---
## 🟣 Intro
컴퓨터 비전(Computer Vision) 연구나 개발을 하다 보면, 데이터셋을 불러오고, 모델을 만들고, 이미지를 변형하는 등 반복적인 작업들이 많다. 

PyTorch는 이런 불편함을 덜어주기 위해 torchvision이라는 아주 유용한 라이브러리를 제공하는데 정작 제대로 알고 쓰는 느낌은 아니라서 이번 기회에 정리해보려고 한다.

#### ⚪ torchvision은 크게 세 가지 핵심 요소

1. **Models**: 사전 훈련된(pre-trained) 다양한 컴퓨터 비전 모델들

2. Datasets: 연구에 널리 쓰이는 표준 데이터셋

3. Transforms: 이미지 전처리(preprocessing) 및 증강(augmentation)을 위한 다양한 변환 기법들


## 🟣 요약
- nn.Module

