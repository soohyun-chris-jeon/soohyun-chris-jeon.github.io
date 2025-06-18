---
layout: post
title:  "[Part 2] Study log 2025.06.09 ~ 08.14  "
date:   2025-06-09 10:00:00 +0900
categories: [Codeit AI 3기, Study log]
tags: [python, Deep Learning, pytorch, numpy]
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