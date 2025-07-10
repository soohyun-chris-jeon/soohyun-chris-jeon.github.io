---
layout: post
title:  "[git ] 'git pull' --rebase vs --no-rebase 차이"
date:   2025-06-21 01:00:00 +0900
categories: [git]
tags: [git, GitHub, repository]
comments: true     # 댓글 기능 사용 (옵션)
math: true  # ✅ 요거 꼭 추가!
---


## 🧠 개념
- `--no-rebase`: 병합(Merge), 모든 커밋 보존, merge commit 생성됨
- `--rebase`: 리베이스(Rebase), 내 커밋을 리모트 커밋 위로 재배치

## 📊 비교

| 옵션 | 설명 | 커밋 구조 |
|------|------|------------|
| --no-rebase | 안전, 협업에 적합 | 분기 + 병합 (Y자형) |
| --rebase | 깔끔한 히스토리 | 직선형 (해시 변경) |

## 📌 추천
- 협업 중이라면 → `--no-rebase`
- 혼자 작업한 브랜치 정리 → `--rebase`


GitHub에 이미 main 브랜치에 커밋 1개 있음:

```css
A  ← 서버 (origin/main)
```
수현이 로컬에서도 clone 후, 혼자 커밋 2개 만듦:

```css
A - B - C  ← 로컬 (main)
```
그런데 누군가 GitHub에 D 커밋을 push해버렸어!
이제 서버는:

```css
A - D  ← origin/main
```
이 상황에서 수현이가 git pull 해야 하는데…

🔁 1. git pull --no-rebase 했을 경우 (merge)
```css
A - D
     \
      B - C
           \
            M   ← 로컬 main (merge commit)
```

🔄 2. git pull --rebase 했을 경우 (rebase)
```mathematica
A - D - B' - C'  ← 로컬 main (rebase 후)
```

수현이 커밋 B, C가 D 뒤에 재정렬됨 (B', C'는 해시가 바뀐 새로운 커밋)

히스토리는 직선형으로 깔끔

단, 원래 B, C는 사라지고 새로운 커밋이 생긴 것처럼 됨



🍝 merge 방식
“너 밥 먹었어?”
“아니 나는 면 요리 했어. 그럼 면 + 밥 같이 먹자!”

→ 두 히스토리를 그대로 합쳐서 merge commit 하나 추가

🧽 rebase 방식
“아 그래? 그럼 내가 했던 요리는 네 밥 먹고 나서 한 것처럼 정리할게~”

→ 내 작업을 상대 작업 이후에 한 것처럼 재배열

| 상황               | 추천 옵션         |
| ---------------- | ------------- |
| 협업 중, 안정성 중요     | `--no-rebase` |
| 개인 프로젝트, 커밋 깔끔하게 | `--rebase`    |
