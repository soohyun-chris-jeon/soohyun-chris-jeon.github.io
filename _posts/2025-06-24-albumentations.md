---
layout: post
title:  "CV에서 강력한 Data Augmentation을 제공하는 Albumentations 패키지"
date:   2025-06-24 10:00:00 +0900
categories: [PyTorch, Albumentations]
tags: [Albumentations, Deep Learning, tensorboard, PyTorch]
pin: false
image:
    path: https://albumentations.ai/opengraph-image?adf77b6199288de1
comments: true     # 댓글 기능 사용 (옵션)


---
## 🟣 Albumentations

Computer Vision 프로젝트에서 Data Augmentation은 거의 필수인데, 그중에서도 **Albumentations**이라는 라이브러리에 대해 알게 됐다. 거의 모든 자료에서 Albumentations이 기존 torchvision의 상위호환이라는 평가가 많아서 이번 포스팅은 Albumentations의 특징을 깔끔하게 정리해보았다.


#### ⚪ `Albumentations` vs. `Torchvision`

| 특징 (Feature) | `Albumentations` | `Torchvision` |
|:---:|:---:|:---:|
| **주요 장점** | **빠른 속도**<br> 다양한 변환(Augmentation) 기법<br> **다양한 CV Task 지원** | PyTorch와의 **완벽한 호환성**<br> 간편한 사용법 |
| **처리 속도** | **매우 빠름** (OpenCV 기반 최적화) | 상대적으로 느림 (PIL 기반) |
| **지원 Task** | Classification, Object Detection,<br>Segmentation, Keypoint Detection 등 | 주로 Classification에 중점 |
| **입력 데이터 타입** | NumPy Array | PIL Image 또는 Tensor |
| **변환 가짓수** | 70개 이상의 다채로운 변환 | 기본적인 핵심 변환 위주 |
| **사용 편의성** | 직관적인 `Compose` API | PyTorch 사용자에게 매우 익숙함 |


-----

#### ⚪ 특징 1. 미친 듯이 빠른 속도

Albumentations의 가장 큰 장점은 **성능**이다. 내부적으로 `OpenCV`와 `Numpy`를 사용해서 최적화된 연산을 수행하기 때문에 다른 라이브러리(예: torchvision)보다 훨씬 빠름.

수백만 장의 이미지를 처리해야 하는 딥러닝 학습 과정에서 이 속도 차이는 전체 학습 시간을 크게 단축시킨다. 공식 벤치마크에서도 다른 라이브러리들을 압도하는 성능을 보여주고 있음

> **"Why Albumentations is faster"**
> Albumentations는 각 변환 함수를 고도로 최적화된 OpenCV 함수를 기반으로 구현했어. 또한, 여러 변환을 하나로 묶어 효율적으로 처리하는 `Compose` 기능 덕분에 이미지 데이터를 CPU와 GPU 메모리 사이에서 불필요하게 여러 번 복사하는 과정을 최소화했기 때문에 빠른 속도를 낼 수 있어. (출처: [Albumentations GitHub 페이지](https://www.google.com/search?q=https://github.com/albumentations-ai/albumentations))

-----

#### ⚪ 특징 2. 다양한 변환(Transform) 라이브러리

Albumentations는 정말 방대한 종류의 이미지 변환 기법을 제공한다. 간단한 변환부터 딥러닝 모델의 강건함(robustness)을 높여주는 복잡한 변환까지 모두 갖추고 있다.

  * **픽셀 레벨 변환 (Pixel-level transforms)**: 밝기/대비 조절(`RandomBrightnessContrast`), 채도 변경, 블러(`Blur`), 노이즈 추가(`GaussNoise`), 이미지 압축 아티팩트 흉내(`JpegCompression`) 등 픽셀 값 자체를 바꾸는 변환 기법.
  * **공간 레벨 변환 (Spatial-level transforms)**: 이미지의 기하학적 구조를 바꾸는 변환 기법. 크기 조절(`Resize`), 회전(`Rotate`), 뒤집기(`Flip`), 잘라내기(`RandomCrop`), 왜곡(`ElasticTransform`, `GridDistortion`) 등이 포함됨.
  * **독특하고 강력한 변환들**:
      * **Cutout / CoarseDropout**: 이미지의 특정 영역을 랜덤하게 검은 사각형으로 지워서 모델이 이미지의 전체적인 맥락을 보도록 유도함.
      * **MixUp / CutMix**: (엄밀히는 라이브러리 외부에서 구현하지만) Albumentations와 함께 자주 쓰이는 기법으로, 두 이미지를 섞어서 새로운 학습 데이터를 만들어낸다.
      * **GridMask**: 이미지에 바둑판 모양으로 구멍을 뚫는 기법임.

이렇게 다양한 변환을 조합하면 훨씬 더 일반화 성능이 높은 모델을 만들 수 있다.

-----

#### ⚪ 특징 3. 어떤 CV 태스크에도 적용 가능한 범용성 🧩

이게 Albumentations의 또 다른 핵심 장점이야. 단순히 이미지만 변환하는 게 아니라, 그에 맞춰 **레이블(Label)까지 알아서 함께 변환**해준다.

  * **이미지 분류 (Image Classification)**: 이미지만 변환하면 되므로 가장 간단함.
  * **객체 탐지 (Object Detection)**: 이미지를 회전하거나 자르면, 이미지 내의 **바운딩 박스(Bounding Box) 좌표도 그에 맞게 자동으로 변환**해줌. 일부가 잘려나간 박스는 알아서 처리해줌.
  * **이미지 분할 (Semantic Segmentation)**: 이미지를 변환할 때, 픽셀 단위의 정답 레이블인 **마스크(Mask) 이미지도 동일한 방식으로 변환**해줌.
  * **키포인트 탐지 (Keypoint Detection)**: 사람의 관절 위치 같은 **키포인트 좌표들도 이미지 변환에 맞춰 함께 변환**해줌.

이런 기능 덕분에 어떤 CV 태스크를 하든 일관된 API로 데이터 증강 파이프라인을 쉽게 구축할 수 있다. `Compose` 함수 안에 변환하고 싶은 기법들을 리스트로 넣고, 이미지와 함께 바운딩 박스나 마스크를 전달하기만 하면 끝이다.

```python
import albumentations as A

# 변환 파이프라인 정의
transform = A.Compose([
    A.RandomCrop(width=256, height=256),
    A.HorizontalFlip(p=0.5),
    A.RandomBrightnessContrast(p=0.2),
], bbox_params=A.BboxParams(format='yolo')) # 바운딩 박스도 함께 변환하도록 설정

# 이미지와 바운딩 박스 변환
transformed = transform(image=image, bboxes=bboxes)
transformed_image = transformed['image']
transformed_bboxes = transformed['bboxes']
```

## 🟣 결론

이런 특징들 때문에 `Albumentations`는 Kaggle 같은 CV 경진대회에서는 거의 표준처럼 사용되고 있고, 산업 현장이나 학계 연구에서도 널리 쓰이고 있다. CV 프로젝트를 한다면 이제부터 `torchvision`보다 `Albumentations`위주로 세팅하는 것을 추천!