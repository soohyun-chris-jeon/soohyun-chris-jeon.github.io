---
layout: post
title:  "[Python] Generator 표현식에 대해서"
date:   2024-11-24 10:00:00 +0900
categories: [python]
tags: [python, generator, Iterator, Fluent python, pythonic]
pin: false
comments: true     # 댓글 기능 사용 (옵션)


---
## 🟣 Generator란?
'Fluent Python'에서 강조하는 개념으로 복잡한 개념은 아니지만 iterator의 개념은 python에서 굉장히 많이 사용되는 문법이지만 제대로 배우거나 정리한 적은 없어서 이번 기회에 살짝 정리해보았다.

#### 🟡 Generator? Iterator?
| 항목                             | Generator                               | Iterator                                      |
| ------------------------------ | --------------------------------------- | --------------------------------------------- |
| ✅ 정의                           | 값을 **lazy하게 생성하는 함수 or 표현식**            | 값을 **순차적으로 반환하는 객체**                          |
| ✅ `__iter__`, `__next__` 구현 여부 | 둘 다 구현되어 있음 (자동으로)                      | 명시적으로 구현하거나 `iter()`로 생성                      |
| ✅ 사용 목적                        | **값을 하나씩 생성**해서 순회할 수 있게 함              | **값을 순차적으로 꺼낼 수 있는 인터페이스** 제공                 |
| ✅ 생성 방식                        | `yield` or generator expression 사용      | class 또는 `iter()`로 생성                         |

- generator랑 iterator는 굉장히 비슷한 개념이고, 실제로 generator는 iterator의 한 종류라고 볼 수 있음
- 근데 둘 사이에는 약간의 구조적 차이와 생성 방식의 차이가 있음
  * 모든 generator는 iterator다 (__iter__(), __next__() 있음)

  * 하지만 모든 iterator가 generator는 아니다
      → 예: iter([1,2,3])은 iterator지만 generator는 아님


#### 🟡 Generator
```py
(x*x for x in range(1000))
```
- 하나씩 값을 lazy하게 계산해서 반환
- 리스트를 만들지 않고, 한 번에 하나씩만 처리
- 메모리 절약에 유리

#### 🟡 List comprehension  
```py
[x*x for x in range(1000)]
```
- 전체 결과를 한꺼번에 메모리에 저장함 (리스트 생성)
- 결과가 바로 리스트로 materialize됨
- 빠르지만 메모리를 많이 쓸 수 있음


#### 🟡 예제 비교 
```py
import sys

lst = [x*x for x in range(1000000)]      # 리스트 컴프리헨션
gen = (x*x for x in range(1000000))      # 제너레이터 표현식

print(sys.getsizeof(lst))  # ❗ # 리스트는 8697464(약 8MB)
print(sys.getsizeof(gen))  # ❗ 제너레이터 112
"""
8697464   # 리스트는 약 8MB
112       # 제너레이터는 고정된 메모리 (next 포인터만 있음)
"""
```
 


## 🟣 마무리

generator는 iterator를 더 쉽게, 간단하게 만드는 방법이다. 둘 다 lazy하게 값을 하나씩 처리하며, for, next(), sum() 등에서 동일하게 쓸 수 있다.


