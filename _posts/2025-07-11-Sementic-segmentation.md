---
layout: post
title:  "9-(1) Semantic Segmentation이란 무엇이며, 이미지 분류(Classification)와 어떤 차이가 있나요?"
date:   2025-07-11 00:00:00 +0900
categories: [Codeit AI 3기, Weekly Paper]
tags: [Semantic Segmentation, Classification, CNN, convolutional-neural-network, Deep Learning, AI, Computer Vision]
comments: true     # 댓글 기능 사용 (옵션)
math: true  # ✅ 요거 꼭 추가!


---

## 🟢 Semantic Segmentation이란
Semantic Segmentation은 이미지에 있는 모든 픽셀(pixel)을 특정 클래스로 **분류(classification)**하는 작업

![sementic segmentation](https://www.hitechbpo.com/wp-content/uploads/2025/04/what-is-semantic-segmentation.jpg)


#### ⚪ Computer vision에서 나오는 주요 task와 비교

![segmentation](https://i0.wp.com/bdtechtalks.com/wp-content/uploads/2021/05/image-classification-vs-object-detection-vs-semantic-segmentation.jpg?resize=696%2C269&ssl=1)

| Task                      | 설명                       | 출력 형태                      |
| ------------------------- | ------------------------ | -------------------------- |
| **Classification**        | 이미지 하나가 어떤 클래스인지         | `class label`       |
| **Object Detection**      | 객체 위치(Bounding box)와 클래스 | `class label + bounding boxes `   |
| **Semantic Segmentation** | **픽셀 단위**로 클래스 지정        | `label map (HxW)`          |



#### ⚪ 대표적인 semantic segmentation 모델

- FCN (Fully Convolutional Network) ⭐⭐
- U-Net (의료 영상에 강력) ⭐
- DeepLab (v3, v3+)
- SegFormer, Mask2Former 등 transformer 기반 최신 모델들


##### (1) CNN 기반 시작 (2014~2016)
- FCN (2014): classification CNN → segmentation으로 확장
- U-Net (2015): skip-connection으로 localization 향상
- DeepLab v1~v2: dilation, CRF로 경계 보정

##### (2) Multi-scale & 구조 개선 (2016~2019)
- ASPP (DeepLab v2+): 다양한 리셉티브 필드 활용
- PSPNet: Pyramid 구조로 context 수용
- HRNet: high-res 유지한 채 multi-scale 처리

##### (3) Transformer 기반 등장 (2021~)
- SegFormer: CNN 없이 pure Transformer encoder + MLP decoder
- MaskFormer / Mask2Former: unified framework → semantic, instance, - panoptic segmentation 모두 처리 가능

#### ⚪ 요약 `Sementic Segmentation` vs. `Classification`

| 구분 | Image Classification | Semantic Segmentation |
| :--- | :--- | :--- |
| **목표** | 이미지 **전체**에 대한 단일 레이블 예측 | 이미지 내 **모든 픽셀**에 대한 클래스 예측 |
| **출력** | 클래스 이름 (e.g., "고양이") | 분할 마스크 (Segmentation Mask) |
| **정보의 수준**| "이미지에 무엇이 있는가?" (*What*) | "그것들이 어디에, 어떤 모양으로 있는가?" (*Where*) |
| **주요 아키텍처** | Fully Connected Layer로 클래스 확률 계산 | Fully Convolutional Network(FCN)로 공간 정보 유지 |
| **응용 분야** | 이미지 태깅, 콘텐츠 필터링 | 자율 주행, 의료 영상 분석 (종양 분할 등) |



### 🟢 예시 답안 (코드잇 제공)
>  - Semantic Segmentation이란 이미지 내 각 픽셀에 대해 특정 클래스를 할당하는 작업을 의미합니다. 즉, 이미지 속의 모든 픽셀이 어떤 객체나 배경에 속하는지를 분류하는 것입니다.
- Semantic Segmentation과 이미지 분류(Classification)의 가장 큰 차이점은 출력 형태입니다. 이미지 분류는 입력 이미지 전체에 대해 단 하나의 클래스를 예측하는 반면, Semantic Segmentation은 픽셀 단위로 분류를 수행합니다. 예를 들어, 개와 고양이가 함께 있는 사진을 이미지 분류 모델에 입력하면 "개" 또는 "고양이" 중 하나로 분류될 수 있습니다. 하지만 Semantic Segmentation 모델은 이미지의 모든 픽셀을 분석하여 개의 영역과 고양이의 영역을 각각 분리하여 표시할 수 있습니다.
- Semantic Segmentation은 자율주행(차선 및 보행자 감지), 의료 영상 분석(암 조직 탐지), 위성 영상 처리(토지 유형 분류) 등 다양한 분야에서 활용됩니다. 픽셀 단위로 정확한 영역을 식별할 수 있어, 물체의 경계를 정확히 구별해야 하는 작업에서 특히 중요한 역할을 합니다.

