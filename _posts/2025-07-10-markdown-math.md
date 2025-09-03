---
layout: post
title: "Markdown으로 LaTeX 수식 활용하기"
date: 2025-07-10 10:00:00 +0900
categories: [Markdown]
tags: [Markdown, LaTeX, GitHub Pages, blog]
pin: false
comments: true     # 댓글 기능 사용 (옵션)
image:
  path: https://lsin07.github.io/assets/img/2023-11-15-writing-latex-on-vscode/title.png
math: true  # ✅ 요거 꼭 추가!


---
## 🔵 마크다운에 익숙해지면서
처음에 어색했던 markdown 문법이 깃헙 페이지, 주피터 노트북, 심지어 논문 작성용 $LaTeX$⭐에서도 쓰일 수 있다는 것을 알고 나서 조금 더 친해지기로 결심!

개인적으로 수식을 떼놓고 블로그 포스팅을 하려고 했는데 이 참에 쭈욱 정리해보고 적극적으로 수식을 활용해보고자 포스팅을 한다.

---

#### ⚪ $LaTeX$랑 마크다운 관계?
마크다운에서 수식을 사용한다는 것은, $LaTeX$ (레이텍)의 문법을 빌려와 렌더링하는 개념. 즉, 복잡한 수학 공식을 텍스트로 표현하기 위한 표준이라고 생각하면 됨.

---

#### ⚪ $LaTeX$ 수식 모드: 인라인(Inline) vs. 블록(Block)

- **인라인(Inline) 모드**: 문장 안에 자연스럽게 수식을 녹여낼 때 사용해.
    * ✔문법: $ 기호 하나로 수식을 감싼다.
    * 예시: 피타고라스 정리는 $a^2 + b^2 = c^2$ 입니다.

- **블록(Block) 모드**: 수식을 독립된 단락으로, 강조해서 보여주고 싶을 때 사용하며  **가운데 정렬**이 됨.
    * ✔문법: $$ 기호 두 개로 수식을 감싼다.
    * 예시: 
    $$\hat{\theta}_{MLE} = \arg\max_{\theta} L(\theta | \text{data})$$

---


#### ⚪ 필수 기초 문법 정리

| 카테고리 | 설명 | 문법 (입력) | 결과 (출력) |
| :--- | :--- | :--- | :--- |
| **분수** | 분모/분자를 표현 | `\frac{분자}{분모}` | $\frac{1}{2}$ |
| **위/아래 첨자** | 지수나 인덱스를 표현 | `x^2`, `x_i`, `x_{ij}^{k}` | $x^2, x_i, x_{ij}^{k}$ |
| **제곱근** | 루트 기호 | `\sqrt{x}`, `\sqrt[n]{x}` | $\sqrt{x}, \sqrt[n]{x}$ |
| **괄호** | 다양한 크기의 괄호 | `( )`, `[ ]`, `\{ \}`<br>`\left( \frac{a}{b} \right)` | $( ), [ ], \{ \}<br>\left( \frac{a}{b} \right)$ |
| **공백** | 수식 내에서 띄어쓰기 | `a \ b` (작게)<br>`a \quad b` (넓게) | $a \ b$<br>$a \quad b$ |

---

#### ⚪ 연산자 및 기호

수학 논문에서 절대 빠질 수 없는 기호들입니다.

| 카테고리 | 설명 | 문법 (입력) | 결과 (출력) |
| :--- | :--- | :--- | :--- |
| **합(Summation)** | 시그마 기호 | `\sum_{i=1}^{N} x_i` | $\sum_{i=1}^{N} x_i$ |
| **곱(Product)** | 파이 기호 | `\prod_{i=1}^{N} x_i` | $\prod_{i=1}^{N} x_i$ |
| **적분(Integral)** | 인테그랄 기호 | `\int_{a}^{b} f(x) dx` | $\int_{a}^{b} f(x) dx$ |
| **극한(Limit)** | 리미트 기호 | `\lim_{n \to \infty} f(n)` | $\lim_{n \to \infty} f(n)$ |
| **미분(Derivative)**| 미분 표현 | `\frac{dy}{dx}`, `\partial` | $\frac{dy}{dx}, \partial$ |
| **벡터(Vector)** | 벡터 표현 | `\vec{v}` | $\vec{v}$ |
| **비교/관계 연산** | 크거나 같음, 약 등 | `\le`, `\ge`, `\ne`, `\approx` | $\le, \ge, \ne, \approx$ |
| **집합(Set)** | 포함, 교집합, 합집합 | `\in`, `\subset`, `\cap`, `\cup` | $\in, \subset, \cap, \cup$ |

---

#### ⚪ 그리스 문자

변수나 상수를 나타낼 때 정말 많이 사용됩니다. 소문자/대문자 구분에 주의하세요.

| 소문자 | 소문자 문법 | 대문자 | 대문자 문법 |
| :--- | :--- | :--- | :--- |
| $\alpha$ | `$\alpha$` | $A$ | `A` |
| $\beta$ | `$\beta$` | $B$ | `B` |
| $\gamma$ | `$\gamma$` | $\Gamma$ | `$\Gamma$` |
| $\delta$ | `$\delta$` | $\Delta$ | `$\Delta$` |
| $\epsilon$ | `$\epsilon$` | $E$ | `E` |
| $\zeta$ | `$\zeta$` | $Z$ | `Z` |
| $\eta$ | `$\eta$` | $H$ | `H` |
| $\theta$ | `$\theta$` | $\Theta$ | `$\Theta$` |
| $\lambda$ | `$\lambda$` | $\Lambda$ | `$\Lambda$` |
| $\mu$ | `$\mu$` | $M$ | `M` |
| $\pi$ | `$\pi$` | $\Pi$ | `$\Pi$` |
| $\rho$ | `$\rho$` | $P$ | `P` |
| $\sigma$ | `$\sigma$` | $\Sigma$ | `$\Sigma$` |
| $\phi$ | `$\phi$` | $\Phi$ | `$\Phi$` |
| $\omega$ | `$\omega$` | $\Omega$ | `$\Omega$` |



