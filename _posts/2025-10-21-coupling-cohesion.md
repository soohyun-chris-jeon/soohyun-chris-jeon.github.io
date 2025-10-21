---
layout: post
title: "모듈의 독립성 측정 방식: 결합도(Coupling)와 응집도(Cohesion)"
date: 2025-10-21 00:00:00 +0900
categories: [IPE, Module]
tags: [IPE, Module, Coupling, Cohesion, 정보처리기사, GitHub Pages, blog]
pin: false
image:
  path: https://www.haptik.ai/hubfs/Cohesion%20+%20Coupling.png
comments: true     # 댓글 기능 사용 (옵션)
# description: "정보처리기사 전공자의 1달 준비 study log"
---

## 🔵 Intro 

정보처리기사 실기에서 무조건 5점 먹고 시작해야하는 필수 개념인 결합도와 응집도에 대한 포스팅이다.

필기 시험에서는 이게 왜 중요한지도 모르고 무조건 외웠지만 지금 공부를 해보니 중요한 이유는 분명히 있었다.

코드를 짜다보면 결국 모듈화(modularity)에 대한 고민 때문에 고치고 또 고치는 상황이 발생하곤 한다.

재사용(reusability)에 대한 고민 없이 설계한 코드는 이렇게 빈곤한 확장성 문제에 부딪히게 되는데...

이러한 모듈의 독립성을 측정하는 방식에 대한 내용이 결합도와 응집도이다.


-----

### ⚪ 0\. 결합도(Coupling)와 응집도(Cohesion)



### ⚪ 1\. 결합도 (Coupling) 

**"모듈끼리 얼마나 독립되어 있는가?"** (낮을수록 좋음\!)

>*내공외제스자*

| 결합도 유형 (낮은 → 높은)               | 설명                    | 예시                | 출제 빈도            |
| ------------------------------ | --------------------- | ----------------- | ---------------- |
| **데이터 결합도 (Data Coupling)**    | 단순한 데이터만 인자로 전달       | `func(a, b)`      | 🔥 최고빈출          |
| **스탬프 결합도 (Stamp Coupling)**   | 구조체, 객체 등 자료구조 일부만 사용 | `func(Student s)` | ⚡ 중빈출            |
| **제어 결합도 (Control Coupling)**  | 제어 신호(flag) 전달        | `func(mode)`      | ⚡ 중빈출            |
| **외부 결합도 (External Coupling)** | 외부 장치나 OS 의존          | 파일, 디바이스 접근       | 💡 저빈출           |
| **공통 결합도 (Common Coupling)**   | 전역 변수 사용              | `global x`        | ⚡ 중빈출            |
| **내용 결합도 (Content Coupling)**  | 한 모듈이 다른 모듈 내부 직접 참조  | 포인터로 내부 접근        | 🔥 매우 중요 (나쁜 예시) |


상황: `main` 모듈이 `tax_calculator` 모듈을 사용해서 세금을 계산하고 싶다.

#### ❌ 나쁜 예시: 높은 결합도 (공통/외부 결합도)

`tax_calculator`가 **전역 변수**(`TAX_RATE`)에 직접 의존해. 완전 끈끈하게 엮여있다.

```python
# --- ❌ 높은 결합도 (공통 결합도) ---

# config.py (전역 변수 파일)
TAX_RATE = 0.1 # '공유되는 전역 변수' (최악의 패턴 중 하나)

# tax_calculator.py (모듈 1)
import config # 1. 'config' 모듈을 직접 참조함

def calculate_tax(price):
    # 2. 'config'의 변수를 직접 가져다 씀
    #    만약 config.py가 바뀌면 이 함수는 바로 고장 남.
    return price * config.TAX_RATE 

# main.py (모듈 2)
import tax_calculator

price = 1000
tax = tax_calculator.calculate_tax(price)
print(f"세금: {tax}")

# 3. ❌ 최악의 상황:
#    'main'이 전역 변수를 바꿔버리면...
config.TAX_RATE = 0.05 
#    'tax_calculator'는 자기도 모르게 다른 결과를 냄
tax_new = tax_calculator.calculate_tax(price)
print(f"변경된 세금: {tax_new}") # 100이 아니라 50이 나옴!
```

**➡️ 문제점:** `tax_calculator`는 `config` 파일 없이는 아예 돌아가지도 않는다. 두 모듈이 '전역 변수'라는 쇠사슬로 묶여있다. 이게 **결합도가 높은** 것이다.

#### ✅ 좋은 예시: 낮은 결합도 (데이터 결합도)

`tax_calculator`는 필요한 \*\*'값'\*\*만 넘겨받는다. 세율이 어디서 왔는지 전혀 관심 없다.

