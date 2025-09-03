---
layout: post
title: "GitHub Pages 블로그 만들고 커스텀하기"
date: 2024-11-05
categories: [git, GitHub]
tags: [GitHub, GitHub Pages, Jekyll, Chirpy, blog]
pin: false
image:
  path: https://cdn.jsdelivr.net/gh/jjikin/jjikin.github.io@main/assets/img/posts/image-20230618154229292.png
comments: true     # 댓글 기능 사용 (옵션)

---

## 🔵 들어가며

그 동안 미뤄왔던 포트폴리오용 블로그를 만들기 위해 챗GPT와 씨름을 한지 1주일 정도 됐고 드디어 어느 정도 손에 익기 시작했다.

이제 커스텀도 내가 찾아보면서 할 수 있게 됐고 작업하면서 틈틈이이 포스팅도 올릴 수 있을만큼 안정을 찾았다.

역시 만들어 놓고 나니까 개발자에게 이만한 포트폴리오는 없을 것 같아서 지금까지 내가 시도했던 과정을 쭈욱 정리해서 포스팅했다.

> **GitHub Pages + Jekyll + Chirpy 테마** 조합을 사용했습니다!

---

#### ⚪ 사용한 기술 스택

- GitHub Pages
- Jekyll
- Chirpy 테마
- WSL (Ubuntu) + VSCode

---

#### ⚪ 1. Chirpy 테마로 리포지토리 생성

Chirpy 공식 스타터 저장소를 템플릿으로 사용함.

- GitHub에서 `chirpy-starter` 템플릿으로 새 저장소 생성
- 로컬로 클론:  
  ```bash
  git clone https://github.com/soohyun-chris-jeon/soohyun-chris-jeon.github.io.git
  ```

---

#### ⚪ 2. 로컬 개발 환경 설정 (Windows + WSL)

Chirpy는 Ruby 기반이라 Jekyll이 필요했다. 나는 Windows **WSL (Ubuntu)** 위에서 모든 작업을 했다.

```bash
sudo apt update
sudo apt install ruby-full build-essential zlib1g-dev
gem install bundler jekyll
```

설치 후 다음 명령어로 블로그를 ⭐로컬에서 실행해볼 수 있다. 즉, 웹에 포스팅하기전에 로컬에서 실시간으로 수정하고 결과를 확인할 수 있다!!

```bash
bundle install
bundle exec jekyll serve
```

---

#### ⚪ 3. GitHub Pages 배포 설정

- GitHub 리포지토리 > Settings > Pages에서 `gh-pages` 브랜치 선택
- `_config.yml`에서 `url`, `github.username` 등 핵심 정보를 입력.

이후 GitHub Actions를 통해 자동 배포가 가능해진다.

---

#### ⚪ 4. 블로그 커스터마이징

##### Hero Section 추가

`_layouts/home.html` 파일을 수정해서 상단 Hero 영역을 추가했음. 사실 없어도 되는 기능인데 조금 더 커스텀을 하고 싶은 욕심에 추가했는데... 꽤 괜찮다.

Chirpy는 Gem 기반 테마라서 layout과 include 파일을 직접 커스터마이징하려면 일부 파일을 로컬에 복사해야 합니다.

##### Footer 문구 변경

`_includes/footer.html`을 수정해 나만의 문구로 교체했습니다. 나름 고르고 고른 문구 하나 추가했음...

##### 사이드바 카테고리명 변경

`Categories` 항목을 `Studies`로 바꾸기 위해 `_includes/components/sidebar-panel.html`을 로컬에 복사해서 직접 수정했습니다.(이건 실패패)

---

#### ⚪ 5. 앞으로 해보고 싶은 것

- 카드형 글 목록 UI 커스터마이징
- 태그/카테고리 정렬 개선
- SEO 최적화 및 Sitemap 설정
- 소개 페이지 및 프로젝트 정리

---

## 🔵 마무리하며

블로그를 직접 구축하는 과정은 쉽지만은 않았지만, 그만큼 배우는 것은 더 많았다. 특히, git의 활용성를 여러번 몸소 느꼈고, 커스텀을 진행하는 과정에서는 조금만 시간을 투자하면 github pages 확장성을 더 키울 수 있는 가능성도 느꼈기 때문에 아마 장기적으로 굉장히 도움이 되는 시간이었던 것 같다.

> 이제 커스터마이징에 시간 투자는 줄이고 이 블로그는 잡다한 **스터디 기록**, **프로젝트 포트폴리오**, **기술 블로그** 아카이브를 열심히 수행할 예정이다. :)

블로그 주소: [https://soohyun-chris-jeon.github.io](https://soohyun-chris-jeon.github.io)
