---
layout: post
title:  "[Part 2] Study log 2025.06.09 ~ 08.14  "
date:   2025-06-09 10:00:00 +0900
categories: [Codeit AI 3기, Study log]
tags: [python, Deep Learning, PyTorch, numpy]
image:
  path: https://img1.daumcdn.net/thumb/R750x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2F4qgsr%2FbtsFEtondnt%2FXoFKqUvKEaFyQubZZyLIPk%2Fimg.png

comments: true     # 댓글 기능 사용 (옵션)

---


<!-- 
![코드잇 스프린트](https://img1.daumcdn.net/thumb/R750x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2F4qgsr%2FbtsFEtondnt%2FXoFKqUvKEaFyQubZZyLIPk%2Fimg.png)
 -->
# 🟣 2025.06.09 ~ 2025.08.14의 기록 


## 2025-06-09 Mon
#### 🟡 Git은 파일 시스템 변화를 감지하긴 하지만, 추적하지는 않음

- Git에서 "감지"와 "추적"의 차이

### 🔍 의미 분석
- **감지(detect)**: `git status` 명령으로 새 파일이나 수정된 파일을 보여줄 수 있음
- **추적(tracked)**: Git이 해당 파일을 버전 관리 대상으로 삼는 것 (커밋에 포함될 수 있음)


| 작업    | Git이 하는 일   | 우리가 해야 할 일                                        |
| ----- | ----------- | ------------------------------------------------- |
| 파일 수정 | 변경사항 감지     | `git add`로 staged                                 |
| 파일 추가 | 새 파일 감지     | `git add 새파일`                                     |
| 파일 삭제 | 삭제 감지       | `git rm 삭제된파일`                                    |
| 파일 이동 | 삭제 + 추가로 인식 | `git mv 원래경로 새경로` 또는 `git add 새파일 && git rm 원래파일` |

```bash
git add test.txt  # test.txt는 staged 상태
git status 
git commit ...  # commit으로 tracked 상태
```


- `git status`를 항상 주시하면 무슨 일이 벌어졌는지 정확하게 알 수 있다.

- `Staged`는 커밋하기 전에 변경 사항을 임시 저장하는 상태


## 2025-06-10 Tue
#### `np.unique`


## 2025-06-11 Wed
#### ⚪ `torch.Tensor` vs `np.array`  
| 요약    | 내용                                               |
| ----- | ------------------------------------------------ |
| 공통점   | 다차원 배열, 벡터화, 브로드캐스팅, dtype 설정, 서로 변환 가능          |
| 차이점   | **PyTorch는 autograd + GPU 지원**, NumPy는 일반 수치 계산용 |
| 실전 사용 | 딥러닝 모델 학습시 `torch.Tensor` 써야 함                 |

- torch.tensfor()
```py
print(f'data type: {tensor.dtype}')
print(f'number of dimensions: {tensor.ndim}') # []의 수로 표현하면 쉬움
print(f'shape: {tensor.shape}') 
print(f'size: {tensor.size()}') # shape이나 size나 같음
```

- `torch.tensor` vs. `torch.from_numpy()`

`torch.from_numpy()`는 메모리를 공유❗하니 주의!

- `torch.rand(2, 3)` : 0~1 사이에서 균등 분포
- `torch.randn(2, 3)` : 정규분포에서 값 추출
- `torch.zeros(2, 3)` : 0으로 채움
- `torch.ones(2, 3)` : 1로 채움
- `torch.full((2, 3), 7)` : 특정 값(7)로 채움


#### ⚪ 딥러닝 모델링 시 고려할 사항:
1) Batch size
2) Learning rate
3) epoch



## 2025-06-12 Thu

#### 🔴 Denoising Dirty Documents 데이터셋(Kaggle)
[Denoising Dirty Documents](https://www.kaggle.com/competitions/denoising-dirty-documents)

- Denoising-AE 과제

## 2025-06-13 Fri
#### ⚪ 활성화 함수(activation function)
1) Sigmoid: 초기 신경망. gradient 소실 문제가 있음
2) Tanh: 시그모이드의 변형. 여전히 gradient vanishing 문제가 있음
3) ReLU: 현대 신경망에서 가장 인기 있음. gradient의 감소가 없어서 소실 문제가 해결됨
4) Leaky ReLU: 


