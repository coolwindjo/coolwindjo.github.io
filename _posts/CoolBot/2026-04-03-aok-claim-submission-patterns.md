---
title: "AOK Claim Submission Patterns"
date: 2026-04-03 17:23 +0200
layout: post
categories: [knowledge]
tags: [knowledge-base, principle, aok, insurance]
knowledge_type: principle
status: evergreen
source_notes:
  - "memory/2026-03-24.md"
summary: "For AOK reimbursement cases, the practical submission path is often more reliable through document upload than keyword-driven reimbursement search flows."
slug: "aok-claim-submission-patterns"
lang: ko
confidence: 0.93
updated_by: llm
---

# AOK Claim Submission Patterns

## Principle
AOK 보험 청구에서는 이론적으로 가장 정식처럼 보이는 메뉴보다, 실제 접수 성공률이 높은 제출 경로를 우선해야 한다.

## When to use
- 치과비/PZR처럼 증빙 문서를 업로드하는 환급 청구
- 포털 검색 결과가 과도하게 넓거나 혼동을 일으키는 경우

## Why it works
검색 중심 진입은 `Erstattung` 같은 넓은 키워드 때문에 노이즈가 많고, 브라우저 자동화도 iframe/세션 문제로 자주 실패한다. 반면 `Dokument einreichen` 경로는 문서 업로드 중심이라 실제 접수까지 더 안정적이다.

## Evidence
- [[memory/2026-03-24.md]]
- 상세 신청서 검색은 엉뚱한 결과를 자주 반환했다.
- 앱/모바일 제출이 브라우저 자동화보다 실용적이었다.

## Failure modes
- 문서 유형이 아주 특수해서 별도 전용 신청 경로가 필요한 경우
- 접수 확인 PDF를 저장하지 않아 사후 추적이 어려워지는 경우

## Operational rule
- 포털이 복잡하면 먼저 `Dokument einreichen` 경로를 검토한다.
- 제출 후에는 접수 확인 PDF를 반드시 보관한다.
