---
layout: post
title:  "5-(2) PyTorch에서 텐서란 무엇이고, NumPy의 Array(배열)과 어떤 차이가 있나요?"
date:   2025-06-13 16:00:00 +0900
categories: [Codeit AI 3기, Weekly Paper]
tags: [PyTorch, numpy, tensor, Machine Learning, Deep Learning, AI]
comments: true     # 댓글 기능 사용 (옵션)

---

## 🟢 5-(2) Pytorch에서 텐서란 무엇이고, NumPy의 Array(배열)과 어떤 차이가 있나요?


`Tensor`는 쉽게 말하면 **NumPy의 array랑 거의 비슷하게 생긴 수치 데이터 컨테이너**

### 🟡 공통점
- 둘 다 다차원 배열 (1D, 2D, 3D… nD)
- 슬라이싱, 인덱싱, 브로드캐스팅 등 기본 연산 비슷함

### 🟡 Pytorch Tensor만의 특징
- `.cuda()` 한 줄이면 GPU 연산 가능함 → 대규모 딥러닝에서 필수
- `.backward()`로 **자동 미분(autograd)** 가능 → 딥러닝 학습에 최적화


### 🟡 Pytorch vs NumPy

| 항목                      | `torch.Tensor`                            | `numpy.ndarray`      |
| ----------------------- | ----------------------------------------- | -------------------- |
| **기본 목적**               | 딥러닝 계산용 (PyTorch)                         | 일반 수치 계산 (SciPy 생태계) |
| **자동 미분**               | ✅ `autograd` 지원                           | ❌ 없음                 |
| **GPU 연산 지원**           | ✅ `.cuda()`, `.to('cuda')` 등              | ❌ CPU only           |
| **DL 라이브러리 통합**         | ✅ PyTorch에서 모델 학습에 사용됨                    | ❌ 직접 사용 불가           |
| **In-place 연산 등 연산 특성** | PyTorch 특유의 동작 (e.g., in-place는 `_`로 표시됨) | NumPy 방식대로           |


#### 🟢 예시 답안 (코드잇 제공)
> PyTorch의 텐서는 다차원 배열을 표현하는 데이터 구조로, NumPy의 배열과 유사한 역할을 합니다. 하지만 PyTorch 텐서는 **GPU 가속 연산**을 지원한다는 점에서 NumPy 배열과 차이가 있습니다.
- 예를 들어, PyTorch의 텐서는 torch.tensor로 선언하며, CPU뿐만 아니라 GPU에서도 연산을 수행할 수 있습니다. GPU로 연산하려면 텐서를 .to(device) 메서드로 이동시키면 됩니다. 이 기능은 대규모 데이터 처리와 딥러닝 모델 학습에 유리합니다.
- 또한, PyTorch 텐서는 autograd을 지원합니다. requires_grad=True로 설정된 텐서는 계산 그래프를 기록하며, 이를 통해 손실 함수의 경사(gradient)를 자동으로 계산할 수 있습니다. 반면 NumPy 배열은 이러한 기능이 없기 때문에 딥러닝 학습에는 적합하지 않습니다.
- 요약하자면, PyTorch 텐서는 NumPy 배열처럼 데이터 조작이 가능하지만, GPU 가속 연산과 자동 미분 기능 덕분에 딥러닝 작업에 특화된 데이터 구조입니다.