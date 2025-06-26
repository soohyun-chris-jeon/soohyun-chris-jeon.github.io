---
layout: post
title:  "[Part 2] Study log 2025.06.09 ~ 08.14  "
date:   2025-06-09 10:00:00 +0900
categories: [Codeit AI 3기, Study log]
tags: [python, Deep Learning, PyTorch, numpy]
comments: true     # 댓글 기능 사용 (옵션)

---



![코드잇 스프린트](https://img1.daumcdn.net/thumb/R750x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2F4qgsr%2FbtsFEtondnt%2FXoFKqUvKEaFyQubZZyLIPk%2Fimg.png)

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
#### ⚪ torch.utils.data의 Dataset 클래스(사용자 정의 클래스) (From [파이토치 공식문서](https://tutorials.pytorch.kr/beginner/basics/data_tutorial.html) )
- __init__, __len__, and __getitem__  3가지 메서드를 반드시 정의해야한다.
  - **\__init__** 함수는 Dataset 객체가 생성(instantiate)될 때 한 번만 실행됩니다. 여기서는 이미지와 주석 파일(annotation_file)이 포함된 디렉토리와 (다음 장에서 자세히 살펴볼) 두가지 변형(transform)을 초기화합니다.
  
  - **\__len__** 함수는 데이터셋의 샘플 개수를 반환합니다.

  - **\__getitem__** 함수는 주어진 인덱스 idx 에 해당하는 샘플을 데이터셋에서 불러오고 반환합니다. 인덱스를 기반으로, 디스크에서 이미지의 위치를 식별하고, read_image 를 사용하여 이미지를 텐서로 변환하고, self.img_labels 의 csv 데이터로부터 해당하는 정답(label)을 가져오고, (해당하는 경우) 변형(transform) 함수들을 호출한 뒤, 텐서 이미지와 라벨을 Python 사전(dict)형으로 반환합니다.

#### ⚪ torch의 브로드캐스팅이란?
- torch 합: `+` 연산자
  torch 곱: `@`(매트릭스곱) vs. `*`(스칼라곱)

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



#### 🔴 [Chest X-Ray Images (Pneumonia)](https://www.kaggle.com/datasets/paultimothymooney/chest-xray-pneumonia) 데이터셋


## 2025-06-25 Wed
#### 🔴 CaliforniaHousingDataset

## 2025-06-26 Thu
#### ⚪

## 2025-06-27 Fri
#### ⚪