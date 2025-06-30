---
layout: post
title:  "[PyTorch] `nn.Module` vs. `Dataset`: 왜 `super().__init__()` 호출 여부가 다른가?"
date:   2025-06-20 10:00:00 +0900
categories: [PyTorch]
tags: [PyTorch, torch.torchvision, Machine Learning, Deep Learning, AI]
pin: false
comments: true     # 댓글 기능 사용 (옵션)


---
## 🟣 Intro
앞서 super().__init__을 통해 부모 클래스를 상속받아 초기화하는 과정을 공부해보았고 이제 Dataset 클래스와 비교를 해보면서 조금 더 이해해보려고 한다.

#### ⚪ nn.Module 클래스 vs. torch.utils.data.Dataset 클래스
결론부터 얘기하면
    - **nn.Module**은 상태를 가지는 복잡한 기계에 가까움.
    - **Dataset**은 **데이터 접근 방법을 정의하는 약속(인터페이스)**에 가까움.

#### ⚪ nn.Module: 상태를 관리하는 복잡계 (Stateful Complex System)
nn.Module은 그냥 클래스가 아니며 내부에 학습 가능한 파라미터(weights, biases), 서브 모듈, 버퍼 등 수많은 **상태(state)**를 가지고 있고, 이걸 아주 체계적으로 관리해야 함.
* 파라미터 등록: 레이어를 만들면 `self._parameters`에 자동으로 등록되어야 optimizer가 찾을 수 있어.
* 모드 전환: `model.train()`이나 `model.eval()`을 호출하면 모든 하위 모듈의 모드가 함께 바뀌어야 해.
* 디바이스 이동: `model.to('cuda')`를 하면 모든 파라미터와 버퍼가 한 번에 GPU로 옮겨져야 해.

#### ⚪ torch.utils.data.Dataset: 데이터 접근을 위한 인터페이스 (Interface for Data Access)

반면에 `torch.utils.data.Dataset`의 목적은 훨씬 단순하고 명확함. DataLoader 같은 다른 객체가 데이터를 어떻게 가져갈 수 있는지에 대한 규칙만 정해주면 됨. 즉, 
1) \__len__(self): 전체 데이터의 개수가 몇 개인지 알려줄 수 있어야 한다.
2) \__getitem__(self, idx): idx번째 데이터를 어떻게 가져올지 정의해야 한다.

Dataset의 부모 클래스 자체에는 __init__ 메서드에 특별한 내용이 없음. 실제로 PyTorch 소스 코드를 보면 torch.utils.data.Dataset의 __init__는 그냥 비어있다고 한다.(pass).

| 구분 | `nn.Module` | `torch.utils.data.Dataset` |
| :--- | :--- | :--- |
| **핵심 목적** | 학습 가능한 **상태(State)**를 가진 연산 모듈 정의 | 데이터 접근 **규칙(Interface)** 정의 |
| **필수 구현** | `__init__`, `forward` | `__len__`, `__getitem__` |
| **부모 `__init__` 역할** | 파라미터, 모듈 관리를 위한 **필수적인 내부 시스템 초기화** | 특별한 역할 없음 (내용이 비어있음) |
| **`super().__init__()`** | **필수 (Mandatory)** | **선택 (Optional, 사실상 불필요)** |


#### ⚪ 소프트웨어 공학적 관점

- nn.Module을 상속하는 것은 부모의 복잡한 **구현(implementation)**을 물려받아 확장하는 것이다.

- Dataset을 상속하는 것은 DataLoader가 요구하는 **인터페이스(interface) 규약을 따르겠다**고 약속하는 것이다.

> 참고: 이 원칙은 소프트웨어의 유연성과 재사용성을 높이는 핵심 개념으로, "Design Patterns: Elements of Reusable Object-Oriented Software" (Gamma et al., 1994)에서 널리 알려졌다.

## 🟣 요약
~torch.nn~의 `nn.Module`은 상태를 포함하기 때문에 반드시 초기화 과정이 필요하지만, `torch.utils.data.Dataset`은 데이터 접근을 위한 인터페이스 역할만 하기 때문에 부모 클래스 상속이 필요 없다!


