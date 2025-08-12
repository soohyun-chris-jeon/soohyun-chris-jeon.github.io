---
layout: post
title:  "10-(4) Transformer 모델은 Seq2Seq 구조와 어떤 점에서 근본적으로 다른가요?"
date:   2025-08-08 14:00:00 +0900
categories: [Codeit AI 3기, Weekly Paper]
tags: [NLP, Trasnformer, Deep Learning, AI]
comments: true     # 댓글 기능 사용 (옵션)

---


## 🟢 TBU
---
#### ⚪ TBU..

## 🟢 예시 답안 (코드잇 제공)
> 
- Transformer 모델은 Seq2Seq 구조와 비교했을 때, 가장 큰 근본적인 차이점은 RNN을 사용하지 않고, 전적으로 Attention 메커니즘만으로 시퀀스를 처리한다는 점입니다. 
- 전통적인 Seq2Seq 모델은 RNN, LSTM, GRU 같은 순환 신경망 구조를 사용하여 입력 시퀀스를 시간 순서대로 처리합니다. 이 구조는 시간 흐름을 따라 정보를 전달할 수 있지만, 병렬 연산이 어렵고, 긴 시퀀스일수록 학습 속도가 느려지며, 장기 의존성 문제가 발생할 수 있습니다. 
- 반면 Transformer는 모든 입력 토큰 간의 관계를 한 번에 계산할 수 있는 Self-Attention 메커니즘을 기반으로 동작합니다. 덕분에 각 단어가 문장 내 다른 단어들과 어떻게 연결되는지를 병렬적으로 학습할 수 있으며, 연산 속도가 빠르고, 긴 문장에서도 정보 손실 없이 문맥을 반영할 수 있습니다.
- 또한 Transformer는 Positional Encoding이라는 기법을 사용해 입력 토큰의 순서 정보를 보완합니다. 이는 RNN처럼 순차적으로 데이터를 처리하지 않기 때문에 발생할 수 있는 순서 정보 손실 문제를 해결하는 방식입니다. 
- 결과적으로 Transformer는 Seq2Seq보다 병렬 처리 효율이 뛰어나고, 긴 문장에서도 더 안정적인 성능을 보이며, 기계 번역, 텍스트 요약, 문장 생성 등 다양한 자연어처리 과제에서 기존 Seq2Seq을 대체하고 있습니다.