## 2025-06-16 Mon
#### ⚪ `torchvision.transforms` 

#### ⚪ Gradient descent
1) Batch Gradient Descent: 전체 batch_size. 계산 비용 매우 높다
2) Stochastric Gradient Descent: 무작위로 1개의 샘플(batch_size=1). 학습이 불안정. 
3) Minibatch Gradient Descent⭐: mini-batch로 학습. 가장 많이 쓰임. 메모리 효율성

## 2025-06-17 Tue
#### ⚪ 로컬 전용 WSL 서버 구축하기

#### ⚪ 다양한 optimizer
 - Momentum: 이전 스텝에 대한 학습률 고려
 - Adagrad: 각 매개변수에 대해 학습률을 동적으로 변경
 - RMSProp: 과거의 기울기는 조금만 반영하고, 최신의 기울기를 많이 반영
 - Adam⭐: 가장 보편적으로 쓰임. 모멘텀 기반과 RMSProp의 방법을 절충 



## 2025-06-18 Wed
#### .gitignore
#### ⚪ Normalization 기법
- 데이터의 범위를 일정하게 조정하거나 데이터의 분포를 표준화하는 과정
- 모델이 local minima에 갇히는 문제를 완화
- 학습을 더 안정적이고 빠르게 진행되도록 함
- 입력의 분포가 각 층을 지날 때마다 일정하게 유지되도록 함
- Batch Normalization⭐: 네트워크의 각 층에서 활성화 함수가 입력 받는 값을 정규화
  * 각 레이어를 거치며 발생할 수 있는 입력값의 변동을 효과적으로 제어
  * 결과적으로 학습 속도를 높이며 더 안정적인 학습이 가능
  * 그래디언트 소실, 폭발 문제를 완화

  #### ⚪ Regualization 기법
- 모델이 훈련데이터에 과적합되지 않고 일반화 성능을 끌어올리는 방식
1) L1 정규화
2) Dropout ⭐
3) Early Stopping ⭐  
4) Data Augmentation ⭐⭐⭐

## 2025-06-19 Thu
#### ⚪ Data Augmentation: 데이터 증강
- 다양한 훈련 샘플을 생성해 학습 효율을 증가
- 데이터 불균형 문제 해결
- 이미지 rotation, crop, scaling 등...

## 2025-06-20 Fri
#### ⚪ `torch.utils.data`의 Dataset 클래스(사용자 정의 클래스) (From [파이토치 공식문서](https://tutorials.pytorch.kr/beginner/basics/data_tutorial.html) )
- __init__, __len__, and __getitem__  3가지 메서드를 반드시 정의해야한다.
  - **\__init__** 함수는 Dataset 객체가 생성(instantiate)될 때 한 번만 실행됩니다. 여기서는 이미지와 주석 파일(annotation_file)이 포함된 디렉토리와 두가지 변형(transform)을 초기화합니다.
  
  - **\__len__** 함수는 데이터셋의 샘플 개수를 반환합니다.

  - **\__getitem__** 함수는 주어진 인덱스 idx 에 해당하는 샘플을 데이터셋에서 불러오고 반환합니다. 인덱스를 기반으로, 디스크에서 이미지의 위치를 식별하고, read_image 를 사용하여 이미지를 텐서로 변환하고, self.img_labels 의 csv 데이터로부터 해당하는 정답(label)을 가져오고, (해당하는 경우) 변형(transform) 함수들을 호출한 뒤, 텐서 이미지와 라벨을 Python 사전(dict)형으로 반환합니다.

#### ⚪ torch의 브로드캐스팅이란?
- tensor의 size가 달라도 연산이 가능하게끔 구현해놓음 

```py
a = torch.tensor(
    [
        [1, 2, 3],
        [4, 5, 6],
    ]
)
b = torch.tensor(
    [1, -1, 2],
)

a + b 
"""
결과는
tensor([[2, 1, 5],
        [5, 4, 8]]) a의 각 행에 b가 더 해짐
""" 
```

