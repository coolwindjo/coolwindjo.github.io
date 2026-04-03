---
title: "Transparent Model Routing Communication"
date: 2026-04-03 17:23 +0200
layout: post
categories: [knowledge]
tags: [knowledge-base, principle, model-routing]
knowledge_type: principle
status: evergreen
source_notes:
  - "memory/2026-03-17.md"
summary: "Model routing should stay visible to the user, but explanations should remain brief unless the user asks for more detail."
slug: "transparent-model-routing-communication"
lang: ko
confidence: 0.95
updated_by: llm
---

# Transparent Model Routing Communication

## Principle
모델 라우팅은 숨기지 말되, 평소에는 짧고 맥락 보존적인 방식으로만 드러낸다.

## When to use
- 모든 사용자 응답의 첫머리 라우팅 표기
- 내부 위임/상위 모델 사용 사실을 설명해야 하는 상황

## Why it works
사용자는 현재 어떤 수준의 처리가 이뤄지는지 알 권리가 있지만, 내부 구현 세부사항까지 매번 노출하면 오히려 답변 가독성과 신뢰감이 떨어진다.

## Evidence
- [[memory/2026-03-17.md]]
- 모든 요청에서 라우팅 표기를 유지하기로 함.
- 추가 설명은 사용자가 이유를 물을 때만 제공하기로 함.

## Failure modes
- 내부 구현 용어를 과도하게 노출하는 경우
- 반대로 라우팅 정보를 숨겨 투명성이 떨어지는 경우

## Operational rule
- 답변 첫줄에는 라우팅 표기를 항상 유지한다.
- 설명은 1줄 기본, 추가 설명은 요청 시만 한다.
