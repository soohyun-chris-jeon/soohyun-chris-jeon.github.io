---
layout: post
title:  "[PyTorch] nn.Module 클래스 super().__init__()의 역할"
date:   2025-06-19 10:00:00 +0900
categories: [PyTorch, nn.Module]
tags: [PyTorch, torch.torchvision, Machine Learning, Deep Learning, AI]
pin: false
comments: true     # 댓글 기능 사용 (옵션)


---
## 🟣 Intro
- 최근 공부했던 `torch.utils.data`에서 Dataset 클래스를 상속받아 커스텀 데이터셋을 정의해보았다.

- 그리고 이번엔 딥러닝 네트워크를 디자인하려고 하는데... PyTorch가 제공하는 레이어와 모듈을 사용하려면 `torch.nn`의 `nn.Module`을 상속해야 한다.
```py
class DoubleConv(nn.Module):
    def __init__(self, in_channels, out_channels):
        super(DoubleConv, self).__init__()
```

- 그런데 이상하게도 이번에는 굳이 `super().__init__`이라는 생성자를 호출하여 `nn.Module`을 상속받고 initialize하고 있었다.

- 이거 꼭 해야하나? 이거 왜 하는거지? dataset 만들때는 왜 안해도 되지? 싶어서 포스팅을 해보았다.

---

#### ⚪ super()의 역할
- `super()`는 파이썬의 클래스 상속(inheritance)에서 자식 클래스에서 부모 클래스를 호출할 때 사용함. 즉, 이 개념을 위 코드에 적용하면

> "좋아, DoubleConv 클래스를 초기화(\__init__)할 건데, 그 전에 일단 내 부모 클래스인 `nn.Module`의 초기화 메서드(\__init__)를 먼저 실행해서 기본 세팅부터 끝내줘."

---

#### ⚪ super()를 꼭 해야하나?
PyTorch에서 모든 뉴럴네트워크 모듈은 `nn.Module`을 상속받는다. `nn.Module`의 \__init__ 메서드는 다음과 같은 매우 중요한 내부 상태(internal state)를 설정한다.

  * `_parameters`: 모델의 학습 가능한 파라미터(가중치, 편향)를 저장하는 OrderedDict.

  * `_modules`: 자식 모듈(다른 레이어들)을 저장하는 OrderedDict.

  * `_buffers`: 파라미터는 아니지만 상태 유지가 필요한 버퍼(e.g., BatchNorm의 running_mean)를 저장.

  * `_hooks`: Forward/Backward 과정에 적용될 훅(hook)들을 관리.

만약 super().\__init__을 하지 않는다면 이 모든 기능이 비활성화된다. 결과적으로 model.parameters()는 비어있을 것이고, model.to(device)는 작동하지 않으며, **학습 자체가 불가능**

---

#### ⚪ pythonic Syntax
- `Python 2.x` 스타일 (여전히 작동함)
```py
super(DoubleConv, self).__init__()
```

- `Python 3.x` 스타일 (권장)
```py
super().__init__()
```

---


## 🟣 결론

super().__init__()는 단순한 관례가 아닌, 상속 기반 클래스가 제대로 작동하기 위한 필수적인 구문이다. 특히 PyTorch와 같은 프레임워크에서는 부모 클래스(nn.Module)가 제공하는 핵심 인프라를 활성화하는 열쇠와 같다.
