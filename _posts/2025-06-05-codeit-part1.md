---
layout: post
title:  "[코드잇 스프린트] Part 1 "
date:   2025-06-04 10:00:00 +0900
categories: [Codeit, AI 3기]
tags: [chirpy, jekyll, markdown]
---

# 2025.05.08 ~ 2025.06.06의 기록 

## 2025-05-08 Thu
- 개강일. OT 진행
- 앞으로 7개월 동안 개인적으로 열심히 풀어나갈 [프로그래머스](https://programmers.co.kr/).
- 학부에서 **C와 C++** 위주로 공부했기 때문에 이번 기회에 파이썬에 열심히 적응을 해볼 예정.
- `pythonic`한 코드에 집중할 예정
- 또한 한 가지 원칙은 이 페이지에는 **인용 문구 없이 챗GPT를 절대로 사용하지 않을것**. 
> 오로지 나의 생각과 정리를 위해서 페이지를 사용할 것이며 참고를 위한 GPT 인용은 가져올 것임.
   

---


## 2025-05-09 Fri
- `list comprehension` 파이썬에서 pythonic한 코드를 짜는 방식이 왜 좋은가?
   - **"명료함이 복잡함보다 낫다"** 에 따라, 코드는 직관적이고 쉽게 읽힐 수 있어야 합니다. (아직 직관적이진 않음)

```python
numbers = [1, 2, 3, 4, 5]
squared = []
for n in numbers:
    squared.append(n ** 2)

# Pythonic
squared = [n ** 2 for n in numbers]
```

- python의 강력한 내장함수는 가독성이 높고 효율적인 코딩이 가능하다는 점에서 **pythonic**하다.

```python
# non-pythonic: 반복문으로 문자열 연결
result = ""
for word in words:
    result += word

# Pythonic: 내장함수 join() 사용
result = "".join(words)
```


- `enumerate`는 더 pythonic한 코드라고 한다. (why?)

```python
# non-pythonic
for i in range(len(my_list)):
    print(i, my_list[i])

# Pythonic
for i, val in enumerate(my_list):
    print(i, val)
```
---
## 2025-05-12 Mon
- 코딩 테스트 문제: < 소수의 합 구하기 >
- N이하의 소수의 합 구하기(`에르토스테네스의 체`로 optimization해보기)
  > 최적화 이슈를 만났을때 당황하지 않고 어떻게 문제를 해결할 수 있을 것인가?.

---

## 2025-05-13 Tue

- 코딩테스트 문제: 주어진 시간 내에서 최적의 할일 찾기 -> `greedy 알고리즘` 

---

## 2025-05-14 Wed


## 2025-05-15 Thu
- 클래스의 생성자(__init__메소드)는 **명시적으로 리턴 타입을 지정해주지 않아도** 객체를 반환하도록 설계되어있다
- 문자열을 ("")로 초기화하는 건 위험하다. None을 쓰는 것이 더 pythonic

---

## 2025-05-16 Fri
#### **< 실습과제 > `Hotel Booking Demand Datasets` 분석해보기(EDA) from 캐글**
- data analysis에서 입문용으로 많이 사용하는 데이터셋(csv타입)
- pandas의 DataFrame을 사용하면 numpy나 list보다 조금 더 유연하게 사용이 가능하다



- pandas의 DataFrame을 다룰때 아주 효율적인 `fillna()` 메th드는 결측치를 처리하는데 효과적이지만 가끔 경고가 뜨기도 하는데 `SettingWithCopyWarning`의 경우다.

```
players_df.loc['Ben Davies', :].fillna(29, inplace=True)
```

이 부분이 **Ben Davies 행의 복사본**을 반환할 가능성이 있다는 것 때문
Pandas는 loc[row_label, :]으로 선택한 결과를 **반드시 원본의 뷰(view)** 로 보장하지 않는다고 한다(...)

`df.loc[:, col] = ...`	
근데 위와 같은은 컬럼 단위의 수정은 경고 없이 안정적이라고 한다;;

(이럴거면 뭐하러 만들어놓은겨 헷갈리게...)

---


## 2025-05-19 Mon
#### matplotlib vs Seaborn
`matplotlib` 기반으로 만들어진 라이브러리. 간편하게 근사한 그래프 생성하고 싶다면 `Seaborn` 추천
(Seaborn은 아직 사용해보지 않아서 한번 해봐야겠음!)

> ChatGPT의 생각이 궁금해서 물어봤더니

| 용도               | 추천 도구                                |
| ---------------- | ------------------------------------ |
| EDA / 초안 시각화     | `Seaborn` or `Altair`            |
| 논문 최종 제출용        | `Matplotlib (pgf backend)` + 수동 조정 |
| R 사용자라면          | `Plotnine`                             |
| LaTeX 완벽 통합 원할 때 | `TikZ` / `pgfplots`                      |


#### `Pd.df.loc`
Pandas의 DataFrame을 사용할때 `iloc`과 `loc`을 이용해서 인덱싱을 많이 하는데 `loc`의 경우는 DataFrame에서 바로 인덱싱을 해도 되지만 더 폭 넓은 인덱싱이 가능했다.

예를 들면
```python
df['company':'agent'] # 접근 안됨

df.loc['company':'agent'] # 마치 numpy처럼 인덱싱이 가능
```

#### Seaborn의 `heatmap`
Seaborn에서 사용할만한 함수는 Boxplot과 heatmap함수일 것 같다.
```python
sns.heatmap(df.corr(), annot=true)
```
`sns.heatmap()` 함수의 경우 df를 그대로 넣는 것이 아니라 correaltion을 구한 다음에 넣는다는 것이 포인트.

#### Pandas DataFrame 주요 메서드 및 변수
개인적으로 pandas는 굳이 사용할 일이 없었는데, 다루는 데이터가 DataFrame이 아니다보니 쓸일이 아예 없었다. 그러나 데이터 사이언스 관점에서는 동일한 과정이 진행되기 때문에 한번 공부해보는 것이 좋다고 판단되어 정리를 해보았음.
`df.describe()`
`df.info()`
`df.shape`
`df.dtype()`
`df.rename()`: column명을 바꿀때 사용하곤 한다
`df.drop(columns='')`: 해당 데이터 삭제. 기본적으로 row 삭제. 그러나  column도도 삭제 가능
`df.isna().any(axis=1)`: 결측값이 있는 row를 bool인덱싱할때 유용하다.
`df.dropna()`: 결측치 있는 데이터 삭제. 그러나 데이터를 삭제한다는 것은 신중하게 해야하므로 확신이 있을때 사용.
`df.fillna()`: 결측치가 있는 데이터를 보완하기 좋음!
`df.duplicated()`: 중복된 데이터 찾기. df.duplicated().sum()
df.duplicated(subset='컬럼명', keep='last')
`df.drop_duplicates()`: 중복값 삭제
`df.unique()`:유일한 값을 뽑아낼때 유용
`df.astype()`: data type 설정
`df.value_counts(dropna=False, normalize=True)`
`df.str`: 문자열 처리

- 다만 DataFrame과 Series는 각각 적용될 수 있는 함수가 다르다. 즉, 그때 그때 잘 찾아봐라...(중요하진 않음)

---


## 2025-05-20 Tue
### 왜 AI 엔지니어는 선형대수를 배워야하는가?
수업 시간에 나왔던 질문이었는데 나름 정리가 잘 되어있다고 생각했지만 강사님이 버벅이는거 보고 나도 다시 한번 정리해야겠다는 생각이 들었다.

#### 우리가 다루는 데이터에 접근하기 위함
일단 딥러닝에 한해서 답변을 생각해보면 결국 우리가 다루는 데이터가 핵심일 것이다. 딥러닝은 데이터를 통해서 학습을 시키기 때문에 해당 데이터에 접근해야하는데, 우리가 다루는 데이터(사진, 음성, 고차원 신호)를 들여다 보면 결국 어떤 엔지니어가 설계했을 것이고 데이터에 접근하는 방식은 직관적일것이다. 미치지 않고서야 데이터의 값을 별 인간이 이해하지 못하게 설계하진 않았겠지. 아무튼 너무 당연한 현상을 길게 풀어쓰려다보니까 말이 약간 꼬였는데 **데이터의 값에 접근하는 것은 인간의 사고를 벗어나지 않는 직관적인 방식**이라는 것이 포인트.

#### 딥러닝 모델도 선형적인 모델이 최선
신기하게도 딥러닝의 가장 작은 단위인 뉴런도 선형적인 모델을 사용하고 있다(물론 activation function까지 포함한 비선형적인 형태로 존재하지만). 그럼 뉴런의 구조가 2차,3차식이나 sin이나 복잡한 비선형 구조를 쓰면 안되는가?에 대한 의문이 들었고 이건 많은 연구자들이 이미 고민을 했을 부분일 것이다. 그런데 왜 안됐을까? 이건 당연히 구현이 안되거나, 구현을 해도 비효율적이여서 그랬을 것이다. sin이나 여러 비선형 함수는 직관적이지도 않을뿐더러 학문적 뿌리도 없고 무엇보다 backpropagation을 어떻게 구현할것인가? 답이 없다. 그럼 차수가 2,3인 구조는? backpropagation까지는 가능하겠지만 늘어나는 연산량에 비해서 정보가 주는 효율성이 없다. 주어진 데이터는 한정적인데 그걸 제곱한다고 한들 어떤 유의미한 결과를 낼 수 있을까? 아마 overfitting 되는 결과만 초래했을 것이다.

#### 결론은
데이터도 그렇고 딥러닝의 모델도 그렇고 우리는 결국 선형적인 데이터와 모델을 통해서 지금 시대의 딥러닝 기술까지 오게 된것이다. 모든 엔지니어의 목표인 비선형적인 시스템을 구축하는 것을 딥러닝이라는 방식으로 구현이 되었으며 이것이 인공지능이라는 분야가 발전해온 역사와 백그라운드에 대한 이해 없이는 답을 하기가 매우 어렵다는 사실을 느꼈다.

---

## 2025-05-21 Wed
- 머신러닝에서 bias-variance 분석은 MSE와 같은 제곱 형태의 loss 기반에서 가장 널리 활용됨.

---

## 2025-05-22 Thu
#### 로지스틱 회귀
- log-likelyhood를 최대화하는 것과 비용함수(Cross-Entropy)를 직접 미분한 결과가 같다?
- Regularization은 data scaling(normalization, standardization)이 필요한 예시이기도 하다.

---

## 2025-05-26 Mon
#### hotel_bookings.csv
- 호텔의 이용자 수를 Regression 해보는 데이터셋
- 대부분 수치형 데이터이며 train과 test을 미리 나눠서 제공됨. 

#### RMSLE (Root Mean Squared logarithmatic Error)
- 작은 수일수록 민감
- 과소 예측에 관대, **과대예측**에 더 민감
- 데이터 크기 차이가 클 때 적합  

| 실제값  | 예측값  | MAE  | MSE       | *RMSLE* |
| ---- | ---- | ---- | --------- | ----- |
| 10   | 100  | 90   | 8100      | **2.30**  |
| 1000 | 2000 | 1000 | 1,000,000 | **0.69**  |

- 상대적 오차를 평가하기 좋음. 위 표에서 1번 row는 값은 작지만 10배나 틀렸을때와 2번 row에서 값은 크지만 2배 밖에 틀리지 않을때 상대적 차이를 더 잘 표현한다.

---


## 2025-05-27 Tue
#### Decision tree
- 설명이 중요할때 사용되는 분류 모델
- **정보이득(Information Gain)** 이 최대가 되는 특성으로 데이터를 나눔
- 대표적인 이진 분할 알고리즘 `CART ` 
- **랜덤 포레스트(Random forest)** 는 결정 트리의 앙상블(Ensemble) 형태
- 싸이킷런에서 제공하는 대표적인 데이터셋을 이용해서 트리 모델을 구현해봄봄
```python
from sklearn.datasets import load_iris # iris 데이터셋
from sklearn.datasets import fetch_california_housing # 캘리포니아 housing 데이터셋
from sklearn.datasets import make_moons
```

---

## 2025-05-28 Wed
#### RMSLE (Root Mean Squared logarithmatic Error)에 대한 이해2
- 일단 상황은 '예측된 모델이 음수를 뱉어내는데 해결할만한 테크닉이 없을까?'에서 시작
- 코드잇의 과제에서 **RMSLE**를 준 이유가 이것에 해당됨.
- 애초에 학습시 label 값을 `np.log1(y_train)`으로 변환하여 학습하는 것은 회귀 문제에서 흔한 일임.
- 특히 나의 데이터가 skew되어 있을때 정규분포로 가깝게 데이터를 바꿔서 모델이 전체 분포를 고르게 학습하도록 가능
- gradient 폭주(exploding gradient)를 예방한다고 한다. gradient 값이 조금 더 부드럽고 안정적으로 학습이 되도록 도와준다.
- Target Transformation, Log-Transform Regression, 
```python
from sklearn.metrics import root_mean_squared_log_error
```
---


#### `np.array()`와 `np.asarray()`
- np.array()의 경우 배열의 **복사본**을 생성
- np.asarray()의 경우 입력 배열과 반환된 배열이 메모리를 공유가능

```python
import numpy as np

arr1 = np.array([1, 2, 3])
arr2 = np.asarray(arr1)

arr1[0] = 777

print(arr1)  # 출력: [777  2  3] 
print(arr2)  # 출력: [777  2  3]
```


#### `np.expm1()`
- 기존 `np.log1p()`의 역변환 형태

---


## 2025-05-29 Thu

#### 차원(dimension)과 tensor의 개념 그리고 rank of matrix...
- 차원(dimension) = feature의 수? NO!
- 

```python 
c = np.array([[1, 2, 3], [4, 5, 6], [4, 6, 1], [2, 3, 9]])  # 2 (4, 3)
c = np.array([[1, 2, 3], [4, 5, 6], [13, 6, 1]])  # 2 (3, 3)
c = np.array([[[1, 2, 3], [4, 5, 6], [13, 6, 1]]])  # 3 (1, 3, 3)
c = np.array([[[1, 2], [4, 5], [13, 6]]])  # 3 (1, 3, 2)
# c = np.array([[[1, 2, 4, 5, 13, 6]]])  # 3 (1, 1, 6)


print(f"Dim: {c.ndim}")
print(f"shape = {c.shape}")
print(np.linalg.matrix_rank(c))
``` 
- 앞으로 tensor를 이해하는데 중요할 것이다.

---

## 2025-05-30 Fri

#### `plt.tight_layout()`과 `plt.show()`
- 레이아웃 정리를 할 때 `plt.tight_layout()`

```python
import matplotlib.pyplot as plt

fig, axs = plt.subplots(2, 1)  # 2개의 서브플롯 (위, 아래)

axs[0].plot(range(10))
axs[0].set_title("First Plot with a Long Title That Might Overlap")
axs[0].set_xlabel("X Axis (First)")
axs[0].set_ylabel("Y Axis (First)")

axs[1].plot(range(10))
axs[1].set_title("Second Plot")
axs[1].set_xlabel("X Axis (Second)")
axs[1].set_ylabel("Y Axis (Second)")

# plt.tight_layout()  # 이걸 주석 처리하면 아래처럼 겹칠 수 있음

plt.show()
```

- `plt.show()`는 왜 사용하는가?
  => 모든 그래프를 화면에 실제로 **렌더링(보여주기)** 위한 함수
  => 주로 스크립트나 Jupyter 외부 환경에서 명시적으로 써야 그래프가 뜸

- 그래프 시각화할 때 **습관** 들이기

```python
# 1. 그래프 그리고
# 2. 라벨/타이틀 붙이고
# 3. tight_layout()으로 레이아웃 정리하고
# 4. show()로 화면에 출력

plt.tight_layout()
plt.show()
```
#### Decision Tree는 특성 공간을 사각 격자로 나눈다?
- 이진 결정 트리에서, 각 노드는 데이터를 두 개로 나눔 (binary split)
따라서 리프 노드 수는 최대 2^D개
- 결정 트리는 특성의 각 축에 대해 '작다/크다'를 나누는 모델

---


## 2025-05-30 Fri

#### eigen vector, eigen value와 PCA
- 오늘 수업에서는 PCA를 다뤘지만 강사님이 선형대수와 PCA의 상관관계는 모르는듯 하고 1차원적으로 해석을 했다. 공식만 놓고 설명을 하려니 당연히 개념을 추상적으로 설명할 수밖에 없고 특별한 insight를 설명하기 매우우 어렵다. 차라리 커리큘럼상 PCA만 개념적으로 간단하게 설명하고 실습을 진행하는게 지금 과정에서 맞는 것 같다는 생각을 100번...

- 그렇다면 eigen vector와 eigen value를 뭐라고 설명해야하나? 
`Av = (lam)v`
라는 식을 직관적으로 설명하면 뻔한 설명밖에 안된다. 여기서 뻔하다는 말은 선형대수를 배우지 않은 학부생에게 설명을 시키면 기대할 수 있는 답변이라는 것이다. 중요한건 이 식이 가진 의미와 insight인데... 사실 나도 딱 떨어지는 설명은 하지 못하겠다. 다만 천천히 분해해보면...
1) Av는 선형대수의 관점에서 linear transformation이다. A가 만약 우리가 익숙한 rotation을 해주는 matrix라면 저 벡터는 기하학적으로 회전이 되는 연산일 것이다. 우변은 단순 스칼라 곱이니까 두 항이 같을 수 있는 v를 찾는게 목표
2) 


#### Covariance, Correlation
---

## 2025-06-02 Mon

#### bank-additional-full.csv
- 유명한 Binary 분류 데이터
- 특징적인 것은 범주형(categorical) 데이터가 많이 있음
- `pd.get_dummies`: 
- `ColumnTransformer` + `Pipeline` 구조는 깔끔한 코드와 재사용성의 핵심

```py
from sklearn.compose import ColumnTransformer
from sklearn.preprocessing import OneHotEncoder, StandardScaler
from sklearn.pipeline import Pipeline
from sklearn.ensemble import RandomForestClassifier

# 수치형/범주형 column 리스트를 따로 정의
numeric_features = [...]
categorical_features = [...]

preprocessor = ColumnTransformer(
    transformers=[
        ("num", StandardScaler(), numeric_features),
        ("cat", OneHotEncoder(handle_unknown="ignore"), categorical_features)
    ]
)

clf = Pipeline(steps=[
    ("preprocessor", preprocessor),
    ("classifier", RandomForestClassifier(random_state=42))
])
```
---

## 2025-06-03 Tue

---

## 2025-06-04 Wed

---

## 2025-06-05 Thu
