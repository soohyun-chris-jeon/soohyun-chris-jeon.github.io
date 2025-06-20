---
layout: post
title:  "git - .gitinore 관리하기"
date:   2025-06-19 10:00:00 +0900
categories: [git]
tags: [git, GitHub, repository]
comments: true     # 댓글 기능 사용 (옵션)
---


## 🟣 git을 사용하게 되다보니
하루의 일과가 원격 레포 GitHub에 push하면 끝나게 된다.

물론 중간중간 똑똑하게 commit을 해줘야 효율적으로 버전 관리를 하는 것이지만

지금처럼 *일단 내일 하자*는 나이브한 마인드로 내일로 한번에 다 미뤄버린다.

그런데... 모르고 새롭게 시작한 딥러닝 프로젝트 전체를 GitHub에 올려버렸고 GitHub 용량이 터져버렸다.

물론 다행히 똑똑한 GitHub는 *용량 제한이 있으니 다시 커밋해라* 정도로 끝났지만 나는 다시 방법이 필요하다는 것을 알게 되었다.

그리고 이러한 상황을 간단하게 해결하는 `.gitignore` 파일이 존재한다는 것을 알게 되었고

챗GPT에게 딥러닝 환경에 아주 쾌적한 `.gitignore` 파일을 만들어 달라고 부탁했다.


#### 🟡 `.gitignore`

나처럼 딥러닝 환경 구축하는 git 사용자에게 유용할 듯!

```py
# ===================================================================
# Python & Virtual Environments
# ===================================================================
# Python 캐시 파일
__pycache__/
*.pyc
*.pyo
*.pyd

# 가상환경 폴더 (필요에 따라 주석 해제)
# env/
# venv/
# virtualenv/
# .venv/

# 패키징 및 설치 관련 파일
*.egg-info/
*.egg
dist/
build/
wheels/
*.whl

# ===================================================================
# Deep Learning Specifics
# ===================================================================
# 1. 데이터셋 (매우 중요!)
# 데이터는 절대로 Git으로 관리하지 않는다.
data/
datasets/
*.csv
*.tsv
*.json
*.xml
# 이미지/영상 데이터 (폴더 단위로 관리하는 것을 추천)
# 예: raw_images/, processed_data/ 등

# 2. 모델 체크포인트 및 학습된 모델
# 용량이 매우 크므로 절대 포함하지 않는다.
models/
saved_models/
checkpoints/
weights/
*.pt
*.pth
*.h5
*.ckpt
*.pb
*.onnx

# 3. 로그 및 실험 결과
# TensorBoard, W&B, 일반 로그 파일 등
logs/
runs/
output/
results/
tb_logs/
wandb/

# 4. 캐시 파일
# 라이브러리(huggingface, etc.)가 생성하는 캐시
.cache/

# ===================================================================
# IDE & System Files
# ===================================================================
# OS 생성 파일
.DS_Store
Thumbs.db
._*

# IDE 설정 파일
.idea/      
# PyCharm, IntelliJ
.vscode/    
# Visual Studio Code (단, 팀 전체 공유 설정은 예외 처리 가능)
*.sublime-project
*.sublime-workspace

# ===================================================================
# Jupyter Notebook
# ===================================================================
.ipynb_checkpoints
profile_default/
nbextensions/

# ===================================================================
# Secrets & Configuration
# ===================================================================
# API 키, 비밀번호 등이 담긴 환경 변수 파일
.env
*.env.*
secrets.yaml
config.ini 
# 민감 정보가 있다면 포함
```