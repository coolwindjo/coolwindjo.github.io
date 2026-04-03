---
title: "WJH Income Change Notification Pattern"
date: 2026-04-03 17:23 +0200
layout: post
categories: [knowledge]
tags: [knowledge-base, framework, wjh, germany]
knowledge_type: framework
status: evergreen
source_notes:
  - "memory/2026-04-01.md"
summary: "When income changes affect WJH eligibility, a direct and explicit notification flow may be more accurate than forcing the case into a generic continuation form."
slug: "wjh-income-change-notification-pattern"
lang: ko
confidence: 0.9
updated_by: llm
---

# WJH Income Change Notification Pattern

## Decision frame
WJH 대응에서 핵심은 '새 신청'인지, '계속지원 신청'인지, 아니면 '소득변경 통보 + 재산정/종료 요청'인지 먼저 구분하는 것이다.

## Inputs
- 소득변경 발생일
- 기존 WJH 진행 여부
- 온라인 폼이 자유서술을 충분히 수용하는지 여부

## Evaluation logic
1. 기존 건이 있고 소득변경을 즉시 반영해야 하면 통보 목적을 우선 본다.
2. 온라인 폼이 재신청/Weiterbewilligung 구조라면 의도 왜곡 가능성을 본다.
3. 통보 목적이 더 분명하면 메일/공식 연락 경로를 우선 검토한다.

## Output states
- 재신청 폼 제출
- 메일 기반 소득변경 통보
- WJH + 유치원 병행 커뮤니케이션

## Example from notes
- [[memory/2026-04-01.md]]
- 이번 사례에서는 취업으로 인한 소득변경 사실을 명확히 남기는 것이 중요했고, 전용 취소 폼은 확인되지 않아 메일 통보가 실무적으로 적절한 경로가 되었다.
