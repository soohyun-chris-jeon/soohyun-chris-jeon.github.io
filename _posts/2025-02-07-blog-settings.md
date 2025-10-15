---
layout: post
title:  "Jekyll 블로그, 댓글부터 검색엔진 최적화(SEO)까지 설정해보기"
date:   2025-02-07 10:00:00 +0900
categories: [git, GitHub]
tags: [git, GitHub, GitHub Pages, Chirpy, Jekyll, Markdown, giscus, goatcounter, SEO, sitemap, RSS, google-search-console, naver-search-advisor]
pin: false
image:
  path: https://velog.velcdn.com/images/dksduddnr33/post/e30361ef-48d9-43bf-9a6c-e30f3be3a8e8/image.jpg

---

Jekyll에 익숙해지기도 전에 이것저것 살펴보면 해야 할 일이 너무 많았다.. 

글만 채워 넣는다고 하면 그냥 내 일기장으로 끝나는 것이라서 좀 더 소통하고, 내 블로그의 성과를 측정하며, 더 많은 사람에게 내 글을 알리기 위한 몇 가지 필수적인 설정이 필요했다. 

이 포스트에서는 Chirpy 테마를 기준으로, 블로그 운영의 기반을 다지는 세 가지 핵심 설정(댓글, 조회수, 검색 엔진 등록) 과정을 기록하고자 한다.

---

## 🔵 1. 댓글 기능 추가하기 (Giscus)

방문자들이 글에 대한 피드백이나 질문을 남길 수 있는 댓글 기능은 블로그에서 가장 필요한 기능이라고 생각을 한다. 여러 서비스 중 **Giscus**를 선택했으며, 그 이유는 다음과 같다.

-   **활발한 유지보수**: `utterances`의 후속 버전으로, 활발하게 개발 및 관리가 이루어지고 있다.
-   **적합성**: GitHub Issues가 아닌 **GitHub Discussions**를 기반으로 하여, 댓글 시스템의 본래 목적에 더 잘 부합한다.
-   **깔끔함**: 광고나 외부 트래킹 없이 GitHub 생태계 안에서 모든 것이 해결된다.

다만 깃허브를 로그인해야 댓글을 쓸 수 있다는 단점은 있지만... 그만큼 개발자 위주로 소통을 하면 좋을것 같아서 `Giscus`로 선택!


#### ⚪ 설정 과정

설정은 [Giscus 공식 홈페이지](https://giscus.app/ko)의 안내에 따라 간단하게 진행할 수 있다.

1.  댓글을 연동할 Public Repository에 **Discussions** 기능을 활성화한다.
2.  Giscus App을 설치하고 Repository를 연결한다.
3.  Giscus 홈페이지에서 생성된 설정값들을 `_config.yml` 파일의 `giscus:` 섹션에 옮겨 적고, `provider`를 `giscus`로 설정하면 완료된다.

```yaml
# _config.yml
comments:
  provider: "giscus"
  giscus:
    repo: "your-github-id/your-repo-name"
    repo_id: "..."
    category: "General"
    category_id: "..."
```


## 🔵 2. 조회수 기능 추가하기 (GoatCounter)

댓글도 추가했고 이제 블로그 방문자 통계를 추가할 차례다. 알아보니까 Google Analytics(GA)라는 엄청나게 강력한 도구가 있지만, 나같은 소상공인에게는 어울리지 않아보였고... 나같은 라이트 유저가 사용하기에 적합한 `GoatCounter`를 선택했다. 

특징은 **개인정보 보호**와 **단순함**이라고 하는데 정리해보면,

  - **프라이버시 존중**: 쿠키나 개인 식별 정보를 수집하지 않아 방문자의 프라이버시를 존중한다.
  - **가벼움**: 스크립트가 매우 가벼워 블로그 속도에 거의 영향을 주지 않는다.
  - **핵심 기능**: 복잡한 GA와 달리, 방문자 수, 인기 페이지, 유입 경로 등 블로그 운영에 필요한 핵심 데이터만 직관적으로 보여준다.

#### ⚪ 설정 과정

Chirpy 테마는 GoatCounter를 공식적으로 지원하므로 설정이 매우 간편하다.

1.  [GoatCounter 홈페이지](https://www.goatcounter.com/)에 가입하여 내 사이트의 고유 코드(ID)를 발급받는다.
2.  `_config.yml` 파일의 `analytics` 섹션에 `provider`를 `goatcounter`로 설정하고, 발급받은 ID를 추가한다.

<!-- end list -->

```yaml
# _config.yml
analytics:
  provider: goatcounter
  goatcounter:
    id: "your-goatcounter-id"
```

이것만으로도 실제 배포된 블로그의 조회수가 집계되기 시작한다.

-----

## 🔵 3. 검색 엔진 최적화 (SEO) 기초

구글과 네이버에 내 블로그의 존재를 알리고 콘텐츠를 효과적으로 수집해가도록 SEO 설정을 하도록 하자. 

#### ⚪ 3.1. 사이트 소유권 확인

"이 블로그는 내 소유입니다"라고 검색 엔진에 공식적으로 증명하는 절차다. 이 과정을 거쳐야 각 검색 엔진이 제공하는 웹마스터 도구(Google Search Console, Naver Search Advisor)를 사용할 수 있다.

  - **방법**: 각 웹마스터 도구에서 제공하는 **HTML 태그** 방식 또는 **HTML 파일 업로드** 방식을 사용한다.
  - **HTML 태그**: 발급받은 메타 태그를 `_includes/head.html` 파일에 직접 추가한다. (테마 override 필요)
  - **HTML 파일 업로드**: 다운로드한 인증 파일을 프로젝트 최상위 폴더에 넣고 `git push` 하는 가장 간편한 방법이다.

#### ⚪ 3.2. Sitemap 및 RSS 제출

검색 로봇이 내 블로그의 구조와 콘텐츠를 더 잘 이해하도록 돕는 작업이다.

  - **Sitemap (`sitemap.xml`)**: 내 블로그의 전체 페이지 목록이 담긴 **지도**다. 이 지도를 제출하면 검색 로봇이 모든 페이지를 빠짐없이 수집해갈 수 있다.
  - **RSS (`feed.xml`)**: 새 글이 발행될 때마다 검색 엔진에 **알림**을 보내는 구독 서비스다. 이를 제출하면 새 글이 더 빠르게 검색 결과에 노출된다.

각 웹마스터 도구의 '사이트맵 제출', 'RSS 제출' 메뉴에 아래의 URL을 등록하면 된다.

  - **Sitemap URL**: `https://soohyun-chris-jeon.github.io/sitemap.xml`
  - **RSS URL**: `https://soohyun-chris-jeon.github.io/feed.xml`

만약 RSS 등록 시 "올바른 RSS가 아니다"라는 오류가 발생한다면, [W3C Feed Validator](https://validator.w3.org/feed/)에서 원인을 확인할 수 있다. 대부분 글 제목이나 내용에 포함된 특수문자(`&` 등)가 원인이므로, `&amp;` 같은 HTML 엔티티 코드로 수정하면 해결된다.

## 🔵 마무리

여기까지 진행했다면, 블로그 운영을 위한 기술적인 기반은 모두 다졌다고 볼 수 있다. 

굳이 왜 이 고생을 하면서 Jekyll 블로그를 사용하냐고 물을 수도 있겠지만 장기적으로 나의 커리어에 이만한 포트폴리오는 없을거라고 생각하기 때문에 선후배나 친구들에게도 적극 추천하라고 떠미는 중이다.

