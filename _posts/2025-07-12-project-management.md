---
layout: post
title:  "프로젝트 구조를 통한 효율적인 협업 관리"
date:   2025-07-12 00:00:00 +0900
categories: [Deep Learning, Generative Model]
tags: [Semantic Segmentation, Generative Model, PyTorch, CNN, convolutional-neural-network, Deep Learning, AI, Computer Vision]
comments: true     # ✅ 댓글 기능 사용 (옵션)
math: true  # ✅ 요거 꼭 추가!
---

## 🔵 Intro
이번에 프로젝트#1이 킥오프되었다. 이 프로젝트는 *AI허브 경구약제 데이터*를 활용하여 object detection 수행하는 과제이며 가장 중점적인 요소는 협업을 수행하는 것이었다.

프로젝트 자체의 난이도가 높다거나 성능이 중요한 요소가 아니라 **'협업'** 그 자체에 몰입해보는 것이다.

사실 딥러닝 과제를 혼자 해보았지 이렇게 팀으로 수행을 해본 적은 없기 때문에 어디서 시작할지 굉장히 난감했지만 다행히 이러한 프로젝트 관리를 체계적으로 하기위한 방법론이 여러가지 있어서 가장 기초적인 모델을 가져왔다.

일단, 이번에는 GitHub 레포지에 올라갈 프로젝트의 구조를 포스팅해보았다.

---


#### ⚪ 프로젝트 구조

```bash
AI03-Project-1/
├── data/                    # 원본 및 전처리된 데이터
│   ├── raw/                 # 원본 데이터 ⭐ [Ai Hub 경구약제 이미지 데이터] 경로
│   ├── processed/           # 전처리된 데이터
│   └── external/            # 외부에서 받은 공개 데이터 등
│
├── notebooks/               # 실험/EDA용 Jupyter 노트북 디럭토리⭐
│   └── 250714_수현_[ooooo].ipynb         #  ex) 250714_수현_[데이터전처리].ipynb
│
├── src/                     # 핵심 코드 ⭐ 각자 역할별로 업데이트 해야하는 폴더
│   ├── __init__.py
│   ├── dataset.py           # Custom Dataset
│   ├── model.py             # 모델 정의
│   ├── train.py             # 학습 루프
│   ├── eval.py              # 평가 로직
│   ├── config.py            # 설정 값 정리 (예: argparse or dict)
│   └── utils.py             # 공통 함수들 (seed 고정, metrics 등)
│
├── experiments/             # 실험 로그 및 결과 저장
│   ├── exp_250714/          #               
│   │   ├── config.yaml      # 실험 설정
│   │   ├── model.pt         # 모델 가중치 ✔ 구글드라이브로 공유(예정)
│   │   └── results.json     # 결과 기록
│   └── ...
│
├── scripts/                 # 쉘스크립트, 파이프라인 자동화 등
│   └── train.sh
│
├── output/                 # 로그, 시각화 이미지, confusion matrix 등 ⭐ 구글드라이브로 공유(예정)
│   └── figures/
│
├── requirements.txt         # 패키지 목록 (pip 기반)
├── environment.yml          # Conda 환경 파일 (선택)
├── .gitignore
├── ProjectLog.md            # 프로젝트1 개발 일지 작성⭐
└── README.md                # 프로젝트 구조 업데이트
```



#### ⚪ 왜 이런 구조를 사용할까?

가장 큰 이유는 **관심사의 분리 (Separation of Concerns)**.
* **데이터(Data)**는 코드와 분리하고,
* **실험용 코드(Notebooks)**는 재사용 가능한 **핵심 로직(Source Code)**과 분리하고,
* **실험 결과(Experiments)**는 다시 코드와 분리하는 거지.

