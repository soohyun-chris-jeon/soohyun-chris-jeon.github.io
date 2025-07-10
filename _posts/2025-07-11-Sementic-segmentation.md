---
layout: post
title:  "9-(1) Semantic Segmentation이란 무엇이며, 이미지 분류(Classification)와 어떤 차이가 있나요?"
date:   2025-07-11 10:00:00 +0900
categories: [Codeit AI 3기, Weekly Paper]
tags: [Semantic Segmentation, Classification, CNN, convolutional-neural-network, Deep Learning, AI, Computer Vision]
comments: true     # 댓글 기능 사용 (옵션)
math: true  # ✅ 요거 꼭 추가!


---


### 🟢 Semantic Segmentation

#### ⚪ 

### 🟢 예시 답안 (코드잇 제공)
>  - Semantic Segmentation이란 이미지 내 각 픽셀에 대해 특정 클래스를 할당하는 작업을 의미합니다. 즉, 이미지 속의 모든 픽셀이 어떤 객체나 배경에 속하는지를 분류하는 것입니다.
- Semantic Segmentation과 이미지 분류(Classification)의 가장 큰 차이점은 출력 형태입니다. 이미지 분류는 입력 이미지 전체에 대해 단 하나의 클래스를 예측하는 반면, Semantic Segmentation은 픽셀 단위로 분류를 수행합니다. 예를 들어, 개와 고양이가 함께 있는 사진을 이미지 분류 모델에 입력하면 "개" 또는 "고양이" 중 하나로 분류될 수 있습니다. 하지만 Semantic Segmentation 모델은 이미지의 모든 픽셀을 분석하여 개의 영역과 고양이의 영역을 각각 분리하여 표시할 수 있습니다.
- Semantic Segmentation은 자율주행(차선 및 보행자 감지), 의료 영상 분석(암 조직 탐지), 위성 영상 처리(토지 유형 분류) 등 다양한 분야에서 활용됩니다. 픽셀 단위로 정확한 영역을 식별할 수 있어, 물체의 경계를 정확히 구별해야 하는 작업에서 특히 중요한 역할을 합니다.

