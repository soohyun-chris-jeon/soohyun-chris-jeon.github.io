---
layout: post
title:  "[git] git pull --rebase vs --no-rebase 차이"
date:   2025-06-21 01:00:00 +0900
categories: [git]
tags: [git, GitHub, repository]
comments: true     # 댓글 기능 사용 (옵션)
math: true  # ✅ 요거 꼭 추가!
---


## 🔵 git의 장점에 빠지다
요즘 여러대의 PC에서 git을 활용하고 손쉽게 버전 관리를 하고 있다.

아직 혼자 작업하는 수준이라 git을 활용한다고 해봐야 Github에 저장된 내 작업물을 pull하고 작업이 끝나면 push하는 정도로 활용 중이다.

이렇게 작업하면 안전하게 내 코드가 관리가 되는 상황이면서 
내 공부 기록이 한 줄 한 줄 남는 느낌이라 묘하게 뿌듯하기까지 하다.

이런 상황에서 가장 걱정되는 것은 역시 여러대에서 작업한 코드의 version이 충돌하는 것이다.

그래서 이 경험을 포스팅하려고 한다.


#### ⚪ `git push`를 했는데 conflict가 생기면?

1) 먼저 `git status` 로 충돌이 일어난 파일 확인

2) master 브랜치의 코드를 mgerge하고 올바른 전략의 버전으로 수정하는 과정이 필요.

#### ⚪ `git pull`은 사실 두 가지 git 명령어를 합쳐놓음

- `git fetch`: 원격 레포의 최신 변경 사항을 가져오지만, 내 로컬 공간에는 바로 적용 x. 변경사항에 대한 확인만 함
- `git merge`: fetch로 가져온 최신 변경 사항을 로컬 브랜치에 합치는 단계

##### 1)`git pull` 또는 `git pull --no-rebase`
     - `git pull`은 기본적으로 merge 방식으로 작동
     - `--no-rebase`: 병합(Merge), 모든 커밋 보존, merge commit 생성됨

##### 2) `git pull --rebase`
- `--rebase`: 리베이스(Rebase), 내 커밋을 리모트 커밋 위로 재배치

#### ⚪ 비교

| 옵션 | 설명 | 커밋 구조 |
|------|------|------------|
| --no-rebase | 안전, 협업에 적합 | 분기 + 병합 (Y자형) |
| --rebase | 깔끔한 히스토리 | 직선형 (해시 변경) |

- 협업 중이라면 → `--no-rebase`
- 혼자 작업한 브랜치 정리 → `--rebase`

#### ⚪ 실전 예제
GitHub에 이미 main 브랜치에 커밋 1개 있음:

```
A  ← 서버 (origin/main)
```
내 로컬에서도 clone 후, 혼자 커밋 2개 만듦:

```
A - B - C  ← 로컬 (main)
```

그런데 누군가 GitHub에 D 커밋을 push해버림❗  
그럼 이제 서버는:

```
A - D  ← 서버 (origin/main)
```
이 상황에서 나는 git pull 해야 하는데…

✅ 1. git pull --no-rebase 했을 경우 (merge)

```
A - D
     \
      B - C
           \
            M   ← 로컬 main (merge commit)
```

✅ 2. git pull --rebase 했을 경우 (rebase)
```
A - D - B' - C'  ← 로컬 main (rebase 후)
```

내 커밋 B, C가 D 뒤에 재정렬됨 (B', C'는 해시가 바뀐 새로운 커밋)

히스토리는 직선형으로 깔끔

단, 원래 B, C는 사라지고 새로운 커밋이 생긴 것처럼 됨


## 🔵 정리하면

#### merge 방식
→ 두 히스토리를 그대로 합쳐서 merge commit 하나 추가

#### rebase 방식
→ 내 작업을 상대 작업 이후에 한 것처럼 재배열

| 상황               | 추천 옵션         |
| ---------------- | ------------- |
| 협업 중, 안정성 중요     | `--no-rebase` |
| 개인 프로젝트, 커밋 깔끔하게 | `--rebase`    |
