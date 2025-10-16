---
layout: post
title:  "9-(4) Diffusion 모델이 이미지 생성에서 어떻게 활용되며, 어떤 장점이 있나요?"
date:   2025-07-11 14:00:00 +0900
categories: [Deep Learning, Diffusion Model]
tags: [Generative Model, PyTorch, CNN, convolutional-neural-network, Diffusion Model, Deep Learning, AI, Computer Vision]
comments: true     # 댓글 기능 사용 (옵션)
math: true  # ✅ 요거 꼭 추가!
image:
    path: https://i.ytimg.com/vi/EhndHhIvWWw/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLDmiXXTvLBTOVzJpi-JBigzxP54YA
---

---

## 🟣 Intro

**DDPM(Denoising Diffusion Probabilistic Models)**은 현재 이미지 생성 분야에서 가장 뛰어난 성능을 보여주는 모델 중 하나이다. VAE처럼 확률적 잠재 변수를 사용하고 GAN처럼 점진적으로 이미지를 생성하는 아이디어를 차용했지만, 훨씬 더 직관적이고 안정적인 프레임워크를 제시하기 때문에 현재 LLM 기반 산업에서도 널리 쓰이는 모델이 되었다. 또한, Markov chain + Variational inference 기반의 수학적인 이론도 탄탄하게 받쳐주는 모델이라고 할 수 있다

