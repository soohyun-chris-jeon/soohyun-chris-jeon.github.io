---
layout: post
title:  "[PyTorch] view() vs. reshape() 비교"
date:   2025-06-15 10:00:00 +0900
categories: [PyTorch]
tags: [PyTorch, reshape(),view(), commit, repository]
comments: true     # 댓글 기능 사용 (옵션)

---


# 🟣 Intro
- pytorch를 사용하다보면 tensor의 shape을 바꿔야하는 작업이 매우 빈번하다. 왜냐면 모델에 forward를 하더라도 2차원 데이터의 경우는 (B,C,W,H)처럼 차원을 설정해줘야 각 레이어에서 학습이 가능하기 때문이다. 그럴때 많이 쓰는 torch의 메서드가 `reshape()`과 `view()`이다.


#### 
```
a = torch.randn(3, 2, 4)
b = a.reshape(-1)  # reshape() 메서드를 써서 1차원으로 만듦
b[0] = 99999

a  # a에도 영향을 준다

a = torch.randn(3, 2, 4)
b = a.view(-1)  # reshape() 메서드를 써서 1차원으로 만듦
b[0] = 99999

a  # a에도 영향을 준다



#### ⚪ 깐깐한 원칙주의자 (`view()`) vs. 융통성 있는 해결사 (`reshape()`)

❌ No.
```py
import torch
# 1. 일반적인 상황: 둘 다 메모리를 공유한다.
x = torch.arange(1, 7) # tensor([1, 2, 3, 4, 5, 6])
print(f"x는 연속적인가? {x.is_contiguous()}")

# x_view와 x_reshape 모두 x와 같은 메모리 공간을 가리킨다.
x_view = x.view(2, 3)
x_reshape = x.reshape(2, 3)

# x_view의 값을 바꾸면...
x_view[0, 0] = 99

# 원본 x와 x_reshape의 값도 모두 바뀐다!
print(f"원본 x: \n{x}")
print(f"x_reshape: \n{x_reshape}")
# 원본 x:
# tensor([99,  2,  3,  4,  5,  6])
# x_reshape:
# tensor([[99,  2,  3],
#         [ 4,  5,  6]])
print("-" * 20)


# 2. 문제가 되는 상황: 메모리가 연속적이지 않을 때
y = torch.arange(1, 7).reshape(2, 3)
y_transposed = y.T # .T는 .transpose(0, 1)와 같음. 모양은 (3,2)가 됨
print(f"y_transposed는 연속적인가? {y_transposed.is_contiguous()}")
# y_transposed는 연속적인가? False  <-- 바로 이 때!

# 2-1. 원칙주의자 view()는 에러를 발생시킨다!
try:
    y_view = y_transposed.view(2, 3)
except RuntimeError as e:
    print(f"view() 에러 발생: {e}")
# view() 에러 발생: view size is not compatible with input tensor's size and stride...
# '...Use .reshape() or .contiguous().' 라고 친절하게 알려주네!

# 2-2. 해결사 reshape()는 조용히 복사본을 만들어 처리한다.
y_reshape = y_transposed.reshape(2, 3)

# y_reshape의 값을 바꿔도...
y_reshape[0, 0] = 777

# 원본 y_transposed에는 아무런 영향이 없다! (복사본이니까)
print(f"\ny_reshape: \n{y_reshape}")
print(f"원본 y_transposed: \n{y_transposed}")
# y_reshape:
# tensor([[777,   2,   4],
#         [  3,   5,   6]])
# 원본 y_transposed:
# tensor([[1, 4],
#         [2, 5],
#         [3, 6]])
```

 #### ⚪ 그래서 뭘 써야 할까?
일반적으로는 그냥 `reshape()`을 쓰는 게 편하고 안전.
대부분의 경우 우리가 원하는 대로 동작하고, 굳이 메모리 연속성까지 신경 쓰지 않아도 되니까.

`view()`는 이럴 때 사용.
내 코드에서 **"여기는 반드시 메모리 공유가 일어나야 하고, 불필요한 복사가 생기면 안 되는 아주 중요한 부분이야!"**라고 명시하고 싶을 때. 또는 view가 될 거라고 100% 확신할 때 사용하면, **의도치 않은 복사를 막는 안전장치**가 될 수 있음.