- 그러나 모든 tensor에 적용되는 것은 아니고 각 벡터의 length가 다르면 브로드캐스팅이 불가능!


#### ⚪ nn.Conv2d()에 padding 값을 '`valid`'나 '`same`'으로 할 때 각각 패딩이 어떻게 적용되는지
- `valid`는 padding을 따로 주지 않고 input image 자체만을 이용해 convolution 연산을 수행한다.
- `same`은 output size가 input size와 동일하게 되도록 padding을 조절한다. 만약 stride=1, dilation=1인 경우 padding=(kernel_size-1)/2로 설정된다.

## 2025-06-23 Mon
#### ⚪ 딥러닝 모델의 최적화가 어려운 이유
1) 모델의 비선형성: 손실 함수의 표면을 복잡하게 만들어 Global Minima를 찾기 어렵게 함.
2) 고차원성과 과적합: 과적합 문제를 위해서 다양한 기법 사용해야함
3) gradient 소실 문제
4) hyper parameter의 민감성

> GPT3의 num of parameter: 1,750억 개;;


#### ⚪ torch.tensor의 shape 바꾸기
- `torch.reshape()`: torch.reshape(-1)
- `torch.permute()` 텐서 차원 바꾸기
- `torch.squeeze()`: 차원이 1인 것 없애기 <-> torch.unsqueeze()


#### ⚪ torch의 `view()` vs. `reshape()`
- `reshape()`은 기본적으로 copy⭐가 일어남. 원본엔 영향 x
- 메모리의 연속성(contiguous) 개념



## 2025-06-24 Tue
- torch 합: `+` 연산자
  torch 곱: `@`(매트릭스곱) vs. `*`(스칼라곱)


#### 🔴 [Chest X-Ray Images (Pneumonia)](https://www.kaggle.com/datasets/paultimothymooney/chest-xray-pneumonia) 데이터셋 (Kaggle)


## 2025-06-25 Wed
#### 🔴 [CaliforniaHousingDataset](https://www.kaggle.com/datasets/camnugent/california-housing-prices) 데이터셋 (Kaggle)
`torch.utils.data.Dataset`를 상속받는 클래스는 반드시 이 3가지 특별 메소드⭐를 구현해야함.
```py
from torch.utils.data import Dataset
# pytorch의 Dataset 객체 만들기
class CaliforniaHousingDataset(Dataset):
  def __itit__():
    pass
  def __len__():
    pass
  def __getitem()__:
    pass

```

또한 `torch.utils.data.DataLoader`으로 감싸서 batch 단위로 데이터 처리가 가능하다. 
## 2025-06-26 Thu
#### ⚪ torch.nn
- `torch.nn` 패키지는 뉴럴네트워크와 관련된 모듈를 모아놓은 패키지.
  * 레이어(layers): `nn.Linear()`, `nn.Conv2d()` 등
  * 활성화 함수(Activation function): `nn.ReLU()` 등
  * 손실함수(loss function): `nn.MSELoss()` 등

- `torch.nn` vs. `torch.nn.functional`
  * **torch.nn**: 상태(State)를 가짐. nn.Linear, nn.Conv2d처럼 학습해야 할 가중치(weight, bias)를 내부 상태로 가지고 있음. 그래서 *__init__*에서 미리 정의하고 재사용하는 방식. layer 모듈 방식
  * **torch.nn.functional**: 상태가 없음(Stateless). `relu()`, `max_pool()`, `softmax()`처럼 학습할 파라미터가 없는 순수 함수들의 모음. 입력이 들어가면 정해진 계산을 거쳐 출력을 낼 뿐, 내부적으로 저장하는 값이 없음. function 방식
  * 이러한 둘의 차이는 코드의 가독성과 스타일에 따른 선택의 문제이기도 합니다.

- 상태(state)를 가진다? `model.train()`인지 `model.eval()`인지. 즉, state를 갖는 모듈은 코드의 안정성이 높일 수 있음
- `nn.Sequential`을 사용하려면 모듈 방식은 필수임.

