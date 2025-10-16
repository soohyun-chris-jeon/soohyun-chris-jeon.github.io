---
layout: post
title:  "10-(1) 텍스트 데이터를 모델에 적용하기 전에 어떤 전처리 과정을 거치나요?"
date:   2025-08-08 10:00:00 +0900
categories: [Deep Learning, NLP]
tags: [NLP, Tokenization, Deep Learning, AI]
image:
  path: https://media.licdn.com/dms/image/v2/D5612AQGeJ5FET7M8lQ/article-cover_image-shrink_720_1280/B56ZebNFxzG0AI-/0/1750655621243?e=2147483647&v=beta&t=q_F45m3wtJbYY9-ARt9VZd8eZ7tsc32-JG-CqdOj9Ew
comments: true     # 댓글 기능 사용 (옵션)

---

## 🟢 텍스트 데이터를 모델에 적용하기 전에 어떤 전처리 과정을 거치나요?

컴퓨터 비전(CV)와 마찬가지로 텍스트 데이터를 모델에 넣기 전에 꼭 거쳐야 하는 '전처리(Preprocessing)' 과정에 대해서 간략하게 정리해보았다. 텍스트 데이터의 특성에 맞게 '자연어 처리(NLP)를 위한 데이터 정제' 과정이라고 생각하면 된다.


---

## 🟢 텍스트 데이터 전처리(Pre-processing)

컴퓨터는 사람처럼 글을 바로 이해할 수 없다. 그래서 모델이 이해할 수 있는 숫자 형태(벡터)로 바꿔주기 전에, 의미 없는 정보를 걸러내고 문장을 일정한 규칙으로 정리하는 과정이 필요함. 보통 아래와 같은 단계를 거치게 됨.

#### ⚪ 1. **토큰화 (Tokenization)**
가장 기본적이면서 중요한 단계. 텍스트를 모델이 처리할 수 있는 작은 단위, 즉 **토큰(Token)**으로 나누는 과정. 보통 단어(word)나 문장(sentence) 단위로 잘라냄.

* **예시**: "I am a boy." → `["I", "am", "a", "boy", "."]`

<p align="center">
  <img src="https://img1.daumcdn.net/thumb/R1280x0.fpng/?fname=http://t1.daumcdn.net/brunch/service/user/aPda/image/YWW7PelDeE0DPua78Fkp6qwpAN0.png" alt="토큰화 과정" width="80%" style="display: block; margin: 0 auto;">
</p>

#### ⚪ 2. **정제 (Cleaning) 및 정규화 (Normalization)**
텍스트에서 분석에 불필요한 노이즈를 제거하고, 표현이 다른 단어들을 하나로 통일하는 과정.

* **주요 작업**:
    * **소문자 변환**: `Apple`과 `apple`을 같은 단어로 취급하기 위해 모두 소문자로 바꿈.
    * **구두점/특수문자 제거**: 문장 부호(`.` `,` `?` `!`)나 특수문자(`@` `#` `$`) 등 분석에 방해가 되는 요소들을 제거.
    * **불필요한 공백 제거**: 의미 없는 여러 개의 공백이나 줄 바꿈 문자를 제거.

#### ⚪ 3. **불용어 (Stop words) 처리**
문장에서 자주 등장하지만 실제 의미 분석에는 큰 도움이 되지 않는 단어들을 제거하는 과정. 예를 들면 `a`, `the`, `is`, `in` 같은 관사, 전치사, 조사 등이 해당됨.

* **예시**: `["I", "am", "a", "boy"]` → `["I", "boy"]` (am, a가 불용어라고 가정)
* **주의**: 불용어 목록은 작업의 목적에 따라 달라질 수 있어. 무조건 제거하는 게 능사는 아님.

<p align="center">
  <img src="https://img1.daumcdn.net/thumb/R1280x0.fjpg/?fname=http://t1.daumcdn.net/brunch/service/user/aPda/image/a8F84mMtOY6JITF5hicDzBuQ3r8.jpg" alt="불용화" width="80%" style="display: block; margin: 0 auto;">
</p>