```python
# --- ✅ 낮은 결합도 (데이터 결합도) ---

# tax_calculator.py (모듈 1)
def calculate_tax(price, tax_rate): # 1. 필요한 '데이터'만 받음
    #    이 'tax_rate'가 전역 변수인지, 상인지 알 필요 없음
    return price * tax_rate

# main.py (모듈 2)
import tax_calculator

price = 1000
current_tax_rate = 0.1 # 2. 세율은 'main'이 직접 관리함

# 3. '값(데이터)'만 인자로 깔끔하게 넘겨줌
tax = tax_calculator.calculate_tax(price, current_tax_rate)
print(f"세금: {tax}")

# 세율이 바뀌어도 'main'이 알고 넘겨주면 됨
new_tax_rate = 0.05
tax_new = tax_calculator.calculate_tax(price, new_tax_rate)
print(f"변경된 세금: {tax_new}")
```

**➡️ 장점:** `tax_calculator`는 완전히 독립적이다. 아무 데나 가져다 붙여도 쓸 수 있음. 이게 **결합도가 낮은** 것.

-----

### ⚪ 2\. 응집도 (Cohesion) 

**"모듈 안에서 얼마나 똘똘 뭉쳐있나?"** (높을수록 좋음\!) 

>*기순교절시논우*

| 응집도 유형 (낮은 → 높은)             | 설명              | 예시              | 출제 빈도   |
| ---------------------------- | --------------- | --------------- | ------- |
| **우연적 응집 (Coincidental)**    | 의미 없는 기능 집합     | 아무 관련 없는 함수들    | ⚡ 중빈출   |
| **논리적 응집 (Logical)**         | 비슷한 기능을 하나로 묶음  | `입력/출력 처리`      | 🔥 상급   |
| **시간적 응집 (Temporal)**        | 동시에 실행되는 기능 묶음  | 초기화 함수          | 🔥 상급   |
| **절차적 응집 (Procedural)**      | 순서에 따라 실행되는 기능  | 순차적 처리 과정       | ⚡ 중급    |
| **통신적 응집 (Communicational)** | 같은 데이터 사용 기능 묶음 | `DB read/write` | 🔥 상급   |
| **순차적 응집 (Sequential)**      | 앞의 출력이 뒤의 입력으로  | 파이프라인 형태        | 🔥 상급   |
| **기능적 응집 (Functional)**      | 하나의 명확한 기능 수행   | 계산, 정렬 등        | 🔥 최고빈출 |


상황: 여러 가지 '유틸리티' 기능이 필요하다.

#### ❌ 나쁜 예시: 낮은 응집도 (우연적/논리적 응집도)

`Utils`라는 클래스 안에 **아무 상관없는** 기능들을 다 때려 넣었음. (이름만 '유틸'이라고 묶어둠)

```python
# --- ❌ 낮은 응집도 (우연적/논리적 응집도) ---

class Utils: # "잡동사니" 클래스
    
    # 1. 수학 기능
    def calculate_circle_area(self, radius):
        return 3.14 * radius * radius
        
    # 2. DB 기능 (전혀 상관없음)
    def connect_to_database(self, url):
        print(f"{url}에 연결합니다...")
        
    # 3. 이메일 기능 (전혀 상관없음)
    def send_email(self, to, subject):
        print(f"{to}에게 '{subject}' 메일 발송...")

# --- 사용 ---
utils = Utils()
area = utils.calculate_circle_area(5)
utils.connect_to_database("my-db")
```

**➡️ 문제점:** 그냥 '편의상' 묶어둔 것이다. **응집도가 낮지.** 만약 DB 연결 로직을 수정하려고 `Utils` 클래스를 열었는데, 실수로 원 넓이 계산 코드를 건드려서 버그가 생길 수도 있다.

#### ✅ 좋은 예시: 높은 응집도 (기능적 응집도)

\*\*'하나의 목적'\*\*을 가진 클래스들로 깔끔하게 분리했음.

```python
# --- ✅ 높은 응집도 (기능적 응집도) ---

# 1. '도형 계산'이라는 '하나의 기능'에만 집중
class ShapeCalculator:
    def calculate_circle_area(self, radius):
        return 3.14 * radius * radius
    
    def calculate_rect_area(self, width, height):
        return width * height

# 2. 'DB 관리'라는 '하나의 기능'에만 집중
class DatabaseManager:
    def __init__(self, url):
        self.url = url
        
    def connect(self):
        print(f"{self.url}에 연결합니다...")

# 3. '알림 발송'이라는 '하나의 기능'에만 집중
class NotificationService:
    def send_email(self, to, subject):
        print(f"{to}에게 '{subject}' 메일 발송...")
```

**➡️ 장점:** 클래스의 목적이 명확하다. DB 수정할 일 있으면 `DatabaseManager`만 열면 돼. 이게 **응집도가 높은** 것이다.

-----

## 🔵 마치며 

이론적으로 이렇게 개념을 배웠지만 실제적으로 코딩을 이렇게 할 수 있을지는 모르겠다. 

하지만 아는만큼 보인다고... 코드를 설계하는 안목에 도움이 줄 수 있는 개념임은 분명하다. 