![DDPM](https://velog.velcdn.com/images/tony3ynot/post/0c526766-cd14-4292-a6e8-65e1ef7974a9/image.png)
DDPM의 핵심 아이디어는
1.  **파괴 (Forward Process)**: 깨끗한 원본 이미지에 점진적으로 노이즈를 추가하여, 결국 완전한 노이즈로 만듬.
2.  **복원 (Reverse Process)**: 완전한 노이즈에서 시작하여, 노이즈를 조금씩 제거하는 과정을 학습시켜 원본 이미지를 복원함.

이 '파괴하고 복원하는' 단순한 과정이 기존 generative model보다 고품질의 이미지를 생성하는 원리이다.  

---

#### ⚪ 1. 순방향 프로세스 (Forward Process)

순방향 프로세스는 이미지를 점진적으로 파괴하는, 즉 노이즈를 추가하는 과정이다. 이 과정은 **학습이 필요 없는(non-learnable) 고정된 프로세스**.

![forward](https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdna%2F6u9vq%2FbtsBb5LssWn%2FAAAAAAAAAAAAAAAAAAAAAPAfsNyyD9URVuhrm4ZUFN6lSg9WAwNlnVsgoukgCvjw%2Fimg.png%3Fcredential%3DyqXZFxpELC7KVnFOS48ylbz2pIh7yKj8%26expires%3D1753973999%26allow_ip%3D%26allow_referer%3D%26signature%3DUbEnZ8lZuAvSgrMrQfBpG%252F7QGRo%253D)

-   **과정**: 원본 이미지 $x_0$에서 시작하여, 총 $T$ 타임스텝에 걸쳐 매 스텝($t$)마다 약간의 가우시안 노이즈를 추가함.
-   **수식**: $t$ 시점의 이미지 $x_t$는 $t-1$ 시점의 이미지 $x_{t-1}$로부터 다음과 같이 정의됨.
    $$ q(x_t | x_{t-1}) = \mathcal{N}(x_t; \sqrt{1 - \beta_t} x_{t-1}, \beta_t \mathbf{I}) $$
    여기서 $\beta_t$는 각 스텝에서 추가할 노이즈의 양을 조절하는 작은 상수(스케줄)임.

$T$가 충분히 크면, $x_T$는 거의 순수한 가우시안 노이즈가 된다.

##### Forward Process의 핵심 트릭

매번 반복해서 $x_t$를 계산할 필요 없이, 원본 $x_0$에서 $x_t$로 한 번에 점프할 수 있는 공식이 존재함. $\alpha_t = 1 - \beta_t$ 이고 $\bar{\alpha}_t = \prod_{i=1}^t \alpha_i$ 라 할 때,

$$ x_t = \sqrt{\bar{\alpha}_t} x_0 + \sqrt{1 - \bar{\alpha}_t} \epsilon, \quad \text{where } \epsilon \sim \mathcal{N}(0, \mathbf{I}) $$

이 공식 덕분에 학습 시 **어떤 시점 $t$의 노이즈 낀 이미지를 단 한 번의 계산으로 얻을 수 있어** 매우 효율적인 훈련이 가능함.

---

#### ⚪ 2. 역방향 프로세스 (Reverse Process)

**목표**: 노이즈가 낀 이미지 $x_t$가 주어졌을 때, 그 이전 단계의 약간 덜 시끄러운 이미지 $x_{t-1}$을 추론하는 것이다. 즉, $p_\theta(x_{t-1} \| x_t)$를 모델링함.


![reverse](https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdna%2FdcuP4H%2FbtsBgaFT5Lx%2FAAAAAAAAAAAAAAAAAAAAALg16F7VLP_fZq7smYBe5qUomjSV8KjgtSfPa5TUV_OC%2Fimg.png%3Fcredential%3DyqXZFxpELC7KVnFOS48ylbz2pIh7yKj8%26expires%3D1753973999%26allow_ip%3D%26allow_referer%3D%26signature%3DZQoYmP9Tj6pdJretuTm9L1yqlPg%253D)

역방향 프로세스는 순방향의 파괴 과정을 정확히 거꾸로 되돌리는, **학습이 필요한(learnable) 복원 과정**이다.

#####  네트워크는 무엇을 학습하는가?

$x_{t-1}$의 분포를 직접 예측하는 것은 복잡하다. 대신 DDPM은 훨씬 더 간단하고 안정적인 목표를 설정함.

> **핵심 아이디어**: 모델이 $x_t$를 보고, 이 이미지를 만드는 데 사용된 **원본 노이즈($\epsilon$)를 예측**하도록 학습

즉, 우리 모델 $\epsilon_\theta(x_t, t)$는 입력으로 노이즈 낀 이미지 $x_t$와 현재 타임스텝 $t$를 받아서, $x_t$를 만드는 데 사용된 노이즈 $\epsilon$을 예측함. (보통 U-Net 구조의 모델이 사용됨.)

---

#### ⚪ 3. Loss 함수

모델이 노이즈를 잘 예측하도록 만드는 것이 목표이므로, Loss 함수는 매우 직관적이다. 바로 실제 사용된 노이즈($\epsilon$)와 모델이 예측한 노이즈($\epsilon_\theta$) 사이의 **평균 제곱 오차(Mean Squared Error)**임.

$$ L_{\text{simple}}(\theta) = \mathbb{E}_{t, x_0, \epsilon} \left[ ||\epsilon - \epsilon_\theta(x_t, t)||^2 \right] $$

학습 과정은 다음과 같이 요약됨.
1.  데이터셋에서 원본 이미지 $x_0$를 샘플링.
2.  랜덤 타임스텝 $t \in [1, T]$를 샘플링.
3.  랜덤 노이즈 $\epsilon \sim \mathcal{N}(0, \mathbf{I})$를 샘플링.
4.  $x_t = \sqrt{\bar{\alpha}_t} x_0 + \sqrt{1 - \bar{\alpha}_t} \epsilon$ 공식을 이용해 노이즈 낀 이미지를 만듬.
5.  모델이 $\epsilon_\theta(x_t, t)$를 예측하게 하고, 실제 노이즈 $\epsilon$과의 MSE Loss를 계산하여 모델을 업데이트함.

---

#### ⚪ 4. 이미지 생성

학습된 모델로 새로운 이미지를 생성하는 과정은 **역방향 프로세스**를 그대로 따라감.

1.  **시작**: 완전한 가우시안 노이즈 $x_T \sim \mathcal{N}(0, \mathbf{I})$에서 시작.
2.  **반복**: 타임스텝을 $T, T-1, \dots, 1$ 순서로 거꾸로 진행함.
    -   각 스텝 $t$에서, 현재 이미지 $x_t$를 모델 $\epsilon_\theta(x_t, t)$에 넣어 노이즈를 예측.
    -   예측된 노이즈를 이용해, 수학적 공식을 통해 $x_{t-1}$을 계산함. (약간의 노이즈를 제거하는 과정)
3.  **완성**: $T$번의 스텝을 모두 거치고 나면, 최종 결과물 $x_0$는 완벽하게 새로운 이미지가 됨.

---

#### ⚪ GPT 이후 가장 큰 파장
- Stable Diffusion, DALL·E 2, Imagen 등 초거대 모델들의 기본 구조가 DDPM 기반임.
- GPT가 NLP에서 거대한 변화였듯, DDPM은 비전 기반 생성 AI의 게임 체인저가 되고 있음.
- 최근에는 DDIM, PNDM, Latent Diffusion, Consistency Model 등으로 샘플링 속도 개선까지 되어 활발하게 산업에 투입되고 있음.





---

#### ⚪ DDPM과 MRI

DDPM의 강력한 성능은 의료 영상 분야에서 활발하게 연구되고 있음

-   **초고품질 데이터 Augmentation**: GAN보다 더 현실적이고 다양한 MRI 데이터를 생성하여, 딥러닝 모델의 학습 성능과 일반화 능력을 극대화함.
-   **MRI Reconstruction**: DDPM은 MRI 재구성 문제의 SOTA(State-of-the-art)를 달성. 적게 샘플링된 k-space 데이터가 주어졌을 때, 이를 조건(condition)으로 주어 빠진 부분을 '복원'해내는 방식.
-   **Artifact reduction 및 Super-resolution**: 복잡한 아티팩트를 일종의 '구조적인 노이즈'로 보고, 이를 제거하여 깨끗한 이미지를 복원하는 데 탁월한 성능을 보임. 저해상도 이미지를 고해상도로 복원하는 문제에도 동일한 원리가 적용됨.

---

## 🟣 Reference
- **원본 논문**: Ho, J., Jain, A., & Abbeel, P. (2020). Denoising diffusion probabilistic models. *Advances in Neural Information Processing Systems*, 33, 6840-6851.

---

### 🟢 예시 답안 (코드잇 제공)
>  - Diffusion 모델은 이미지 생성에서 확률적 과정(노이즈 추가 및 제거)을 활용하여 고품질의 이미지를 생성하는 기법입니다. 이 모델은 초기에는 랜덤한 노이즈를 포함한 이미지에서 점진적으로 원래의 데이터 분포를 복원하는 방식으로 동작합니다.
- Diffusion 모델의 기본 아이디어는 데이터에 점진적으로 노이즈를 추가하는 전방향 과정(Forward Process)과, 이 노이즈를 단계적으로 제거하여 원본 데이터를 복원하는 역방향 과정(Reverse Process)으로 구성됩니다. 훈련 과정에서 모델은 노이즈가 추가된 데이터를 보고, 이를 원래 데이터로 복원하는 방법을 학습합니다. 따라서, 학습이 완료되면 순수한 노이즈에서 점진적으로 의미 있는 패턴을 복원하며 새로운 이미지를 생성할 수 있습니다. 
- Diffusion 모델은 이미지 생성 분야에서 다음과 같은 장점을 가집니다.
    - 첫째, 고품질 이미지 생성이 가능합니다. 기존 생성 모델(GAN, VAE)과 비교했을 때, Diffusion 모델은 더욱 세밀하고 자연스러운 이미지를 생성할 수 있으며, 특정 구조적 결함(예: GAN의 모드 붕괴 문제)이 적습니다.  
    - 둘째, 안정적인 학습 과정을 제공합니다. GAN은 생성자와 판별자 간의 경쟁으로 인해 학습이 불안정해질 수 있지만, Diffusion 모델은 확률적 모델링을 기반으로 하기 때문에 학습이 비교적 안정적입니다.  
    - 셋째, 다양한 데이터 생성이 가능합니다. Diffusion 모델은 다양한 데이터 분포를 학습할 수 있어, 단순한 이미지 생성뿐만 아니라 스타일 변환, 텍스트-이미지 생성, 의료 영상 복원 등의 응용에도 활용됩니다.
