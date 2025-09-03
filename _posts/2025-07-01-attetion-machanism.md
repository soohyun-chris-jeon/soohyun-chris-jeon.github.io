---
layout: post
title:  "[ViT 이해하기(1)] Attetion 매커니즘에 대하여"
date:   2025-07-01 14:00:00 +0900
categories: [Deep Learning, Vision Transformer]
tags: [ViT, Vision Transformer, Trasnformer, Deep Learning, AI]
comments: true     # 댓글 기능 사용 (옵션)

---


## 🟣 Intro

개인적으로 준비하는 논문 중에 Vision Transformer(ViT)를 활용한 Phase Unwrapping 논문이 있다. 예전에 준비를 하다가 개인적으로 엎어진 논문인데, 시간이 꽤 지난 지금도 연구적으로 가치가 있어 보이기 때문이다. 

그 논문을 준비한 시기가 한창 ViT가 유행이었던 2021년 정도인데 지금도 ViT에 대해서는 연구적으로 성숙도가 그렇게 진전이 없는 것 같다. 그만큼 ViT가 아직도 미지의 영역이며 연구적인 포텐셜이 높다는 방증이기도 한 것 같다.

하기야 LLM이나 NLP에서 Transformer가 이제야 산업에서 폭발적인 반응을 얻기 시작했고 데이터의 복잡도가 더 높은 이미지에 대해서 Transformer 기술이 완전히 성숙되려면 아직 시간이 더 필요할 것 같다는 개인적인 의견이다.

그래서 이번에 ViT에 대한 포스팅을 시리즈로 작성할 계획이다. 예전에 준비하면서도 복잡해서 자세히 공부 못했던 부분을 차근차근 모으고, 이어 붙여서 나름 ViT 전문가가 되어보려고 한다.

---
#### ⚪ Attetion 매커니즘



## 🟣