이렇게 하면 프로젝트가 커져도 길을 잃지 않고, 각자 맡은 부분에 집중할 수 있음. 이런 체계적인 구조가 결국 시간을 아껴주고, 실험을 **재현 가능(reproducible)**하게 만들어준다는 걸 금방 깨닫게 될 것이다. 
이건 스탠포드 대학교의 "CS 231n: Convolutional Neural Networks for Visual Recognition" 강의에서도 강조하는 프로젝트 관리 방식과 일맥상통함. [^1]

[^1]: Karpathy, A. (n.d.). *CS231n: Convolutional Neural Networks for Visual Recognition*. Stanford University. Retrieved from [https://cs231n.github.io/](https://cs231n.github.io/)

---

#### ⚪ 폴더 및 파일별 역할 상세 설명

##### 📂 `data/`
여기는 말 그대로 데이터 저장소. 코드는 절대 이 폴더 안에 있으면 안 됨.
    * `raw/`: **AI Hub의 경구약제 원본 이미지**가 저장될 곳. 여기 있는 파일은 절대 **수정하지 않는 것**이 원칙. 원본은 항상 보존해야 나중에 문제가 생겼을 때 돌아갈 수 있음.
    * `processed/`: `raw` 데이터를 우리 모델에 맞게 전처리한 결과물을 저장하는 폴더. 예를 들면, 이미지 크기를 통일하거나, object detection을 위해 bounding box 정보를 담은 label 파일을 만들거나, 데이터 증강(augmentation)을 거친 이미지들을 여기에 두게 됨.
    * `external/`: 만약 우리가 다른 출처에서 추가적인 약제 이미지를 구한다면 여기에 저장하면 됨.

##### 📂 `notebooks/`
여기는 프로젝트의 '실험실'
    * **`250714_수현_[ooooo].ipynb`**: 이런 식으로 Jupyter 노트북을 만들어서 자유롭게 데이터를 탐색(EDA)하고, 모델 아키텍처를 테스트하고, 전처리 방법을 시험해 볼 수 있음. 여기서 잘 작동하는 코드를 나중에 `src/` 폴더의 `.py` 파일로 옮겨서 모듈화 진행함. 즉, 여긴 좀 지저분해도 괜찮은 작업실 같은 공간.

##### 📂 `src/`
프로젝트의 '핵심'. **재사용 가능**하고 잘 정리된 코드를 모아두는 곳.
    * `dataset.py`: PyTorch의 `Dataset`과 `DataLoader`를 우리 '경구약제 이미지'에 맞게 만드는 코드가 들어감. 이미지를 불러오고, 전처리하고, 모델에 배치(batch) 단위로 전달하는 역할을 함. 
    * `model.py`: **Object Detection 모델**의 아키텍처를 정의하는 곳. 예를 들어 우리가 YOLO, Faster R-CNN, או SSD 같은 모델을 사용한다면 그 모델의 구조를 여기서 코드로 구현하거나 불러오게 됨. 
    * `train.py`: `dataset.py`에서 데이터를 가져오고 `model.py`에서 모델을 불러와서 **실제 학습(training)을 실행**하는 스크립트. loss function을 계산하고, optimizer로 가중치를 업데이트하는 모든 과정이 여기에 담기게 됨.
    * `eval.py`: 학습이 끝난 모델(`model.pt`)을 가지고 성능을 **평가(evaluation)**하는 스크립트야. 테스트 데이터셋에 대해 mAP(mean Average Precision) 같은 object detection 평가지표를 담는 코드.
    * `config.py`: 학습률(learning rate), 배치 사이즈(batch size), 에폭(epoch) 수 등 **모든 설정 값(hyperparameters)**을 모아두는 파일. 이렇게 하면 코드를 직접 수정하지 않고 설정 값만 바꿔서 실험하기가 간편해짐.
    * `utils.py`: 특정 파일에 속하긴 애매하지만 여러 곳에서 공통으로 사용될 함수들을 모아두는 곳. 예를 들면, 랜덤 시드(seed)를 고정해서 실험 결과를 재현하거나, 로그를 남기는 함수, 성능 지표를 계산하는 함수 등이 들어갈 수 있음.

##### 📂 `experiments/` & `output/`
* `experiments/`: **각각의 실험 기록**을 저장하는 곳. `exp_250714`처럼 날짜나 실험 이름으로 폴더를 만들고, 그 안에 해당 실험에 사용된 `config.yaml`(설정), `model.pt`(학습된 모델 가중치), `results.json`(결과)을 저장해. 이렇게 하면 '어떤 설정으로 돌렸을 때 mAP가 0.85 나왔더라?' 같은 걸 쉽게 추적할 수 있음.
* `output/`: 최종 결과물이나 시각화 자료를 저장하는 폴더야. 예를 들어, 예측 결과 이미지에 bounding box를 그려서 저장하거나, confusion matrix 이미지 등을 여기에 보관하면 됨.

##### 📂 기타 주요 파일
* `requirements.txt`: 이 프로젝트를 실행하는 데 필요한 모든 **Python 패키지 목록**. `pip install -r requirements.txt` 한 줄이면 팀원 누구나 똑같은 개발 환경을 구축할 수 있음.
* `.gitignore`: Git이 추적하지 말아야 할 파일/폴더 목록. 예를 들면, 용량이 큰 `data/` 폴더, 파이썬 캐시 파일(`__pycache__`), 우리가 쓰는 가상환경 폴더 등은 여기에 등록해서 원격 저장소(GitHub)가 지저분해지는 걸 막아줌.
* `ProjectLog.md`: 네가 제안한 것처럼, **프로젝트 개발 일지**를 여기에 기록하면 됨. "오늘은 데이터 증강 기법 A를 시도했으나 성능 하락. 내일은 B 기법 시도 예정." 이런 식으로 팀원들과 진행 상황을 공유하고, 우리가 어떤 의사결정을 했는지 기록으로 남길 수 있음.
* `README.md`: 프로젝트에 대한 간단한 설명, 설치 및 실행 방법, 그리고 지금 우리가 보고 있는 이 **프로젝트 구조**에 대한 설명을 담아두는 곳이지.

---

#### ⚪ 그래서 작업 흐름은 어떻게 될까? (초보자용 가이드)

1.  **환경 설정**: 먼저 `git clone`으로 이 저장소를 받고, `requirements.txt`를 이용해 필요한 라이브러리를 설치.
2.  **데이터 준비**: `data/raw/`에 AI Hub에서 받은 원본 데이터를 넣음.
3.  **탐색 및 전처리**: `notebooks/`에서 Jupyter 노트북으로 데이터를 뜯어보고(EDA), 어떻게 전처리할지 구상하고 테스트해. 잘 만들어진 전처리 코드는 `src/dataset.py`로 옮길 준비를 함.
4.  **핵심 코드 개발**: `src/` 폴더 안에서 각자 맡은 `model.py`, `train.py` 등을 개발함.
5.  **학습 실행**: 터미널에서 `python src/train.py` 명령으로 학습을 시작함. 이 때, 학습 결과(모델 가중치, 로그)는 `experiments/` 폴더 아래에 자동으로 저장되도록 코드를 짜야 함.
6.  **결과 분석 및 반복**: `eval.py`로 모델 성능을 평가하고, `notebooks/`에서 결과를 시각화하며 분석. 결과가 만족스럽지 않다면, 다시 3번이나 4번으로 돌아가서 모델이나 데이터 처리 방식을 개선하고 다시 실험을 반복.


## 🔵 마치며

이 구조에 익숙해지면 앞으로 어떤 딥러닝 프로젝트를 하든 자신감이 생길 것 같다. 특히 재생산성(Reproducibility)는 혼자 수행하는 프로젝트에서도 중요했지만 협업을 위해서 더욱 중요한 키워드일 것이다. 앞으로 2주 간 불편해도 이러한 워크플로우 속에서 프로젝트를 수행해볼 것이다.