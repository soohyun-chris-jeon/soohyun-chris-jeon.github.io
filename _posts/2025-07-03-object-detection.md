---
layout: post
title:  "Object Detection 분야의 근간이 되는 Faster R-CNN"
date:   2025-07-03 10:00:00 +0900
categories: [git]
tags: [R-CNN, Object detection, PyTorch, CNN, convolutional-neural-network, Deep Learning, AI, Computer Vision]
pin: false
comments: true     # 댓글 기능 사용 (옵션)


---
## 🟣  Intro
**Object detection**은 딥러닝 task에서 기본적이지만 가장 널리 쓰이고 있을 정도로 중요한 task이다. 특히 `YOLO`라는 논문은 굉장히 유명했지만 완전하게 이해할만한 기회는 없었는데, 이번 기회에 차근차근 object detection을 한번 정리해보려한다.

#### ⚪ Object detection이란?

> **Object detection = Classification + Regression**

- 두 가지가 합쳐진 약간의 복잡한 task라고 정의할 수 있다. 그러니까 주어진 이미지가 고양이인지 강아지인지 분류(**classification**)를 해야하고 그리고 위치(localization) 정보(x,y,w,h)도 추론(**regression**)할 수 있어야해서 2개의 task가 합쳐있다고 볼 수 있다.

- 그래서 이 task의 특징은 두 가지의 목적을 갖는 loss 형태를 띄고 있다.
    1) classification loss: BCE, softmax 등
    2) regression loss: MSE, L1


#### ⚪ R-CNN의 발전 과정

##### 🟡 핵심 아이디어

>  "이미지 전체⭐를 무작정 훑지 말고, '객체가 있을 만한 후보 영역(Region Proposal)'들만 뽑아서 CNN으로 분류하자!"

![R-CNN 계열](https://wikidocs.net/images/page/136494/RCNN2.png)

##### 🟡 (1) R-CNN (Regions with CNN Features). 2014
*"일단 후보부터 뽑고, 하나씩 CNN 돌려보자"*
    - Region Proposal -> **Feature Extraction** -> Classification & Bounding Box Regression
    - 느린 속도, 복잡한 학습과정(SVM, CNN, BB Regressor)

##### 🟡 (2) Fast R-CNN, 2015
*"CNN은 한 번만! 피처맵에서 특징을 뽑자"*
    - **통합 Feature Extraction** -> Region Proposal -> **RoI Pooling** -> **통합 예측기**


##### 🟡 (3) Faster R-CNN, 2015
 *"후보 뽑는 것까지 딥러닝으로!*
    - **Region Proposal Network (RPN)** 도입 -> Anchor Box 개념 -> NMS (Non-Maximum Suppression)을 통해 최종 ROI 선별 -> **Fast R-CNN Detector**
    - 완전한 End-to-End 학습

 
🟣 마치며
그 동안 R-CNN이라는 패러다임에 대해서 진지하게 생각해보지 않았지만 object detection 