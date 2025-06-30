---
layout: post
title:  "[PyTorch] 컴퓨터 비전의 동반자, torchvision"
date:   2025-06-18 10:00:00 +0900
categories: [PyTorch]
tags: [PyTorch, torch.torchvision, Machine Learning, Deep Learning, AI]
pin: false
comments: true     # 댓글 기능 사용 (옵션)


---
## 🟣 Intro
그동안 pytorch 여러 모듈을 import 하고 쓰지만 정작 그 모듈에 대해서는 깊게 생각해본 적이 없었던 것 같다.

그래서 이번 기회에 각 모듈에 대한 개념을 정리하고자 포스팅을 시작했다.

#### ⚪ `torch.nn`의 핵심 개념
torch.nn은 신경망을 만드는 데 필요한 모든 부품이 들어있는 상자
  * 신경망의 부품 제공: `nn.Linear`, `nn.Conv2d` 같은 개별 블록들을 제공
  * 모델의 뼈대 제공: `nn.Module`이라는 '조립 설명서'의 템플릿을 제공하여, 누구나 체계적으로 자신만의 모델을 만들 수 있게 함

#### ⚪ 모든 모델의 어머니: `nn.Module`
- PyTorch의 모든 신경망 모델은 **예외 없이 nn.Module 클래스를 상속⭐받아서** 만들어짐.
    * 우리가 만든 모델이 PyTorch의 생태계(학습, 최적화, 데이터로딩 등)와 원할하게 연동할 수 있도록 필요한 기능을 자동으로 갖추게 됨
    * 모델의 파라미터(weight, bias)를 자동으로 추적하고 관리해 줌.

- nn.Module의 필수 규칙: __init__과 forward
    * `__init__(self)` : 모델에서 사용할 레이어를 정의하고 초기화
    * `forward(self, x)` : __init__에서 준비한 블록들을 어떤 순서로 디자인하고, 데이터(x)가 어떤 흐름으로 통과할지 정의

#### ⚪ torch.nn이 담고 있는 블록의 종류
1) 컨테이너 (Containers): 여러 블록을 담는 통. `nn.Sequential`⭐, `nn.ModuleList` 등
2) 레이어 (Layers): 핵심 연산을 수행하는 블록. `nn.Linear`, `nn.BatchNrom2d`, `nn.Dropout` 등
3) 활성화 함수 (Activation Functions)
4) 손실 함수 (Loss Functions)


#### ⚪ 예제

```py
import torch
import torch.nn as nn
import torch.optim as optim

# 1. 모델 설계 (nn.Module 상속)
class SimpleCNN(nn.Module):
    def __init__(self):
        super(SimpleCNN, self).__init__()
        # 컨테이너를 사용해 블록들을 순차적으로 조립
        self.features = nn.Sequential(
            nn.Conv2d(in_channels=1, out_channels=16, kernel_size=5, stride=1, padding=2),
            nn.BatchNorm2d(16),
            nn.ReLU(),
            nn.MaxPool2d(kernel_size=2)
        )
        self.classifier = nn.Sequential(
            nn.Linear(16 * 14 * 14, 128),
            nn.ReLU(),
            nn.Dropout(0.5),
            nn.Linear(128, 10) # 10개 클래스로 분류
        )

    def forward(self, x):
        x = self.features(x)
        x = x.view(x.size(0), -1) # Flatten
        x = self.classifier(x)
        return x

# 2. 모델, 손실 함수, 옵티마이저 인스턴스화
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
model = SimpleCNN().to(device)
criterion = nn.CrossEntropyLoss() # 손실 함수 블록
optimizer = optim.Adam(model.parameters(), lr=0.001)

print(model)
```

## 🟣 요약
- nn.Module이라는 강력한 객체지향적 설계 위에서, 우리가 원하는 어떤 복잡한 신경망이라도 체계적으로, 또 확장 가능하게 만들 수 있도록 돕는 프레임워크

#### ⚪ 출처
[PyTorch Official Documentation (torch.nn)](https://pytorch.org/docs/stable/nn.html) 
[PyTorch Official Tutorials](https://pytorch.org/tutorials/)

