---
layout: post
title:  "[Python] Fluent python - 루시아누 히말류"
date:   2024-11-23 10:00:00 +0900
categories: [python]
tags: [python, Fluent python, pythonic]
pin: false
comments: true     # 댓글 기능 사용 (옵션)


---
## 🟣 < `Fluent python` > - Luciano Ramalho 
예전에 python을 공부하겠다고 책을 사고 한 챕터도 읽기가 어려웠던 책이었다. 그만큼 어렵게 지어진 책이었고 단순 문법책이 아니라 왜 python이 우수한 프로그래밍 언어인가를 설명하는 책이다. 따라서 이번 기회에 이 책에 대해서 한번 정리해보려고 한다.

정리에 앞서 이 책의 모토를 정리하면

> "파이썬을 C나 Java처럼 쓰지 말고, 파이썬답게 써라. 그 방법은 '데이터 모델'에 전부 담겨 있다."

---

#### ⚪ 1. 모든 것은 '파이썬 데이터 모델'로 통한다 (The Python Data Model is Key)
- 핵심 철학: 네가 만드는 객체를 파이썬의 기본 문법([], len(), for, +)과 어우러지게 만들어라. my_object.get_length() 같은 '외국어'를 만들지 말고, len(my_object)라는 **파이썬의 '모국어'를 사용하도록** __len__을 구현하라는 뜻.

> 왜 중요한가: 이게 바로 Pythonic한 코드의 **일관성**과 **가독성**을 만드는 근원임. 누구나 len()을 보면 길이를 재는 거라고 예상할 수 있고 이런 예측 가능성이 코드를 아름답게 만든다

---

#### ⚪ 2. 내장 자료구조를 최대한 활용하고 마스터하라 (Leverage Built-in Collections)
- 파이썬은 강력하고 빠른 내장 자료구조(list, tuple, dict, set)를 제공함. 
- list comprehension, generator expressions 활용 강조
- collections 모듈 소개: namedtuple, deque, defaultdict, Counter

> 이 도구들은 C로 구현되어 있어서 매우 빠르고, 메모리 효율적이며, 코드도 훨씬 간결해짐.

---

#### ⚪ 3. 함수는 '일급 시민'이다 (Functions are First-Class Objects)
- 일급 객체로서의 함수: 함수도 값처럼 전달 가능
- 데코레이터 (decorator): 함수를 wrapping해서 기능 추가하는 패턴
- 클로저 (closure): 함수가 enclosing scope의 변수 기억함

> 이러한 기능은 코드의 중복을 줄이고, 기능을 유연하게 확장하거나 수정할 수 있게 해줌. PyTorch 같은 딥러닝 프레임워크에서도 이런 패턴이 아주 흔하게 쓰임

---

#### ⚪ 4. 이터레이터와 제너레이터를 적극적으로 사용하라 (Embrace Iterators and Generators)
- 데이터를 한 번에 담는 '컨테이너(e.g. list)'가 아니라, 필요할 때마다 하나씩 꺼내 쓰는 '수도꼭지(generator)'를 사용하라
- `sum([x*x for x in range(1000)])` (리스트 생성) 대신 `sum(x*x for x in range(1000))`(제너레이터 표현식)

> 메모리의 효율성이 극적으로 향상되어 대용량 데이터를 처리하는 파이프라인을 만들기 수월해짐
 
---


## 🟣 마무리하며
AI 개발자의 입장에서 본 Fluent python은 저자가 python이라는 언어에 대해서 비록 ~~굉장히 어렵고 장황하게 설명하고 있지만~~, 무엇을 강조하고 싶었는지 분명하게 알 수 있었던 책이다.

pythonic하다는 모토는 기능적으로 효율성 뿐만 아니라 협업의 관점에서도 python이 기존 C/C++의 연산자 오버로딩과 같은 개념을 더 적극적으로 활용한 언어인것 같다. 마치 고3때 어떤 문제를 푸는데 출제자의 의도가 분명한 문제를 푸는 것처럼 python도 개발한 사람의 의도가 분명히 있는 언어다. 그렇기 때문에 기존 언어들과 차별점이 생기고 현재 오픈소스 개발 분야에서는 따라올 언어가 없는 위치에 있는 것 같다.