#### ⚪ 4. **어간 추출 (Stemming) & 표제어 추출 (Lemmatization)**
단어의 형태가 달라도 결국 같은 의미를 갖는다면, 이들을 하나의 대표 단어로 통일하는 과정. 모델이 학습해야 할 단어의 수를 줄여서 성능을 높이는 효과가 있음.

* **어간 추출 (Stemming)**: 단어의 어미를 강제로 잘라내서 어간(stem)을 찾음. 문법적 정확성보다는 속도가 빠르다는 장점이 있음. (e.g., `studies`, `studying` → `studi`)
* **표제어 추출 (Lemmatization)**: 단어의 문법적 형태와 품사(POS)까지 고려해서 원형 단어, 즉 **표제어(Lemma)**를 찾음. 어간 추출보다 정확도가 높지만 시간이 더 걸림. (e.g., `am`, `is`, `are` → `be` / `studies`, `studying` → `study`)

<p>
  <img src="https://media.licdn.com/dms/image/C4D12AQEZCHQOHXSEhg/article-cover_image-shrink_600_2000/0/1650689035153?e=2147483647&v=beta&t=uRsPEF-Apt9EvVTcUGR_ZhAs_Dk39de4MFQDo78LHos" alt="어간추출, 표제어 추출" width="80%" style="display: block; margin: 0 auto;">
</p>


#### ⚪ 5. **벡터화 (Vectorization)**
정제된 텍스트를 컴퓨터가 이해할 수 있는 **숫자 벡터**로 변환하는 과정.

* **대표적인 방법**:
    * **Bag-of-Words (BoW)**: 단어의 순서는 무시하고, 각 단어가 텍스트에 몇 번 등장했는지 빈도를 세서 벡터로 만듦.
    * **TF-IDF**: 단순히 단어의 빈도만 세는 것을 넘어, 다른 문서에서는 잘 등장하지 않는 특정 단어에 가중치를 주는 방식.
    * **워드 임베딩 (Word Embedding)**: 단어의 의미와 문맥을 다차원 공간의 벡터로 표현하는 방식. **Word2Vec**, **GloVe**, **FastText** 등이 여기에 해당하며, 최근 LLM에서는 이 방식이 기본적으로 사용됨.

<p>
  <img src="https://images.velog.io/images/csy9604/post/6e772dfd-7eaa-475c-813a-209bbeb959ce/image.png" alt="vectorization" width="100%" style="display: block; margin: 0 auto;">
</p>



---



## 🟢 예시 답안 (코드잇 제공)
> 
- 텍스트 데이터를 모델에 적용하기 전에 반드시 전처리 과정을 거쳐야 합니다. 텍스트는 구조화되지 않은 형태로 존재하기 때문에, 이를 수치적으로 처리 가능한 형태로 변환해주는 것이 전처리의 핵심 목적입니다. 
- 가장 기본적인 전처리는 불필요한 문자 제거입니다. 예를 들어, HTML 태그, 특수 문자, 숫자, 이모지 등을 제거하거나 필요한 경우에만 유지하는 식으로 데이터를 정리합니다. 
- 그다음으로는 소문자 변환을 많이 사용합니다. 대소문자를 통일함으로써 'Apple'과 'apple'을 같은 단어로 취급하게 되어 불필요한 중복을 줄일 수 있습니다. 
- 또한, 불용어 제거도 중요한 과정입니다. 불용어는 '의', '이', '가', 'the', 'is', 'and'처럼 자주 등장하지만 분석에 큰 의미가 없는 단어들로, 이들을 제거하면 모델이 더 중요한 단어에 집중할 수 있습니다. 
- 토큰화(Tokenization)*도 핵심 과정 중 하나입니다. 문장을 단어, 형태소, subword 단위 등으로 나누는 과정이며, 사용하는 언어와 목적에 따라 다양한 방식이 적용됩니다.
그 외에도 어간 추출(Stemming)이나 표제어 추출(Lemmatization)을 통해 단어의 기본 형태를 통일할 수도 있고, 중복 공백 제거, 이상값 필터링, 맞춤법 교정 등의 세부적인 정제 작업도 포함될 수 있습니다. 
- 이러한 전처리 과정을 통해 텍스트를 모델이 학습할 수 있는 일관된 입력 형태로 정리함으로써, 학습 효율과 성능을 향상시킬 수 있습니다.