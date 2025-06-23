---
layout: post
title: "github pages 포스팅을 위한 Markdown 문법과 꿀팁"
date: 2024-11-10 00:00:00 +0900
categories: [Markdown]
tags: [Markdown, cheatsheet, GitHub Pages, blog]
pin: false
comments: true     # 댓글 기능 사용 (옵션)

---

## ⚪ github pages는 
다양한 장점이 있지만 그럼에도 불구하고 높은 진입 장벽이 있는 것이 바로 포스팅이 다른 플래폼에 비해 번거롭다는 것이다.

하지만 막상 다뤄보면 어렵지 않으며 단순 반복이므로 마크다운 템플릿을 만들면 시간 절약이 가능할 것 같다.

일단 먼저 작성한 `.md` 파일을 `_posts/` 폴더에 넣고, 날짜와 제목을 맞춰 저장한다. 상단에는 `YAML 헤더`를 반드시 포함시켜줘야한다.

그리고 로컬에서 `bundle exec jekyll serve` 으로 에러 체크 후 `git commit` 하면 끝!

아래는 주요 마크다운 문법을 정리한 내용이다.

```yaml
---
title: "Markdown 문법 요약"
date: 2025-06-01 12:00:00 +0900
categories: [기초, Markdown]
tags: [markdown, github, blog]
pin: true
---
```

---

## 1. 제목(Header)

```markdown
# H1 제목
## H2 제목
### H3 제목
#### H4 제목
```

## 2. 글자 강조
```md
*기울임* 또는 _기울임_
**굵게** 또는 __굵게__
~~취소선~~
```
## 3. 목록
```md
- 항목 1
- 항목 2
  - 하위 항목

1. 첫 번째
2. 두 번째
   1. 하위 항목
```

## 4. 링크 & 이미지
```md
[Google](https://www.google.com)

![이미지 설명](https://via.placeholder.com/150)
```
## 5. 인용문
```md
> 인용문
```

## 6. 수평선
```md
---
```

## 7. 자주 쓰는 이모지
💯
🥳
😇
🤬
💛
💜
👋
👍
👏
🙌
🙏
✍
🌙
⭐
🔥
🎉
📅
📌
💊
❗
❌
✅
➰
🟣
🟡
🔴
🟢
🔵
✔

## 8. 자주쓰는 이미지는 업로드할때
```md
├── _posts/
│   └── 2024-11-12-markdown-cheatsheet.md
├── assets/img/
│   └── markdown-example.png
```

## 9. 표(table)
```md
|  이름 |  역할     |  비고   |
|-------|-----------|-------|
| 전수현 | 팀장      | 열공중 |
| 카리나 | 어시스턴트 | 사랑해 |
```