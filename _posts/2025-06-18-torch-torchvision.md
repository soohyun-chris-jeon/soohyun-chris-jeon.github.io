---
layout: post
title:  "[PyTorch] 컴퓨터 비전의 동반자, torchvision"
date:   2025-06-18 10:00:00 +0900
categories: [PyTorch]
tags: [PyTorch, torch.torchvision, Machine Learning, Deep Learning, AI]
pin: false
image:
    path: https://velog.velcdn.com/images/olxtar/post/869d2330-c718-49f1-b0d1-83604b6aebba/image.png
comments: true     # 댓글 기능 사용 (옵션)


---
## 🟣 Intro
컴퓨터 비전(Computer Vision) 연구나 개발을 하다 보면, 데이터셋을 불러오고, 모델을 만들고, 이미지를 변형하는 등 반복적인 작업들이 많다. 

PyTorch는 이런 불편함을 덜어주기 위해 torchvision이라는 아주 유용한 라이브러리를 제공하는데 정작 잘 알고 쓰지는 않기 때문에 이번 기회에 제대로 정리해보려고 한다.


---

#### ⚪ torchvision은 크게 세 가지 핵심 요소

1. **Models**: 사전 훈련된(pre-trained) 다양한 컴퓨터 비전 모델들

2. Datasets: 연구에 널리 쓰이는 표준 데이터셋

3. Transforms: 이미지 전처리(preprocessing) 및 증강(augmentation)을 위한 다양한 변환 기법들

---

#### ⚪ `torchvision.models`: 검증된 성능의 pretrained model

| 모델 분류 | 모델명 | 설명 |
| --- | --- | --- |
| **Image Classification** | `AlexNet`, `VGG`, `ResNet`, `SqueezeNet`, `DenseNet`, `Inception_v3`, <br> `GoogLeNet`, `ShuffleNetV2`, `MobileNetV2`, `MobileNetV3`, `ResNeXt`, <br> `Wide ResNet`, `MNASNet`, `EfficientNet`, `RegNet`, `VisionTransformer`, <br> `SwinTransformer` | 이미지 분류를 위한 다양한 아키텍처의 사전 훈련된 모델들. <br>ImageNet 데이터셋으로 학습된 가중치를 제공하여 전이 학습에 매우 유용함. |
| **Object Detection** | `Faster R-CNN`, `Mask R-CNN`, `RetinaNet`, `Keypoint R-CNN`, `FCOS`, `SSD`, `SSDLite` | 이미지 내의 객체 위치와 클래스를 예측하는 모델들.  <br>COCO 데이터셋으로 사전 훈련된 모델을 제공함. |
| **Semantic Segmentation** | `FCN`, `DeepLabV3`, `LRASPP` | 이미지의 각 픽셀이 어떤 클래스에 속하는지 예측하는 모델들. <br> COCO, Pascal VOC 등 다양한 데이터셋으로 사전 훈련됨. |
| **Video Classification** | `R(2+1)D`, `MC3`, `MViT` | 비디오 클립의 내용을 분류하는 모델들. Kinetics-400 데이터셋으로 사전 훈련됨. |
| **Optical Flow** | `RAFT` | 비디오의 연속된 프레임 간 픽셀의 움직임을 예측하는 모델. |

---

#### ⚪ `torchvision.datasets`: CIFAR10부터 ImageNet까지

| 데이터셋 분류 | 데이터셋명 | 설명 |
| --- | --- | --- |
| **Image Classification** | `MNIST`, `Fashion-MNIST`, <br>`KMNIST`, `EMNIST`, `QMNIST`,<br> `FakeData`, `CIFAR10`, <br> `CIFAR100`, `ImageNet`,<br> `Caltech101`, `Caltech256`,<br> `CelebA`, `Cityscapes`, <br> `Country211`, `DTD`, <br>`FGVCAircraft`, `Flowers102`, `Food101`, <br>`GTSRB`, `INaturalist`, <br> `LFWPeople`, `LSUN`, `OxfordIIITPet`, <br>`PCAM`, `Places365`, `RenderedSST2`, <br> `SEMEION`,`STL10`, <br>`SVHN`, `StanfordCars`, <br>`USPS`, `VOCDetection`, <br> `VOCSegmentation` | 이미지 분류 및 기타 비전 태스크를 위한 표준 데이터셋. <br> 대부분 자동으로 다운로드 및 전처리를 지원함. |
| **Video** | `HMDB51`, `Kinetics`, `UCF101` | 비디오 분류 연구에 사용되는 데이터셋. |
| **Stereo Vision** | `Kitti`, `FlyingChairs`, `FlyingThings3D` | 스테레오 매칭 및 깊이 추정 연구를 위한 데이터셋. |
| **Other** | `CocoCaptions`, `CocoDetection`, <br>`Flickr8k`, `Flickr30k`, `SBUCaptions` | 이미지 캡셔닝, 객체 탐지 등 특정 태스크를 위한 데이터셋. |

---

#### ⚪ `torchvision.transforms`: 학습에 있어서 필수 Data Augmentation

| 변환 종류 | 함수명 | 설명 |
| --- | --- | --- |
| **Tensor 변환** | `ToTensor()` | PIL Image 또는 NumPy `ndarray`를 `FloatTensor`로 변환하고, 픽셀 값을 [0., 1.] 범위로 스케일링함. |
| **크기 조절** | `Resize(size)`, `Scale(size)` | 이미지의 크기를 `size`로 조절함. |
| **자르기(Cropping)** | `CenterCrop(size)`, `RandomCrop(size)`, <br>`RandomResizedCrop(size)`, `FiveCrop(size)`, <br>`TenCrop(size)` | 중앙, 무작위, 무작위 크기 조절 후 자르기 등 다양한 방식으로 이미지를 잘라냄. |
| **뒤집기(Flipping)** | `RandomHorizontalFlip(p=0.5)`, <br> `RandomVerticalFlip(p=0.5)` | 주어진 확률로 이미지를 수평 또는 수직으로 뒤집음. (데이터 증강에 주로 사용) |
| **색상 변환** | `ColorJitter(brightness, contrast, saturation, hue)`,<br> `Grayscale(num_output_channels)`, <br>`RandomGrayscale(p=0.1)` | 밝기, 대비, 채도, 색조를 무작위로 변경하거나 흑백으로 변환함. |
| **정규화** | `Normalize(mean, std)` | 텐서 이미지를 주어진 평균과 표준편차로 정규화함. `T_norm = (T - mean) / std` |
| **기타 변환** | `RandomRotation(degrees)`, <br>`RandomAffine(degrees, translate, scale, shear)`, <br>`RandomPerspective(distortion_scale, p)` | 회전, 아핀 변환, 원근 변환 등 기하학적 변환을 무작위로 적용함. |
| **변환 조합** | `Compose(transforms)` | 여러 변환(transform)들을 순서대로 실행하는 파이프라인을 생성함. |
| **타입 변환** | `ToPILImage()` | 텐서나 `ndarray`를 PIL Image로 변환함. |
| **패딩** | `Pad(padding, fill, padding_mode)` | 이미지의 가장자리에 패딩을 추가함. |

---

## 🟣 요약

torchvision은 그 자체의 개념보다 그 기능들의 리스팅이 중요한 것 같다. 

딥러닝 연구를 위해서 3가지 편리한 기능을 제공해준다는 것을 알고 있자.

