---
layout: post
title:  "11-(2) Hugging Face Transformers 라이브러리는 무엇이며, 어떤 기능을 제공하나요?"
date:   2025-08-22 12:00:00 +0900
categories: [Codeit AI 3기, Weekly Paper]
tags: [BERT, GPT, NLP, Trasnformer, Deep Learning, AI]
comments: true     # 댓글 기능 사용 (옵션)

---


## 🟢 TBU
---
#### ⚪ TBU..

## 🟢 예시 답안 (코드잇 제공)
> 
- Hugging Face Transformers 라이브러리는 사전학습된 자연어처리 모델을 손쉽게 불러오고 사용할 수 있도록 도와주는 오픈소스 라이브러리입니다. PyTorch와 TensorFlow를 모두 지원하며, NLP 작업에 필요한 대부분의 모델과 도구를 통합적으로 제공합니다.<br>
이 라이브러리의 가장 큰 장점은, BERT, GPT, RoBERTa, T5, DistilBERT 같은 유명한 사전학습 모델들을 몇 줄의 코드만으로 불러와서 바로 사용할 수 있다는 점입니다. 복잡한 모델 구조를 처음부터 구현하지 않아도 되기 때문에, 모델 실험과 응용을 빠르게 진행할 수 있습니다. <br>
Hugging Face Transformers는 다음과 같은 기능들을 제공합니다.  
- 첫째, 사전학습된 모델 로딩 및 추론 기능입니다. AutoTokenizer와 AutoModel, 또는 pipeline 기능을 활용해 토크나이징부터 추론까지 쉽게 처리할 수 있습니다.  
- 둘째, 다양한 NLP 작업에 대한 통합 지원입니다. 문서 분류, 감성 분석, 개체명 인식, 질문 응답, 텍스트 요약, 번역, 텍스트 생성 등 주요 자연어처리 작업에 대해 일관된 인터페이스로 모델을 적용할 수 있습니다.  
- 셋째, 사용자 정의 데이터셋과의 통합 및 파인튜닝 기능입니다. Trainer 클래스를 활용하면 사용자 데이터에 맞춰 사전학습된 모델을 미세조정(Fine-Tuning)할 수 있고, 데이터셋 준비부터 학습, 평가, 저장까지의 과정도 간편하게 구성할 수 있습니다. 또한, Hugging Face의 datasets 라이브러리와도 잘 통합되어 있어, 공개 데이터셋을 빠르게 로딩하고 처리할 수 있으며, model hub를 통해 전 세계 사용자가 업로드한 수천 개의 사전학습 모델을 검색하고 활용할 수 있습니다.<br>
결론적으로, Hugging Face Transformers는 자연어처리 실무에서 생산성과 접근성을 획기적으로 높여주는 필수 도구라고 할 수 있습니다.