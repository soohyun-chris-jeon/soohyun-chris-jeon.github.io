---
layout: post
title: "[Microsoft PowerToys] 멀티 디바이스 페어링"
date: 2025-06-11 00:00:00 +0900
categories: [Dev Environment]
tags: [Windows, PowerToys, WSL, logitech, Multi-Device, Productivity, VScode]
pin: false
comments: true     # 댓글 기능 사용 (옵션)

---

# ⚪ 최근에
집에서 수업을 듣게 되면서 앉아 있는 시간이 길어졌다. 그래서 작업을 할때 조금이라도 편의성을 높이는 방법을 고민하게 되었다. 

최근 작업 환경을 잠시 브리핑해보면 
- 🔧 데스크탑: 직접 조립  
⭐인텔 i9 11세대, 128GB, ⭐RTX 3080 ti 
windows 11 + WSL 기반 VScode

- 🔧 랩탑: 삼성노트북  
인텔 i7 8세대, 24GB, GTX1650 
windows 11 + WSL 기반 VScode (서브용)

그래서 거의 대부분의 작업을 데스크탑으로 하고 있었는데... 효율을 계속 따지다 보니 아예 랩탑을 책상에 설치하고 컴퓨터 2대를 돌리기 시작했다.

최근에 스프린트에서 🔧맥북 에어도 지원을 해준다고 해서 3대로 세팅할 예정이다!

그러다 보니 **장치 간 페어링**이 절실히 필요할 때가 많았는데 그 때 필요한게 마소가 만들어준 공식앱 ⭐`PowerToys` 였다.

나같은 효율충에게 너무너무 고마운 앱이라서 챗GPT의 도움을 받아 세팅을 완료하였고 정리까지 깔끔하게 해서 블로깅하고 싶었다.

아래는 오늘 내가 작업한 일을 GPT가 정리해준 내용!

--- 

# 🔵 Multi-Device AI & Productivity Workflow 

## 💻 전체 구성 개요

| 기기 | OS | 주요 목적 | 환경 구축 |
|------|----|-----------|------------|
| 데스크탑 | Windows 11 | AI 모델 훈련, 대용량 연산, 실험용 WSL | ✅ WSL2 + VSCode + Python/Conda + CUDA 설정 완료 |
| 노트북 | Windows 11 | 경량 코딩, 논문 정리, 외부 작업 | ✅ 데스크탑과 동일한 WSL2 기반 환경 구성 완료 |
| 맥북 에어 | macOS (예정) | 마크다운 문서 작성, 깃헙 블로그 관리, 깔끔한 생산성 환경 | ⏳ 세팅 예정 → GitHub Pages, Typora, Obsidian, VSCode 설치 예정 |

---

## ⚪ 장치 간 연결 및 워크플로우

### ✅ PowerToys `Mouse Without Borders`

- 두 윈도우 장치 간 **마우스 & 키보드 공유** 설정 완료
- 네트워크 상 **IP 주소 기반 연결** 성공 (데스크탑 Wi-Fi 없음에도 작동)
- 키보드 자동 전환 확인됨 (따로 Enable 옵션 없음 — 최신 버전 자동 설정)

### 📎 파일/문서 동기화

- [ ] Dropbox or OneDrive 사용 고려 중
- [ ] 추후 맥북 포함 시, iCloud와 Git 연동 가능성 검토 예정

### 📝 깃헙 Pages 기반 블로그 관리

- 블로그 주소: [soohyun-chris-jeon.github.io](https://soohyun-chris-jeon.github.io/)
- Chirpy 테마 v7.3.0 기반
- WSL 환경에서 로컬 빌드, 커스터마이징 진행 중
- Hero Section, Footer 직접 커스터마이징 완료

---

## ⚪ 추천 툴 및 세팅 가이드 (맥북용)

### 🔧 기본 개발 도구

- [ ] Homebrew (패키지 관리)
- [ ] iTerm2 + Oh My Zsh
- [ ] VSCode (with Remote-SSH, GitHub Copilot 등)
- [ ] Git + GitHub CLI

### 📝 문서 작업 & 블로그 관리

- [ ] Typora (Markdown WYSIWYG 편집기)
- [ ] Obsidian (로컬 + Git 기반 지식 관리)
- [ ] MarkText (오픈소스 Markdown 편집기)
- [ ] GitHub Desktop (시각적 Git 관리)

---

## ⚪ 장치별 사용 루틴 예시

| 시간대/장소 | 사용 기기 | 주요 작업 |
|-------------|-----------|-----------|
| 집 (오전/심층 작업) | 데스크탑 | 모델 훈련, 딥러닝 실험, 논문 코드 실행 |
| 도서관/카페 | 노트북 | 코딩 연습, 논문 정리, Git push |
| 침대/야간 정리 | 맥북 | Markdown 정리, 블로그 포스트 작성, 커밋 |

---

## ⚪ 향후 계획

- [ ] 맥북 세팅 시 GitHub Pages 자동 배포 루틴 설정
- [ ] VSCode Sync Settings 활성화 (모든 장치에 동일한 확장/테마 유지)
- [ ] GitHub Actions 통한 블로그 CI/CD 구축

---

# ⚪ 도움 요청 및 개선 포인트

- Chirpy 테마 커스터마이징 (포스트 카드 스타일 등) 지속 중
- 블로그 콘텐츠 전략 및 깃헙 포트폴리오 구조화 관련 코멘트 환영