## 2025-06-27 Fri
#### ⚪ torch.tensor의 차원
- 축(axis) 개수
- 또는 tensor.ndim은 len(tensor.shape)과 같음
- 이미지 배치 텐서 (B, C, H, W): pytorch는 기본적으로 차원이 1만큼 더 추가된다. BCHW(Batch, Channel, Height, Width) 구조로 나타낼 수 있다


## 2025-06-30 Mon
#### ⚪ v2.ToTensor() 경고의 의미와 해결책

이 경고는 torchvision의 transforms.v2 버전부터 데이터 변환 방식이 더 명확하고 세분화되었기 때문에 나타남

과거의 ToTensor()는 두 가지 일을 한 번에 했는데
  1. PIL 이미지나 NumPy 배열을 PyTorch 텐서로 변환.
  2. 픽셀 값의 범위를 [0, 255]에서 [0.0, 1.0]으로 정규화(scaling).

이걸 더 명확하게 분리하기 위해, v2 버전부터는 아래의 두 단계로 나누어 사용하도록 권장하고 있음
  - `v2.ToImage()`: 이미지를 PyTorch 텐서로 변환하는 역할만 담당해. v2.ToTensor()와 달리 픽셀 값 범위를 바꾸지 않고 데이터 타입만 텐서로 바꿈.
  - `v2.ToDtype(torch.float32, scale=True)`: 텐서의 데이터 타입을 float32로 바꾸면서, scale=True 옵션을 통해 픽셀 값을 [0.0, 1.0] 범위로 정규화.

## 2025-07-01 Tue
#### 🔴 [The Oxford-IIIT Pet Dataset](https://www.kaggle.com/datasets/devdgohil/the-oxfordiiit-pet-dataset) 데이터셋(kaggle)

## 2025-07-03 Wed
#### ⚪ Batch_size vs. Learning_rate 뭐가 중요할까?

## 2025-07-03 Thu
#### ⚪ Adam + ReduceLROnPlateau: 옵티마이저+스케줄러 궁합은?

## 2025-07-04 Fri
#### ⚪ 

## 2025-07-08 Mon
#### ⚪ 

## 2025-07-08 Tue
#### ⚪ Generative Model의 개념 정리

## 2025-07-09 Wed
#### 🔴 [Football (Semantic Segmentation)](https://www.kaggle.com/datasets/sadhliroomyprime/football-semantic-segmentation) 데이터셋(kaggle)



## 2025-07-10 Thu
#### ⚪ git pull `--no-rebase` vs `--rebase`


## 2025-07-11 Fri
1. [AI - 컴퓨터 비전] VAE의 구조와 학습 과정(ELBO 키워드 포함)에 대해 설명해 주세요. (20점)
VAE는 인코더와 디코더로 구성된 생성 모델입니다. 인코더는 입력 데이터를 받아 잠재 변수의 확률분포(평균과 분산)를 추정하고, 디코더는 이 잠재 변수에서 샘플링한 값을 이용해 원본 데이터를 재구성합니다. 학습 과정에서는 재구성 손실과 KL Divergence를 포함한 ELBO(Evidence Lower Bound)를 최대화하여, 입력 데이터의 특성을 잘 반영하는 잠재 공간을 학습하게 됩니다.


2. [AI - 컴퓨터 비전] GAN과 cGAN에 대해 설명하고, cGAN이 어떤 상황에서 유용할지 예시를 들어 설명해 주세요. (20점)
GAN(Generative Adversarial Network)은 생성자(Generator)와 판별자(Discriminator)가 경쟁하며 학습하는 비지도 학습 기반의 이미지 생성 모델입니다. 생성자는 진짜 같은 이미지를 생성하고, 판별자는 생성된 이미지가 가짜인지 판별합니다.
cGAN(Conditional GAN)**은 GAN에 추가적인 조건을 입력하여 원하는 특성을 가진 이미지를 생성할 수 있도록 한 모델입니다. 예를 들어, MNIST 데이터셋에서 숫자 '3'을 생성하고 싶다면, 3이라는 레이블 정보를 조건으로 사용하여 특정 숫자의 이미지를 생성할 수 있습니다.
활용 예시: cGAN은 색상 변환, 스타일 변환, 특정 카테고리의 이미지 생성 등에 활용될 수 있습니다. 예를 들어, 흑백 사진을 컬러화하거나, 스케치를 실사 이미지로 변환하는 작업에 사용할 수 있습니다.
채점 결과 및 코멘트

