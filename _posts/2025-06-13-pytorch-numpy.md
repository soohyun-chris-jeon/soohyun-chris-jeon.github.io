---
layout: post
title:  "5-(2) PyTorch에서 텐서란 무엇이고, NumPy의 Array(배열)과 어떤 차이가 있나요?"
date:   2025-06-13 16:00:00 +0900
categories: [Codeit AI 3기, Weekly Paper]
tags: [pytorch, numpy, tensor, Machine Learning, Deep Learning, AI]
comments: true     # 댓글 기능 사용 (옵션)

---

## 5-(2) PyTorch에서 텐서란 무엇이고, NumPy의 Array(배열)과 어떤 차이가 있나요?


`Tensor`는 쉽게 말하면 **NumPy의 array랑 거의 비슷하게 생긴 수치 데이터 컨테이너**야.  
하지만 PyTorch의 Tensor는 GPU에 올려서 연산할 수 있다는 점이 크다.

### 공통점
- 둘 다 다차원 배열 (1D, 2D, 3D… nD)
- 슬라이싱, 인덱싱, 브로드캐스팅 등 기본 연산 비슷함

### PyTorch Tensor만의 특징
- `.cuda()` 한 줄이면 GPU 연산 가능함 → 대규모 딥러닝에서 필수
- `.backward()`로 **자동 미분(autograd)** 가능 → 딥러닝 학습에 최적화
- PyTorch 모델의 입출력 형태로 사용됨 → NumPy는 직접 넣으면 에러남

```python
import torch
import numpy as np

# NumPy -> Tensor
a = np.array([[1, 2], [3, 4]])
b = torch.from_numpy(a)

# Tensor -> NumPy
c = b.numpy()
```