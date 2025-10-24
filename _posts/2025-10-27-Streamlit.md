---
layout: post
title:  "16-(1) Streamlit을 사용해서 AI 모델을 웹 애플리케이션에 통합하려면 모델 로드, 사용자 입력, 결과 출력의 단계를 거쳐야합니다. 각각의 단계에 대해 설명해주세요."
date:   2025-10-27 00:00:00 +0900
categories: [Streamlit]
tags: [Quantization, Streamlit, Docker, Deep Learning, AI]
comments: true     # 댓글 기능 사용 (옵션)
image:
    path: https://blog.zarathu.com/posts/2023-02-01-streamlit/logo.jpeg
description: "🟢 파이썬 스크립트를 공유 가능한 대화형 웹 애플리케이션 Streamlit에 대해 알아보자"

---
## 🟢 Streamlit이란?

**Streamlit**은 데이터 과학자나 AI 엔지니어가 **Python 스크립트**를 **공유 가능한 대화형 웹 애플리케이션**으로 매우 빠르고 쉽게 만들 수 있게 해주는 오픈소스 프레임워크야.


**핵심 개념:**을 간략하게 설명하면, 

1.  **Python으로만 구현**: HTML, CSS, JavaScript 같은 웹 기술을 거의 몰라도 돼. 그냥 평소 쓰던 Python 코드에 `st.write()`, `st.slider()` 같은 Streamlit 함수 몇 개만 추가하면 된다.
2.  **데이터 앱 특화**: 복잡한 웹사이트보다는 머신러닝 모델 데모, 데이터 대시보드, 리포트 공유 등 '데이터'를 보여주고 '상호작용'하는 데 최적화되어 있다.
3.  **즉각적인 반응성**: 코드를 수정하고 저장하면 웹 앱이 거의 실시간으로 자동 업데이트된다. 개발 속도가 엄청나게 빠름!

간단히 말해, **"Jupyter Notebook이나 Python 스크립트로만 보던 분석 결과나 AI 모델을, 클릭 가능한 버튼과 슬라이더가 있는 멋진 웹페이지로 순식간에 바꿔주는 도구"**라고 생각하면 되겠다.

![스트림릿](https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRCht8arD7Xl4_JCHmOVSLk-UGQuT2UzjYIGQ&s)


---


## 🟢 Streamlit의 각 단계별 설명


#### ⚪ 1. 모델 로드 (Model Load)

가장 먼저, 훈련된 AI 모델을 웹 애플리케이션의 메모리로 가져와야 합니다.

**핵심은 캐싱(Caching)입니다.** AI 모델은 크기가 크고 로드하는 데 시간이 오래 걸릴 수 있습니다. 사용자가 웹 앱에서 버튼을 누르거나 슬라이더를 조작할 때마다 모델을 새로 로드한다면 앱이 매우 느려질 것입니다.

Streamlit은 이 문제를 해결하기 위해 강력한 캐시 데코레이터를 제공합니다. 모델과 같이 한 번 로드한 후 변경되지 않는 '리소스'를 로드할 때는 \*\*`@st.cache_resource`\*\*를 사용하는 것이 가장 좋습니다.

  * 모델 로드 전용 함수를 만듭니다.
  * 함수 위에 `@st.cache_resource` 데코레이터를 붙입니다.
  * 이제 이 함수는 앱이 처음 실행될 때만 모델을 로드하고, 그 이후에는 캐시된 모델을 즉시 반환합니다.

**예시 (PyTorch 모델 로드):**

```python
import streamlit as st
import torch
from your_model_file import YourModelClass # 모델 클래스가 정의된 파일

# @st.cache_resource를 사용해 모델 로드 함수를 정의
@st.cache_resource
def load_model(model_path):
    """
    지정된 경로에서 훈련된 PyTorch 모델을 로드합니다.
    """
    model = YourModelClass() # 모델 아키텍처 인스턴스 생성
    model.load_state_dict(torch.load(model_path, map_location=torch.device('cpu')))
    model.eval() # 추론 모드로 설정
    print(f"Model loaded from {model_path}") # 터미널에 로그가 한 번만 찍히는 것을 확인
    return model

# 메인 스크립트에서 모델 로드
# 이 함수는 앱 실행 시 한 번만 실행됩니다.
model = load_model("models/best_model.pth")
```

-----

## 2\. 사용자 입력 (User Input)

모델이 추론(prediction)에 사용할 데이터를 사용자로부터 받아야 합니다. Streamlit은 다양한 위젯(widgets)을 제공하여 이 과정을 쉽게 만듭니다.

