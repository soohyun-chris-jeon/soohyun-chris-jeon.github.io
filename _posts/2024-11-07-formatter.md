---
layout: post
title: "[Python] python fomatter: ruff와 black "
date: 2024-11-07 00:00:00 +0900
categories: [python]
tags: [python, VScode, black, ruff, AI, Deep Learning]
pin: false
comments: true     # 댓글 기능 사용 (옵션)
---

## 🔵 파이썬 포맷팅

예전에 조교를 할때 이 사람이 코드를 좀 하는 사람인지 아닌지 아는 방법은 **코드의 포맷을 지키는지** 보는 것이었다.
그런데 요즘은 시대가 좋아진 것인지 VScode에는 포매터가 자동으로 포맷팅을 해준다... 그동안 나는 뭘 위해서 포맷팅 공부하면서 일일이 고치고 앉아 있었던 것인가ㅜ 

아무튼 VScode 사용자가 파이썬 코드 스타일을 깔끔하게 유지하고 싶다면 **코드 포매터(formatter)**는 필수 익스텐션이다.  

최근엔 `ruff`가 엄청나게 핫해지면서, 기존의 `black`과 같이 쓰면 꿀이라는 정보를 얻어서  
이번 글에선 VSCode 기준으로 추천하는 포매터 조합과 설정법을 간단히 정리해보았다.

---

#### ⚪ 주요 파이썬 포매터 비교

| Formatter | 주요 특징 | 장점 | 단점 |
|-----------|-----------|------|------|
| **`black`** | 코드 스타일을 **엄격하게 통일**해줌 | - 설정 거의 없이 깔끔한 스타일<br>- 일관성 최고 | - 너무 고정된 스타일이라 커스터마이징 어려움 |
| **`ruff`** | **포매팅 + 린팅 + 코드 수정까지 통합**<br>Rust로 구현되어 매우 빠름 | - 속도 최강<br>- flake8, isort, black 등 **대체 가능**<br>- 거의 모든 린터 룰 포함 | - 아직 포매팅 기능은 **black만큼 완성되진 않음** (2025년 기준) |
| `autopep8` | PEP8에 맞춰 코드 수정 | - 가볍고 간단 | - 요즘은 거의 사용 안 함<br>- 커뮤니티 지원 약함 |

---

#### ⚪ 린터(Linter)란?

린터는 **'코드용 맞춤법 & 문법 검사기'**

- 린터가 "이 문장은 주어와 서술어가 맞지 않고, 저 단어는 오타가 났네요." 라고 알려주는 깐깐한 *교정 전문가*라면, 포매터는 "글자 간격, 줄 바꿈, 들여쓰기를 규칙에 맞게 자동으로 맞춰주는 *편집 디자이너*" 같은 느낌.

```py
import os, sys # 1. 한 줄에 여러 모듈 import
def myFunction(name): # 2. 함수 이름이 snake_case가 아님
    unused_variable = "hello" # 3. 사용되지 않는 변수
    if name == "chris":
      return "Hello Chris" # 4. 들여쓰기가 2칸임 (PEP 8은 4칸 권장)
```
  1): 한 줄에 여러 모듈을 import하는 건 좋지 않음. (E401)
  2): 함수 이름은 my_function처럼 snake_case로 써야 함. (N802)
  3): unused_variable이 선언됐지만 사용되지 않음. (F841)
  4): 들여쓰기가 4칸이 아님. (E111)

---

#### ⚪ 추천 세팅: Ruff + Black 조합

Ruff는 빠르고 유연하지만 아직 포매팅 완성도 측면에서는 `black`이 더 안정적. 그래서 두 개를 **함께 쓰는 조합**이 가장 널리 쓰이고 있음.

##### 1. VSCode 확장 설치
- `ms-python.python`
- `charliermarsh.ruff` (Ruff 확장)

##### 2. VSCode `settings.json` 설정

```json
{
  "python.formatting.provider": "black",
  "python.linting.enabled": true,
  "python.linting.ruffEnabled": true,
  "python.linting.ruffArgs": ["--fix"],
  "editor.formatOnSave": true,
  "[python]": {
    "editor.defaultFormatter": "ms-python.black-formatter"
  }
}
```
이 설정은 저장 시 black으로 포매팅되고, ruff는 자동으로 코드 린트 및 수정(--fix)까지 처리해줌.

---

#### ⚪ 동작 예시 코드: 포매팅과 린트 에러가 섞인 상태
아래 코드를 그대로 test_formatter.py 같은 파일로 저장하면:
  - 들여쓰기 틀림
  - import 순서 안 맞음
  - 줄 너무 긺
  - 괄호 스타일 안 맞음
  - 쓰이고 있지 않은 변수 포함

```python
import sys,os
import numpy as np
import pandas as pd

def    long_function_name( a,b ):
  x =    1+2
  unused_var = 42
  return a+b+ x +   np.sum(np.random.rand(100,100)) + pd.DataFrame({"a":[1,2,3]})
```
---


#### ⚪ 저장 후 기대 효과: 포매팅과 린트 에러가 섞인 상태

```python
import os
import sys

import numpy as np
import pandas as pd


def long_function_name(a, b):
    x = 1 + 2
    return (
        a
        + b
        + x
        + np.sum(np.random.rand(100, 100))
        + pd.DataFrame({"a": [1, 2, 3]})
    )
```

---

## 🔵 정리
- `Black`: 안정적이고 일관된 스타일. 보수적인 선택.
- `Ruff`: 빠르고 강력한 통합 도구. 최근 트렌드. 단독으로 쓰여도 충분히 강력함

python 포매팅을 통해서 이제 스트레스 받지 말고 자동 포맷팅을 하자.