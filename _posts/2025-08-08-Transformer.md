---
layout: post
title:  "10-(4) Transformer 모델은 Seq2Seq 구조와 어떤 점에서 근본적으로 다른가요?"
date:   2025-08-08 14:00:00 +0900
categories: [Deep Learning, NLP]
tags: [NLP, Trasnformer, Deep Learning, AI]
comments: true     # 댓글 기능 사용 (옵션)
image:
    path: https://gaussian37.github.io/assets/img/dl/concept/transformer/2.png
---
## 🟢 Transformer 모델은 Seq2Seq 구조와 어떤 점에서 근본적으로 다른가요?
앞서 설명한 attention 매커니즘은 구조적인 측면에서 RNN을 사용한다는 점은 동일했다. 즉, 기존 seq2seq 모델에 추가적인 attention modeule을 추가한 형태라고 한다면 **Transformer는 아예 새로운 아키텍처**라고 보면 되겠다. 즉,

* (1세대) RNN 기반의 기본 Seq2Seq
* (2세대) RNN 기반 Seq2Seq + Attention (성능 개선)
* (3세대) Transformer (RNN을 완전히 대체한 새로운 구조)


<p align="center">
  <img src="https://miro.medium.com/1*tb9TT-mwFn1WPzkkbjoMCQ.png
  " alt="attention" width="80%" style="display: block; margin: 0 auto;">
</p>



그래서 지금부터는 현재 AI 산업의 가장 큰 축인 LLM의 핵심 아키텍처인 Transformer에 대해서 알아보겠다.

---

#### ⚪ Seq2Seq vs Transformer
전통적인 Seq2Seq 모델이 **RNN(순환 신경망)**을 사용해 데이터를 **순차적으로(sequentially)** 처리하는 반면, Transformer는 **RNN을 완전히 제거**하고 **Self-Attention**이라는 메커니즘을 사용해 데이터를 **병렬적으로(in parallel)** 처리함.

---

#### ⚪ 데이터 처리 방식: 순차적 vs. 병렬적

* **Seq2Seq (RNN 기반)**
    RNN은 단어를 **하나씩 순서대로** 처리. 첫 번째 단어를 처리한 결과를 바탕으로 두 번째 단어를 처리하고, 그 결과를 바탕으로 세 번째 단어를 처리하는 식. 이런 순차적인 구조 때문에 **병렬 처리가 불가능**해서 학습 속도가 느림.

* **Transformer**
    Transformer는 Self-Attention을 통해 문장 내 모든 단어를 **한 번에 동시에** 바라봄. 각 단어가 문장 내 다른 모든 단어와 어떤 관계를 맺고 있는지 병렬적으로 계산함. 이 덕분에 GPU의 병렬 연산 능력을 최대한 활용할 수 있어서 **학습 속도가 비약적으로 빨라짐**.



---

#### ⚪ 장기 의존성(Long-Term Dependency) 처리

* **Seq2Seq (RNN 기반)**
    문장이 길어지면 문장 앞부분의 정보가 뒤로 갈수록 희석되거나 소실되는 **장기 의존성 문제**에 취약했음. 정보가 여러 단계를 거치면서 전달되다 보니 병목 현상이 생김

* **Transformer**
    Self-Attention은 문장의 처음과 끝에 있는 단어라도 **직접적인 연결**을 통해 한 번에 관계를 계산해. 아무리 멀리 떨어진 단어라도 정보 전달 경로가 짧고 직접적이기 때문에 **장기 의존성 문제를 매우 효과적으로 해결**함.

---

##### ⚪ 위치 정보 처리 방식

* **Seq2Seq (RNN 기반)**
    단어를 순서대로 입력받는 구조 자체가 단어의 순서 정보를 자연스럽게 담고 있음.

* **Transformer**
    모든 단어를 한 번에 처리하기 때문에 모델이 단어의 순서를 알 수 없음. 그래서 **Positional Encoding**이라는 별도의 장치를 사용해 "이 단어는 문장의 n번째 위치에 있다"라는 위치 정보를 인위적으로 주입해 줘야 함.

---

## 🟢 핵심 차이점 요약

| 특징 (Feature) | Seq2Seq (RNN-based) | Transformer |
| :--- | :--- | :--- |
| **핵심 엔진** | RNN (LSTM, GRU) | Self-Attention |
| **데이터 처리** | 순차적 (Sequential) | 병렬적 (Parallel) |
| **학습 속도** | 느림 | 빠름 |
| **장기 의존성** | 취약함 (정보 소실) | 강함 (직접 연결) |
| **위치 정보** | 구조에 내재됨 | Positional Encoding으로 주입 |

결론적으로, Transformer는 RNN의 순차적 처리라는 고질적인 한계를 Self-Attention을 통한 병렬 처리로 극복하면서, 더 빠르고 강력하게 문맥을 이해하는 모델로 자리 잡게 되었다. 

구글의 **"Attention Is All You Need"**의 논문은 기존 RNN 구조를 버리고 오로지 Attention을 활용한 혁신적인 구조를 제시하면서 현대 NLP의 핵심 요소로 자리잡았고, 어텐션 기반 병렬 처리라는 새로운 패러다임을 열어서 BERT, GPT 같은 현대 NLP 모델들의 기반을 마련했다.

## 🟢 예시 답안 (코드잇 제공)
> 
- Transformer 모델은 Seq2Seq 구조와 비교했을 때, 가장 큰 근본적인 차이점은 RNN을 사용하지 않고, 전적으로 Attention 메커니즘만으로 시퀀스를 처리한다는 점입니다. 
- 전통적인 Seq2Seq 모델은 RNN, LSTM, GRU 같은 순환 신경망 구조를 사용하여 입력 시퀀스를 시간 순서대로 처리합니다. 이 구조는 시간 흐름을 따라 정보를 전달할 수 있지만, 병렬 연산이 어렵고, 긴 시퀀스일수록 학습 속도가 느려지며, 장기 의존성 문제가 발생할 수 있습니다. 
- 반면 Transformer는 모든 입력 토큰 간의 관계를 한 번에 계산할 수 있는 Self-Attention 메커니즘을 기반으로 동작합니다. 덕분에 각 단어가 문장 내 다른 단어들과 어떻게 연결되는지를 병렬적으로 학습할 수 있으며, 연산 속도가 빠르고, 긴 문장에서도 정보 손실 없이 문맥을 반영할 수 있습니다.
- 또한 Transformer는 Positional Encoding이라는 기법을 사용해 입력 토큰의 순서 정보를 보완합니다. 이는 RNN처럼 순차적으로 데이터를 처리하지 않기 때문에 발생할 수 있는 순서 정보 손실 문제를 해결하는 방식입니다. 
- 결과적으로 Transformer는 Seq2Seq보다 병렬 처리 효율이 뛰어나고, 긴 문장에서도 더 안정적인 성능을 보이며, 기계 번역, 텍스트 요약, 문장 생성 등 다양한 자연어처리 과제에서 기존 Seq2Seq을 대체하고 있습니다.