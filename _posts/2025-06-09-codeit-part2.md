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

- 

## 2025-06-09 Mon
#### 🟡 `torch.Tensor` vs `np.array`  
| 요약    | 내용                                               |
| ----- | ------------------------------------------------ |
| 공통점   | 다차원 배열, 벡터화, 브로드캐스팅, dtype 설정, 서로 변환 가능          |
| 차이점   | **PyTorch는 autograd + GPU 지원**, NumPy는 일반 수치 계산용 |
| 실전 사용 | 딥러닝 모델 학습시 `torch.Tensor` 써야 함                 |

## 2025-06-10 Tue
#### `np.unique`

## 2025-06-11 Wed



## 2025-06-12 Thu

#### 🔴 Denoising Dirty Documents 데이터셋(Kaggle)
[Denoising Dirty Documents](https://www.kaggle.com/competitions/denoising-dirty-documents)

- Denoising-AE 과제

## 2025-06-13 Fri


## 2025-06-16 Mon
#### `torchvision.transforms` 


## 2025-06-17 Tue
#### 로컬 전용 WSL 서버 구축하기

## 2025-06-18 Wed
#### .gitignore

## 2025-06-20 Fri
#### torch.utils.data의 Dataset 클래스(사용자 정의 클래스) (From [파이토치 공식문서](https://tutorials.pytorch.kr/beginner/basics/data_tutorial.html) )
- __init__, __len__, and __getitem__  3가지 메서드를 반드시 정의해야한다.
  - **\__init__** 함수는 Dataset 객체가 생성(instantiate)될 때 한 번만 실행됩니다. 여기서는 이미지와 주석 파일(annotation_file)이 포함된 디렉토리와 (다음 장에서 자세히 살펴볼) 두가지 변형(transform)을 초기화합니다.
  
  - **\__len__** 함수는 데이터셋의 샘플 개수를 반환합니다.

  - **\__getitem__** 함수는 주어진 인덱스 idx 에 해당하는 샘플을 데이터셋에서 불러오고 반환합니다. 인덱스를 기반으로, 디스크에서 이미지의 위치를 식별하고, read_image 를 사용하여 이미지를 텐서로 변환하고, self.img_labels 의 csv 데이터로부터 해당하는 정답(label)을 가져오고, (해당하는 경우) 변형(transform) 함수들을 호출한 뒤, 텐서 이미지와 라벨을 Python 사전(dict)형으로 반환합니다.

#### torch의 브로드캐스팅이란?


#### nn.Conv2d()에 padding 값을 '`valid`'나 '`same`'으로 할 때 각각 패딩이 어떻게 적용되는지
- `valid`는 padding을 따로 주지 않고 input image 자체만을 이용해 convolution 연산을 수행한다.
- `same`은 output size가 input size와 동일하게 되도록 padding을 조절한다. 만약 stride=1, dilation=1인 경우 padding=(kernel_size-1)/2로 설정된다.