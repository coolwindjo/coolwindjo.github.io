---
mx-uid: xvab88dhszalzktaglmwbnzj
video: file:///Users/josh/Library/CloudStorage/OneDrive-Personal/StudyRoom/Lectures/AI/Stanford%20CS230%20%EF%BD%9C%20Autumn%202025/Stanford%20CS230%20%EF%BD%9C%20Autumn%202025%20%EF%BD%9C%20Lecture%201%EF%BC%9A%20Introduction%20to%20Deep%20Learning%20[_NLHFoVNlbg].webm
duration: 3616.69
aspect_ratio: 16 / 9
layout: post
title: Stanford CS230 ｜ Autumn 2025 ｜ Lecture 1： Introduction to Deep Learning
subtitle:
categories: SecondBrain
status: published
tags:
  - lecture
  - ai
mathjax: false
---
Tags: [[study]], [[ai]]

# Stanford CS230 ｜ Autumn 2025 ｜ Lecture 1： Introduction to Deep Learning

**Date:** 2026-01-21
**Source:** https://www.youtube.com/watch?v=_NLHFoVNlbg

---

## Notes (상세 내용)

- [10:33](file:///Users/josh/Library/CloudStorage/OneDrive-Personal/StudyRoom/Lectures/AI/Stanford%20CS230%20%EF%BD%9C%20Autumn%202025/Stanford%20CS230%20%EF%BD%9C%20Autumn%202025%20%EF%BD%9C%20Lecture%201%EF%BC%9A%20Introduction%20to%20Deep%20Learning%20[_NLHFoVNlbg].webm#t=10:33):
	- Gen AI
	- Deep Learning
	- Machine Learning
	- CS Fundamental
- [12:30](file:///Users/josh/Library/CloudStorage/OneDrive-Personal/StudyRoom/Lectures/AI/Stanford%20CS230%20%EF%BD%9C%20Autumn%202025/Stanford%20CS230%20%EF%BD%9C%20Autumn%202025%20%EF%BD%9C%20Lecture%201%EF%BC%9A%20Introduction%20to%20Deep%20Learning%20[_NLHFoVNlbg].webm#t=12:30): Prerequisites
	- CS129: Easy entry point
	- CS229: Andrew Ng's second lecture, mathematical, theoretical
	- CS230: Focuses on just deep learning
- [15:23](file:///Users/josh/Library/CloudStorage/OneDrive-Personal/StudyRoom/Lectures/AI/Stanford%20CS230%20%EF%BD%9C%20Autumn%202025/Stanford%20CS230%20%EF%BD%9C%20Autumn%202025%20%EF%BD%9C%20Lecture%201%EF%BC%9A%20Introduction%20to%20Deep%20Learning%20[_NLHFoVNlbg].webm#t=15:23): cover the recent LLM developments, we will touch on the **transformer** neural network, but **not the latest LLM variations** in this course.
	- [16:49](file:///Users/josh/Library/CloudStorage/OneDrive-Personal/StudyRoom/Lectures/AI/Stanford%20CS230%20%EF%BD%9C%20Autumn%202025/Stanford%20CS230%20%EF%BD%9C%20Autumn%202025%20%EF%BD%9C%20Lecture%201%EF%BC%9A%20Introduction%20to%20Deep%20Learning%20[_NLHFoVNlbg].webm#t=16:49): Not cover in this course... how to train the largest cutting edge transformer - Percy Liang covers it
- [15:46](file:///Users/josh/Library/CloudStorage/OneDrive-Personal/StudyRoom/Lectures/AI/Stanford%20CS230%20%EF%BD%9C%20Autumn%202025/Stanford%20CS230%20%EF%BD%9C%20Autumn%202025%20%EF%BD%9C%20Lecture%201%EF%BC%9A%20Introduction%20to%20Deep%20Learning%20[_NLHFoVNlbg].webm#t=15:46): 
	- Training LLM 을 하는 사람은 적고 고연봉!
	- Majority of ppl
		- Working the GenAI level
			- not that often training a transformer from scratch
			- (not) often using deep learning tools 
		- Take a pre-trained transformer network
			- Fine tune it with his own data
- [19:31](file:///Users/josh/Library/CloudStorage/OneDrive-Personal/StudyRoom/Lectures/AI/Stanford%20CS230%20%EF%BD%9C%20Autumn%202025/Stanford%20CS230%20%EF%BD%9C%20Autumn%202025%20%EF%BD%9C%20Lecture%201%EF%BC%9A%20Introduction%20to%20Deep%20Learning%20[_NLHFoVNlbg].webm#t=19:31): GenAI -> text
	- Prompt GenAI works really well for a lot of text-based applications
		- And there's work on multimodal LLMs, large multimodal models.
			- So making inroads into vision, making inroads into audio. 
		- But really GenAI algorithms, especially transformer networks trained to output text, like ChatGPT, Claude, Gemini,
- [19:59](file:///Users/josh/Library/CloudStorage/OneDrive-Personal/StudyRoom/Lectures/AI/Stanford%20CS230%20%EF%BD%9C%20Autumn%202025/Stanford%20CS230%20%EF%BD%9C%20Autumn%202025%20%EF%BD%9C%20Lecture%201%EF%BC%9A%20Introduction%20to%20Deep%20Learning%20[_NLHFoVNlbg].webm#t=19:59): Deep Learning -> audio, image data, structured data (e.g. spreadsheet)
	- But for other types of data, I end up often dipping down directly to use various deep learning algorithms.
	- [22:34](file:///Users/josh/Library/CloudStorage/OneDrive-Personal/StudyRoom/Lectures/AI/Stanford%20CS230%20%EF%BD%9C%20Autumn%202025/Stanford%20CS230%20%EF%BD%9C%20Autumn%202025%20%EF%BD%9C%20Lecture%201%EF%BC%9A%20Introduction%20to%20Deep%20Learning%20[_NLHFoVNlbg].webm#t=22:34): Critical skill for saving costs! -> Knowing how to use Deep Learning to fine tune smaller models
> [!Note]- Skill sets to be covered
> 
> ## **Stanford CS230: 실무 중심 AI 빌더 양성 과정**
>### **1. 딥러닝 핵심 기초 (Foundations)**
>- **Bottom-up 학습:** 프레임워크 없이 Python으로 신경망 직접 구현하며 내부 원리 습득
>- **최적화:** 하이퍼파라미터 튜닝 직관력 양성 및 주요 아키텍처(CNN, Transformer) 마스터
>    
>### **2. 생성형 AI 및 LLM 응용 (Generative AI)**
>- **모델링:** GAN(적대적 생성) 및 Diffusion(확산/노이즈 제거) 알고리즘 이해
>- **LLM 고도화:** 프롬프트 엔지니어링(CoT, Few-Shot), RAG(검색 증강 생성) 시스템 구축
>- **에이전트:** 도구 사용, 메모리 관리, 자아 성찰이 가능한 자율적 에이전트 설계
>
>### **3. 강화학습 및 정렬 (RL & Alignment)**
>- **알고리즘:** DQN, PPO 등 순차적 의사결정 모델 학습
>- **RLHF:** 인간 피드백을 통한 모델 정렬(SFT → 보상 모델 → RL 최적화) 과정 습득
>
>### **4. 프로젝트 전략 및 실무 사이클 (AI Strategy)**
>- **Full-Cycle:** 문제 정의부터 데이터 수집, 배포, 유지보수까지 전 과정 관리
>- **데이터/디버깅:** 데이터 드리프트 대응 및 체계적인 에러 분석을 통한 성능 개선 전략
>- **평가(Evals):** LLM-as-a-judge 등 주관적 결과물에 대한 정량적 평가 시스템 구축
>
>### **5. 진단 및 보안 (Interpretability & Robustness)**
>- **해석 가능성:** Saliency Map, CAM 등을 활용해 블랙박스 모델의 판단 근거 시각화
>- **강건성:** 적대적 공격(데이터 오염, 프롬프트 인젝션) 원리 파악 및 방어 체계 구축
>
---
- [23:29](file:///Users/josh/Library/CloudStorage/OneDrive-Personal/StudyRoom/Lectures/AI/Stanford%20CS230%20%EF%BD%9C%20Autumn%202025/Stanford%20CS230%20%EF%BD%9C%20Autumn%202025%20%EF%BD%9C%20Lecture%201%EF%BC%9A%20Introduction%20to%20Deep%20Learning%20[_NLHFoVNlbg].webm#t=23:29): Overview
	- Module 1: NN, DL
	- Module 2: Improve NN
	- Module 3: Strategies for ML projects
	- Module 4: Conv NNs
	- Module 5: Sequence Model
- [47:05](file:///Users/josh/Library/CloudStorage/OneDrive-Personal/StudyRoom/Lectures/AI/Stanford%20CS230%20%EF%BD%9C%20Autumn%202025/Stanford%20CS230%20%EF%BD%9C%20Autumn%202025%20%EF%BD%9C%20Lecture%201%EF%BC%9A%20Introduction%20to%20Deep%20Learning%20[_NLHFoVNlbg].webm#t=47:05): Career Advices
	- Older non-AI enabled skill set 
	- AI 시대의 프로그래밍 역량 변화
		- **전통적 경력의 한계:** 10년 경력의 풀스택 엔지니어라도 최신 AI 도구를 활용하지 못하면, AI 숙련도가 높은 대학 졸업 예정자보다 경쟁력이 뒤처질 수 있음. 
		- **AI 보조 코딩(AI-assisted coding)의 중요성:** AI를 활용해 빠르게 프로그램을 구축하고 배포할 수 있는 능력이 실질적인 채용 결정 요소로 작용함.
		- **수요와 공급의 불균형:** AI 활용 능력을 갖춘 개발자에 대한 기업의 수요는 매우 높으나, 인력 공급은 부족한 상황.
	- 수작업 코딩이 여전히 필요한 영역
		- **특수 분야:** AI가 아직 정교하게 처리하지 못하는 저수준(Low-level) 코딩. 
		- **GPU 프로그래밍:** 특정 니치(Niche) 영역에서는 여전히 수작업 코딩이 효율성과 성능 면에서 유리함.
	- 고성과 개발자의 핵심 역량: '기본기 + AI'
		- **컴퓨터 과학(CS) 기본기:** 단순히 프롬프트를 입력하는 것과 CS 지식을 바탕으로 문제를 분석하여 AI에게 지시하는 것 사이에는 큰 성능 차이가 존재함. 
		- **필수 지식 습득:** * 컴퓨터 작동 원리 이해.
		- 머신러닝(ML) 및 딥러닝(DL)의 기본 개념 파악. 
		- **의사결정 능력:** CS 및 AI 기본기는 실무에서 매우 중요한 기술적 의사결정을 내릴 때 매일 활용되는 필수 자산임.
> [!cite]- The best programmers I know are really on top of AI-assisted coding and additionally deeply understand computer science fundamentals.
> Maybe some specialties, some very low level coding where AI is not very good. It turns out AI is not very good at some types of GPU programming. There are some niches where coding by hand actually still makes sense. But for building applications
> 
> So I actually-- I remember just a few months ago now, many months ago now, where I interviewed two engineers back to back. One had not yet graduated from college, but was highly on top of GenAI coding. So spoke with that candidate, knew how to use AI, built programs and could sell them quickly. Right after that, I also interviewed someone with 10 years of experience as a full stack engineer, but whose skill set was exactly the same as their 2002 skill set. Had not tried out any AI-assisted coding. Really good skills, full stack engineer with 10 years of experience. And it was actually really clear to me, I picked the fresh college grad where he had not-- he was about to graduate, over someone with 10 years of experience. So I think making sure you master these skills are really important. And what I'm seeing is there is a very large gap that businesses are having a hard time filling for people with these skills.
>
>  The best programmers I know are really on top of AI-assisted coding and additionally deeply understand computer science fundamentals. 
>  
>  One of the most important skills for the future is to understand how computers work and understand how GenAI and deep learning and machine learning work so that you can use the language of AI, use the language of these tools to tell a computer exactly what you want, so the computer can do it for you. And there is actually a huge difference in performance between someone that's learned to just prompt an LLM without understanding how computers or how AI really works, versus people that can look at the problem, analyse it, and then with AI-assisted coding, tell a computer how to take the next steps, which is why I think that CS fundamentals is very valuable. CS fundamentals, machine learning fundamentals, deep learning fundamentals, I and my teams, we use that knowledge like every day in making pretty consequential decisions.
- [53:47](file:///Users/josh/Library/CloudStorage/OneDrive-Personal/StudyRoom/Lectures/AI/Stanford%20CS230%20%EF%BD%9C%20Autumn%202025/Stanford%20CS230%20%EF%BD%9C%20Autumn%202025%20%EF%BD%9C%20Lecture%201%EF%BC%9A%20Introduction%20to%20Deep%20Learning%20[_NLHFoVNlbg].webm#t=53:47) : Rank Productivity

| Rank             | Feature               | Productivity                             |
| ---------------- | --------------------- | ---------------------------------------- |
| **Level 1 (최하)** | **경험 없음 + AI 미숙련**    | 가장 낮은 생산성을 보임.                           |
| **Level 2**      | **10년 경력 + AI 미숙련**   | 숙련된 기술은 있으나 AI 도구의 효율성을 누리지 못함.          |
| **Level 3**      | **신입(경험 적음) + AI 숙련** | AI를 통해 경력자의 숙련도 차이를 극복하며, Level 2보다 선호됨. |
| **Level 4 (최상)** | **10년 경력 + AI 숙련**    | 압도적인 생산성. 과거에는 불가능했던 속도로 코드를 배포(Ship)함.  |

> [!cite]- really harnessing AI is very important, but experience is also important. And so the best developers I know, we just work and we just ship code like no one's ever done, I think, even two or three years ago, are very experienced developers.
> let me rank productivity, and I'll give you four levels.
> ...
>I think least productive are people with no experience and don't know AI.
>One step on top of that is people with less experience but on a-- sorry, one step on top of that is people with, say, a decade of experience but that don't know AI.
>On top of that, I would rather take a fresh college grad that does know AI,
>but then even more productive is someone with a decade of experience and also really on top of AI.
>So I think between the two factors, really harnessing AI is very important, but experience is also important. And so the best developers I know, we just work and we just ship code like no one's ever done, I think, even two or three years ago, are very experienced developers. They're also very on top of how they use the latest AI technologies.
> I find that a lot of employers have not yet figured out how to hire appropriately. This has contributed-- frankly, a lot of employers, if a company has no one that knows GenAI, how do they even how to interview appropriately? So that is a problem that we need to solve as well. 
>

- [56:29](file:///Users/josh/Library/CloudStorage/OneDrive-Personal/StudyRoom/Lectures/AI/Stanford%20CS230%20%EF%BD%9C%20Autumn%202025/Stanford%20CS230%20%EF%BD%9C%20Autumn%202025%20%EF%BD%9C%20Lecture%201%EF%BC%9A%20Introduction%20to%20Deep%20Learning%20[_NLHFoVNlbg].webm#t=56:29): How to tell someone that really know GenAI from someone that just use a tool
	- GenAI
		- Deep Learning is not GenAI
		- Two buckets of skill
			- Know how to use AI coding assistance
			- And below citation
> [!cite]- New techniques built on top of GenAI that are like a useful bag of tools for building applications. 
> There are emerging tools, like **RAG, Retrieval Augmented Generation**, or how to-- vector databases, how to do evals and error analysis, how to **build guardrails**, how to use **knowledge graphs** and interface that with LLM, maybe how to do **multimodal LLMs**, how to fine-tune the model.
> What else? I'm probably blanking on something. Oh, how to **build agentic workflows**. But I feel like there are these categories of new techniques built on top of GenAI that are like a useful bag of tools for building applications. Well, frankly, when I'm interviewing candidates, we still do a fair amount of, it is very GenAI role, is these skills I tend to look for, this set of tools as well as AI-assisted coding.
 
## Cue (질문/키워드)

> [!cue] What is GenAI?
> - **Timestamp:** 
> - [19:31](file:///Users/josh/Library/CloudStorage/OneDrive-Personal/StudyRoom/Lectures/AI/Stanford%20CS230%20%EF%BD%9C%20Autumn%202025/Stanford%20CS230%20%EF%BD%9C%20Autumn%202025%20%EF%BD%9C%20Lecture%201%EF%BC%9A%20Introduction%20to%20Deep%20Learning%20[_NLHFoVNlbg].webm#t=19:31): GenAI -> text
> - [56:29](file:///Users/josh/Library/CloudStorage/OneDrive-Personal/StudyRoom/Lectures/AI/Stanford%20CS230%20%EF%BD%9C%20Autumn%202025/Stanford%20CS230%20%EF%BD%9C%20Autumn%202025%20%EF%BD%9C%20Lecture%201%EF%BC%9A%20Introduction%20to%20Deep%20Learning%20[_NLHFoVNlbg].webm#t=56:29): How to tell someone that really know GenAI from someone that just use a tool
> - **My Thought:** GenAI는 Deep Learning base로 개발된 Text 위주의 Transformer 모델이고, 최근 가장 Hot한 모델이다.

> [!cue] Who is a desirable AI Engineer?
> - **Timestamp:**
> - [47:05](file:///Users/josh/Library/CloudStorage/OneDrive-Personal/StudyRoom/Lectures/AI/Stanford%20CS230%20%EF%BD%9C%20Autumn%202025/Stanford%20CS230%20%EF%BD%9C%20Autumn%202025%20%EF%BD%9C%20Lecture%201%EF%BC%9A%20Introduction%20to%20Deep%20Learning%20[_NLHFoVNlbg].webm#t=47:05): Career Advices
> - [56:29](file:///Users/josh/Library/CloudStorage/OneDrive-Personal/StudyRoom/Lectures/AI/Stanford%20CS230%20%EF%BD%9C%20Autumn%202025/Stanford%20CS230%20%EF%BD%9C%20Autumn%202025%20%EF%BD%9C%20Lecture%201%EF%BC%9A%20Introduction%20to%20Deep%20Learning%20[_NLHFoVNlbg].webm#t=56:29): How to tell someone that really know GenAI from someone that just use a tool
> - **My Thought:** AI-assisted coding를 자유롭게 사용하면서도 그 아래의 CS 기초가 탄탄하고, ML, DNN, GenAI 지식이 있는 엔지니어


---

## Summary (내 언어로 요약)

> [!summary] Summary
> 이 비디오는 GenAI와 최근 Job Market에서 demanding 한 GenAI 관련 Skill set에 대한 Andrew Ng교수의 의견을 다루고 있다. 특히 GenAI를 비롯한 지식과 열정적인 Fine-tuning skill 을 강조하며, 이는 이 수업에 대한 독려로 이어진다. 이 내용을 통해 나는 AI Skill-set에 대한 중요성에 대한 통찰을 얻었다.
> 
> 3줄 요약
> 1. GenAI 배워라
> 2. AI-Assisted Coding을 자유롭게 써라
> 3. RAG, Guardrail building, Knowledge Graph, Multimodal LLMs, Agentic Workflow Building 등의 GenAI를 이용한 Tool을 자유롭게 써라

---
## Review Questions (복습용)

### CS230 Lecture 1 복습 문제 (Review Questions)

**문제 1. AI 시대의 개발자 생산성(Productivity) 순위와 관련하여, 강의에서는 'AI 기술을 습득하지 못한 10년 차 경력자'와 'AI 코딩에 능숙한 신입(대학 졸업 예정자)' 중 누구를 더 선호한다고 언급했나요? 그 이유는 무엇인가요?**

> **정답 및 해설:** 강의에서는 **AI 코딩에 능숙한 신입**을 더 선호한다고 언급했습니다 (Level 3 > Level 2). Andrew Ng 교수는 실제로 10년 경력의 풀스택 엔지니어보다 AI 보조 코딩(AI-assisted coding)을 활용해 빠르게 프로그램을 구축하고 배포할 수 있는 대학 졸업 예정자를 채용한 사례를 들었습니다. 이는 AI 도구를 활용하지 못하는 전통적인 숙련자보다, AI를 활용해 압도적인 속도로 코드를 배포(Ship)할 수 있는 능력이 현대의 생산성에서 더 중요하기 때문입니다. 단, 가장 생산성이 높은 단계(Level 4)는 'AI에 능숙한 10년 차 경력자'입니다,,.

---

**문제 2. 생성형 AI(GenAI) 애플리케이션을 운영할 때, 사용자가 늘어나면서 발생하는 막대한 LLM 비용을 절감하기 위해 강의에서 강조한 '핵심 기술(Critical Skill)'은 무엇인가요?**

> **정답 및 해설:** **딥러닝을 사용하여 더 작은 모델을 미세 조정(Fine-tune)하는 능력**입니다. 프로토타입 단계에서는 LLM 프롬프팅만으로 충분할 수 있지만, 사용자 수가 늘어나면 비용이 급증하게 됩니다. 이때 비용 곡선을 꺾기(bend the cost curve) 위해서는 거대 모델 대신 자신의 데이터로 더 작은 모델을 미세 조정하여 사용하는 기술이 필수적이라고 강조했습니다,.

---

**문제 3. 채용 시장에서 단순히 LLM을 프롬프팅하는 것을 넘어, 실제 애플리케이션 구축을 위해 요구되는 '새로운 도구(Emerging tools)'들에는 어떤 기술들이 포함되나요? (2가지 이상)**

> **정답 및 해설:** 강의에서 언급된 주요 도구들은 다음과 같습니다:
> 
> - **RAG (검색 증강 생성, Retrieval Augmented Generation)**
> - **Vector Databases (벡터 데이터베이스)**
> - **Evals & Error Analysis (평가 및 에러 분석)**
> - **Guardrails (가드레일 구축)**
> - **Agentic Workflows (에이전트 워크플로우 구축)**
> 
> 고용주들은 단순히 AI 코딩 도구를 쓰는 것을 넘어, GenAI 위에 구축된 이러한 새로운 기술 스택을 다룰 수 있는 인재를 찾고 있습니다,.