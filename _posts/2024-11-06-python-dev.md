---
layout: post
title: "VSCode Python 개발 환경 기본 셋팅 가이드"
date: 2024-11-10 00:00:00 +0900
categories: [Dev Environment]
tags: [python, VScode, WSL, AI, Deep Learning]
pin: false
comments: true     # 댓글 기능 사용 (옵션)

---
## 🟣 본격적인 Python 공부 위한
Visual Studio Code(VSCode) 셋팅을 정리한 문서.

## 왜 VScode를?
과거 python은 파이참(pycharm) 아니면 주피터노트북(jupyer notebook)이 대세를 이뤘다. 하지만 개인적으로 파이참은 필요 이상으로 무거웠고 주피터 노트북은 웹기반이라서 불안정한 느낌이라서 불안했다.

그런 와중에 마소에서 VScode라는 코드 편집기를 내놓았는데... 보자마자 깔끔한 인터페이스가 눈에 띄었으며 Extension을 잘 세팅하면 내 개발환겨을 간편하게 만들 수 있을 것 같았다. python의 정체성 그 자체인 확장성과 잘 맞는 앱이라 생각이 들어서 무조건 활용해야겠다는 생각을 헀다.

또한 과거 C/C++ 공부를 할때 Visual Studio라는 무거운 앱을 사용했는데 VScode는 텍스트 에디터라는 정체성을 느낄 수 있게 가벼워서 너무나 호감이 들었다.

그리고 4~5년이 지난 이후 VScode는 이미 엄청난 성공을 거뒀으며 AI 개발자가 쓰지 않으면 좀 이상할 정도로 성장했다.

그래서 python 개발 환경을 위한 VScode 세팅 과정을 포스팅이 필요하겠다고 판단하여 정리를 해보았다.


## 🔧 필수 확장 프로그램

| 확장 이름 | 설명 |
|----------|------|
| `Python` (by Microsoft) | Python 기본 확장 (디버깅, 코드 실행, 환경 관리) |
| `Pylance` | 빠른 타입 체크 및 인텔리센스 지원 |
| `Jupyter` | `.ipynb` 파일 실행 및 셀 기반 실행 지원 |
| `Black Formatter` | Python 코드 자동 정렬 (PEP8 기반) |
| `isort` | import 문 정렬 도구 |
| `Python Indent` | 들여쓰기 오류 보정 |
| `Code Runner` | 빠른 코드 실행 (`Ctrl + Alt + N`) |
| `GitLens` | Git 시각화 도구 (협업 시 필수) |

---

## ⌨️ 유용한 단축키

### 🧑‍💻 편집 관련

| 기능 | 단축키 (Windows/Linux 기준) |
|------|-----------------------------|
| 줄 복사 | `Shift + Alt + ↓ / ↑` | ⭐
| 줄 이동 | `Alt + ↓ / ↑` |
| 여러 줄 편집 (다중 커서) | `Alt + Click` 또는 `Ctrl + Alt + ↓ / ↑` |
| 블록 선택 | `Shift + Alt + Drag` |
| 자동 정렬 | `Shift + Alt + F` | ⭐⭐
| 코드 주석/해제 | `Ctrl + /` | ⭐⭐⭐⭐⭐

### 🧪 실행 & 탐색

| 기능 | 단축키 |
|------|--------|
| 코드 실행 | `Ctrl + F5` 또는 Code Runner 설치 시 `Ctrl + Alt + N` |
| 명령 팔레트 열기 | `Ctrl + Shift + P` | ⭐⭐
| 탐색기 열기/닫기 | `Ctrl + B` |
| 터미널 열기 | `Ctrl + '` | ⭐
| 최근 열었던 파일 | `Ctrl + P` | ⭐

---

## 🧹 코드 스타일 및 정리

### Black + isort + Pylance 조합 추천

1. **⭐Black 설치** (가상환경에서)

    ```bash
    pip install black isort
    ```

2. **VSCode 설정 (`settings.json`)**

    ```json
    {
      "python.formatting.provider": "black",
      "editor.formatOnSave": true,
      "editor.codeActionsOnSave": {
        "source.organizeImports": true
      },
      "python.languageServer": "Pylance"
    }
    ```

3. **단축키로 정렬**: 저장할 때 자동 적용됨 (`Ctrl + S`)

---

## 💡 기타 유용한 팁

- **가상환경 자동 인식 안 될 때**  
  - `Ctrl + Shift + P` → `Python: Select Interpreter`로 수동 선택
- **실행 버튼이 안 보일 때**  
  - 파일 상단에 `# %%` 작성 → Jupyter 실행 영역 활성화
- **터미널 여러 개 띄우기**  
  - `+` 버튼 또는 `Ctrl + Shift + \` 로 세션 분할

---

## 📦 추천 유틸리티

| 라이브러리 | 용도 |
|------------|------|
| `rich` | 터미널에서 예쁜 출력 |
| `typer` | CLI 앱 만들기 편리함 |
| `pytest` | 단위 테스트 도구 |
| `requests` | HTTP 요청 보낼 때 |
| `matplotlib / seaborn` | 시각화 |
| `pandas` | 데이터 분석 |

---

## 📝 마무리

아직도 python을 주피터 노트북으로 사용하고 계시는 AI 개발자라면 반드시 VScode를 사용하기를 권한다. 