#### ⚪ 억양(Accent) 및 머리 위 기호

문자 위에 씌워서 특별한 의미를 나타낼 때 사용합니다.

| 이름 | 설명 | 문법 (입력) | 결과 (출력) |
| :--- | :--- | :--- | :--- |
| **Tilde (틸데)** | 변수 위에 물결 표시 | `\tilde{a}` | $$\tilde{a}$$ |
| **Hat (햇)** | 추정값 등을 나타내는 모자 | `\hat{y}` | $$\hat{y}$$ |
| **Bar (바)** | 평균값 등을 나타내는 막대 | `\bar{x}` | $$\bar{x}$$ |
| **Dot (돗)** | 시간 미분 등을 나타내는 점 | `\dot{x}` | $$\dot{x}$$ |
| **Double Dot**| 2차 시간 미분 | `\ddot{x}` | $$\ddot{x}$$ |
| **Vector (벡터)**| 벡터를 나타내는 화살표 | `\vec{v}` | $$\vec{v}$$ |

---

#### ⚪ 점(Dots) 및 생략 기호

행렬이나 수열 등에서 생략을 나타낼 때 사용합니다.

| 이름 | 설명 | 문법 (입력) | 결과 (출력) |
| :--- | :--- | :--- | :--- |
| **Ellipsis (가로)** | `...` (베이스라인) | `\dots` | $$\dots$$ |
| **cdots (가로)** | `···` (중앙) | `\cdots` | $$\cdots$$ |
| **vdots (세로)** | `⋮` | `\vdots` | $$\vdots$$ |
| **ddots (대각선)**| `⋱` | `\ddots` | $$\ddots$$ |

---

#### ⚪ 화살표(Arrows)

관계나 방향, 변환 등을 나타낼 때 사용합니다.

| 이름 | 설명 | 문법 (입력) | 결과 (출력) |
| :--- | :--- | :--- | :--- |
| **Right Arrow**| 오른쪽 화살표 | `\to` or `\rightarrow` | $$\to \text{ or } \rightarrow$$ |
| **Left Arrow** | 왼쪽 화살표 | `\leftarrow` | $$\leftarrow$$ |
| **Double Arrow** | 양방향 화살표 | `\leftrightarrow` | $$\leftrightarrow$$ |
| **Implies** | 오른쪽 이중 화살표 | `\Rightarrow` | $$\Rightarrow$$ |
| **If and only if**| 양방향 이중 화살표 | `\Leftrightarrow` | $$\Leftrightarrow$$ |
| **Maps to** | 맵핑(함수) 관계 | `\mapsto` | $$\mapsto$$ |

---

#### ⚪ 기타 주요 기호

논리, 연산, 물리 등 다양한 분야에서 널리 쓰이는 기호들입니다.

| 이름 | 설명 | 문법 (입력) | 결과 (출력) |
| :--- | :--- | :--- | :--- |
| **Tilde (관계)** | '~와 비슷하다' (근사) | `\sim` | $$\sim$$ |
| **Infinity** | 무한대 | `\infty` | $$\infty$$ |
| **Nabla** | 그라디언트(Gradient) | `\nabla` | $$\nabla$$ |
| **H-bar** | 디랙 상수 (양자역학) | `\hbar` | $$\hbar$$ |
| **Proportional to**| 비례 | `\propto` | $$\propto$$ |
| **Plus-minus**| 플러스-마이너스 | `\pm` | $$\pm$$ |
| **Therefore** | 그러므로 | `\therefore` | $$\therefore$$ |
| **Because** | 왜냐하면 | `\because` | $$\because$$ |
| **For all** | 모든 원소에 대하여 | `\forall` | $$\forall$$ |
| **There exists**| 원소가 존재한다 | `\exists` | $$\exists$$ |
| **Degree** | 각도 표시 | `^\circ` | $$^\circ$$ |

#### ⚪ 자주 쓰는 수식 문법 예시 


| 설명 | 마크다운 입력 | 결과 |
| :--- | :--- | :--- |
| **분수** | `$\frac{a}{b}$` | $\frac{a}{b}$ |
| **아래/위 첨자** | `$x_i^2$` | $x_i^2$ |
| **시그마 (합)** | `$\sum_{i=1}^{n} a_i$` | $\sum_{i=1}^{n} a_i$ |
| **파이 (곱)** | `$\prod_{i=1}^{n} a_i$` | $\prod_{i=1}^{n} a_i$ |
| **로그** | `$\log_2(x)$` | $\log_2(x)$ |
| **그리스 문자** | `$\alpha, \beta, \gamma, \theta$` | $\alpha, \beta, \gamma, \theta$ |
| **행렬** | `$\begin{pmatrix} a & b \\ c & d \end{pmatrix}$` | $\begin{pmatrix} a & b \\ c & d \end{pmatrix}$ |


---

## 🔵 마치며

이제 위에서 정리된 문법을 참고로 내가 직접 수식을 써가면서 적응을 해보기로...!😇