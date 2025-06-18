---
layout: post
title: "[서버 구축] 남는 노트북 WSL을 개인 딥러닝 서버로 세팅하기"
date: 2025-06-01
categories: [Dev Environment]
tags: [WSL, SSH, Dev Environment, Deep Learning, VSCode, JupyterLab]
---

## 🟣 Intro
본격적인 딥러닝 과제를 하기에 앞서 Colab만으로는 한계가 느껴져서 로컬에도 하나 쯤은 GPU가 있어야 할 것 같다고 판단이 들었다. 그래서 놀고 있던 노트북에 gtx 1650이라는 귀여운 그래픽카드가 있는데 이 친구라도 공부에 활용하기로 했다.

그래서 오늘은 내 노트북(WIN11 + WSL2)을 로컬 딥러닝 서버처럼 만들어서  
데스크탑 VSCode에서 SSH로 접속하고, 실험도 할 수 있게 설정해봤다.  

처음엔 그냥 Remote-WSL 쓰면 되는 줄 알았는데, 내가 원하는 건  
**노트북을 완전한 원격 서버처럼** 쓰는 거였고, 결국 SSH 서버 세팅부터  
JupyterLab 원격 접속까지 거의 하루를 갈아넣어버렸다...ㅜ

---

## ⚙️ 시스템 구성

| 항목       | 세부 내용                             |
|------------|--------------------------------------|
| 🖥️ 노트북   | Windows 11 + WSL2 (Ubuntu 24.04)       |
| 💻 데스크탑 | Windows 11 + VSCode (Remote-SSH)       |
| 🌐 네트워크 | 동일 공유기 하위 (192.168.0.x 대역)    |
| 🔌 접속방식 | SSH + 포트포워딩 (port 2222)           |

---

## 🚀 전체 과정 요약

### 1. WSL2에서 SSH 서버 설치 및 시작

```bash
sudo apt update && sudo apt install openssh-server
sudo service ssh start
```
### 2. Windows 포트포워딩 설정 (PowerShell 관리자 권한)

```powershell
netsh interface portproxy add v4tov4 listenport=2222 listenaddress=0.0.0.0 connectport=22 connectaddress=127.0.0.1
```
✅ 이걸 안 하면 외부에서 WSL에 접근할 수 없음!

### 3. VSCode에서 Remote-SSH 연결 설정
```bash
# ~/.ssh/config (데스크탑 기준)
Host my-wsl
    HostName 192.168.0.9
    Port 2222
    User soohyun
```
→ VSCode에서 Remote-SSH: Connect to Host → my-wsl 선택

### 4. SSH 무비번 접속 (공개키 기반)
```bash
ssh-keygen -t ed25519 -C "soohyun@desktop"
ssh-copy-id -p 2222 soohyun@192.168.0.9
```
ssh-copy-id 안 되면 id_ed25519.pub 내용을 복사해서 노트북의 ~/.ssh/authorized_keys에 직접 붙여넣으면 됨

🔒 권한도 중요:
```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
```
### 5. Conda 환경 구성 + 딥러닝 패키지 설치
```bash
conda create -n JSH python=3.10
conda activate JSH

pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118

```

### 6. JupyterLab 설치 및 원격 설정

```bash
pip install jupyterlab
jupyter lab --generate-config
jupyter lab password  # 브라우저용 접속 비밀번호 설정
```
설정 파일 수정 (~/.jupyter/jupyter_lab_config.py):

```python
c.ServerApp.ip = '0.0.0.0'
c.ServerApp.port = 8888
c.ServerApp.open_browser = False
c.ServerApp.allow_remote_access = True
```

### 7. 실행 및 접속
```bash
jupyter lab
```
접속 주소: 
```cpp
http://192.168.0.9:8888
```
브라우저에서 바로 접속 가능하고, VSCode 터미널에서 돌려도 됨!


### 🟣 오늘의 교훈
- 도대체 챗GPT가 없던 세상에서 리눅스 서버를 세팅하던 선배님들은 어떤 싸움을 하신겁니까... 이걸 일일이 다 공부하고 시도해보고 디버깅한다는건 불가능에 가깝지 않았을까......