AI 모델의 종류에 따라 사용하는 위젯이 달라집니다.

  * **컴퓨터 비전 (CV):**
      * **`st.file_uploader`**: 사용자가 이미지를 업로드할 수 있게 합니다. (e.g., `type=['jpg', 'png']`)
      * **`st.camera_input`**: 웹캠을 사용해 실시간으로 사진을 찍어 입력받을 수 있습니다.
  * **자연어 처리 (NLP):**
      * **`st.text_input`**: 한 줄의 텍스트(예: 검색어)를 입력받습니다.
      * **`st.text_area`**: 여러 줄의 텍스트(예: 요약할 문단)를 입력받습니다.
  * **정형 데이터 (Tabular Data):**
      * **`st.slider`**: 특정 범위 내의 숫자 값을 입력받습니다. (예: 주택 가격 예측 시 '방 개수')
      * **`st.number_input`**: 정수 또는 실수를 입력받습니다.
      * **`st.selectbox`**: 드롭다운 메뉴에서 카테고리형 데이터를 선택받습니다.

**예시 (이미지 파일 업로드):**

```python
st.title("AI 모델 데모")

# 1단계에서 로드한 모델을 여기서 사용
# model = load_model(...) 

# 2단계: 사용자 입력 받기
st.header("이미지를 업로드하세요")
uploaded_file = st.file_uploader("분석할 이미지를 선택하세요.", type=["jpg", "png", "jpeg"])

if uploaded_file is not None:
    # 업로드된 이미지를 화면에 표시
    st.image(uploaded_file, caption="업로드된 이미지", use_column_width=True)
    st.write("") # 줄바꿈
```

-----

## 3\. 결과 출력 (Result Output)

사용자 입력을 받아 모델로 처리(추론)한 뒤, 그 결과를 사용자에게 보여주는 단계입니다.

이 단계는 크게 **(1) 데이터 전처리**, **(2) 모델 추론**, **(3) 결과 후처리 및 출력**으로 나뉩니다.

보통 사용자가 "예측" 또는 "실행" 버튼을 눌렀을 때 이 과정이 실행되도록 \*\*`st.button`\*\*을 사용합니다.

  * **`st.write()`**: 텍스트, 숫자, 데이터프레임 등 대부분의 것을 출력하는 만능 명령어입니다.
  * **`st.image()`**: 결과 이미지(예: 바운딩 박스가 그려진 이미지)를 출력합니다.
  * **`st.success()` / `st.error()` / `st.info()`**: 특정 형식의 메시지 박스를 보여줍니다.
  * **`st.bar_chart()`**: 예측 확률 등을 막대그래프로 시각화합니다.
  * **`st.spinner()`**: 모델이 추론을 수행하는 동안 "처리 중..."과 같은 로딩 스피너를 보여줍니다.

**예시 (버튼 클릭 시 예측 및 결과 출력):**

```python
# ... (모델 로드 및 파일 업로드 코드 이후) ...

# 예측 수행을 위한 버튼
if st.button("결과 예측하기"):
    if uploaded_file is not None:
        # 3-1. 데이터 전처리 (예: PIL 이미지 -> Tensor)
        from PIL import Image
        import your_transforms # 사용자가 정의한 전처리 함수

        image = Image.open(uploaded_file).convert("RGB")
        input_tensor = your_transforms.preprocess(image) # 모델이 요구하는 형식으로 변환

        # 3-2. 모델 추론 (로딩 스피너와 함께)
        with st.spinner("AI가 이미지를 분석 중입니다... 🧠"):
            with torch.no_grad():
                output = model(input_tensor.unsqueeze(0)) # 배치 차원 추가

        # 3-3. 결과 후처리 및 출력
        # 예: output 텐서를 사람이 읽을 수 있는 텍스트로 변환
        prediction_text = your_transforms.postprocess(output) 

        st.subheader("모델 예측 결과")
        st.success(f"예측된 클래스: **{prediction_text}**")
        
        # (선택) 결과 이미지나 차트 출력
        # st.image(output_image)
        # st.bar_chart(probabilities)

    else:
        st.warning("먼저 이미지를 업로드해주세요.")
```
---

## 🟢 마치며

Streamlit은 Python 코드만으로 웹 앱(Web App) 을 아주 쉽게 만들 수 있게 해주는 오픈소스 프레임워크이다.

보통 웹 앱을 만들려면 HTML, CSS, JavaScript를 다뤄야 하지만, Streamlit은 그럴 필요 없이 Python 코드만으로 데이터 시각화나 모델 데모를 웹 페이지처럼 보여줄 수 있다는 장점이 있으니 웹개발자가 아니더라도 활용도가 높을것 같다.

- 목적: 데이터를 보기 쉽게 시각화하고, ML 모델을 웹으로 보여주기 위해
- 언어: 100% Python
- 장점: 빠름, 쉽다, 직관적이다
- 비슷한 툴: Dash, Gradio, Flask (하지만 Streamlit이 제일 쉬움!)



## 🟢 예시 답안 (코드잇 제공)


>.