3. [AI - 컴퓨터 비전] Image Segmentation에서 Semantic Segmentation과 Instance Segmentation의 차이를 설명해 주세요. (20점)
Semantic Segmentation은 이미지 내의 각 픽셀을 특정 클래스에 할당하는 방식입니다. 같은 클래스에 속하는 모든 객체는 동일한 레이블을 가집니다. 예를 들어, 모든 자동차 픽셀을 같은 라벨로 지정합니다.
Instance Segmentation(인스턴스 분할)은 같은 클래스 내에서도 개별 객체를 구별하는 방식입니다. 즉, 동일한 클래스의 여러 객체라도 각각 다른 라벨을 할당합니다. 예를 들어, 서로 다른 자동차마다 각각 다른 ID를 부여하여 구분합니다.
4. [AI - 컴퓨터 비전] Single-Stage 모델과 Two-Stage 모델의 차이점을 설명하세요. (20점)
Two-Stage 모델은 먼저 Region Proposal Network(RPN)을 사용하여 후보 영역을 생성한 후, 이를 바탕으로 객체 분류 및 바운딩 박스 보정을 수행하는 방식입니다. 대표적인 예시로 Faster R-CNN이 있으며, 일반적으로 정확도가 높지만 속도가 느립니다.
Single-Stage 모델은 RPN을 사용하지 않고, 단일 네트워크에서 바운딩 박스 예측과 클래스 분류를 동시에 수행하는 방식입니다. 대표적인 예시로 YOLO(You Only Look Once), SSD(Single Shot MultiBox Detector)가 있으며, 실시간 성능이 뛰어나지만 정확도가 다소 낮을 수 있습니다.

5. [AI - 컴퓨터 비전] 이미지 분류(Image Classification)와 객체 탐지(Object Detection)의 차이를 비교하세요. (20점)

이미지 분류(Image Classification)는 입력 이미지가 주어졌을 때, 해당 이미지가 어떤 클래스에 속하는지를 예측하는 문제입니다. 단일 클래스 예측이 일반적이며, 대표적인 모델로 ResNet, VGG, EfficientNet 등이 있습니다.
객체 탐지(Object Detection)는 이미지 내에서 여러 객체의 위치(Bounding Box)와 해당 클래스를 동시에 예측하는 문제입니다. 이미지 분류보다 더 복잡한 작업이며, 대표적인 모델로 Faster R-CNN, YOLO, SSD 등이 있습니다.


## 2025-07-14 Mon

#### ⚪ Debugging in Practice: Defensive Programming


## 2025-07-15 Tue
#### 🔴 torchvision.datasets.FashionMNIST

## 2025-07-16 Wed
#### ⚪ git config alias
#### ⚪ git log --pretty=oneline
#### ⚪ git show [커밋 아이디]
특정 커밋에서 어떤 변경사항이 있었는지 확인


## 2025-07-17 Thu
#### ⚪ git reset --hard: 과거 커밋으로 아예 돌아가고 싶을 때
- `--miexed`, `--soft` 같은 옵션과 차이 존재
- `--hard` 옵션의 경우 working directory의 작업물까지 모두 날아갈 수 있다.
- `git reset --hard HEAD^`: 현재 가리키고 있는 commit의 바로 이전 커밋
- `git reflog`로 HEAD 이동 내역을 추적해서 복구 가능


## 2025-07-18 Fri
#### ⚪ git commit --ammend
신 커밋을 다시 수정해서 새로운 커밋으로 만듦
#### ⚪ commit 메시지 가이드라인: 협업을 위해서 회사나 조직에서는 일관된 commit 메시지 형식이 존재함

#### ⚪ git tag [태그 이름] [커밋 아이디]



## 2025-07-22 Tue
#### ⚪ train.py의 고도화 작업 시작
- Object학습 평가 지표
  - IOU 추가
  - mAP, mAP50, mAP75 등 분류 세분화
- Earlystopping 전략

