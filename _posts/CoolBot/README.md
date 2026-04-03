# Knowledge

memory/ 아래에 쌓이는 raw한 기록에서, 반복적으로 재사용 가능한 핵심 지식을 증류해 저장하는 폴더입니다.
이 폴더는 단순 메모 보관소가 아니라 **LLM이 유지·확장하는 개인 지식 베이스의 compiled layer**로 사용합니다.

## 목표
- memory의 사건 로그를 knowledge의 재사용 가능한 지식으로 승격
- Jekyll 블로그 게시를 바로 할 수 있는 markdown 산출물 유지
- Obsidian에서 사람이 읽고, LLM이 계속 보강하는 구조 유지

## 권장 지식 파이프라인
1. `raw/` 또는 외부 자료에서 원천 데이터 수집
2. `memory/`에 작업 로그/관찰/중간 판단 축적
3. `knowledge/`에서 사건을 추상화한 지식 문서로 distill
4. 필요 시 결과물을 블로그 글, 슬라이드, 다이어그램 등으로 파생
5. 새로 생성된 출력도 다시 knowledge 또는 관련 폴더에 편입

## 이 폴더에 들어와야 하는 것
- 여러 상황에 다시 적용 가능한 원칙
- 의사결정 프레임워크
- 체크리스트
- 개념 설명 문서
- 블로그 포스트로 발전 가능한 구조화된 통찰

## 이 폴더에 넣지 않는 것
- 일회성 잡담/상황 기록
- 감정 중심 일기
- 검증 전 임시 생각 조각
- 단순 TODO 나열

## 파일명 규칙
- `YYYY-MM-DD-english-knowledge-title.md`
- 예: `2026-04-03-memory-distillation-workflow.md`
- 영어 소문자 kebab-case 사용
- 사건명보다 지식명/원칙명 우선

## 문서 작성 원칙
- 사건 설명보다 **핵심 구조**를 먼저 쓴다.
- "무슨 일이 있었나"보다 "어떤 원칙을 일반화할 수 있나"를 우선한다.
- source note 링크를 반드시 남겨 추적 가능성을 유지한다.
- 하나의 문서는 한 개의 명확한 중심 통찰을 갖게 한다.
- LLM이 후속 Q&A, 요약, 시각화에 재사용하기 쉽도록 section 구조를 고정한다.

## Obsidian 템플릿
- 템플릿 파일: `templates/knowledge-distill-jekyll-template.md`
- Obsidian Templates 플러그인 폴더: `templates`
- 새 knowledge 노트 생성 후 템플릿을 삽입해 사용

## 추천 문서 유형
- principle: 반복 적용 가능한 원칙
- framework: 판단/분석 틀
- checklist: 실행 점검표
- synthesis: 여러 memory note를 묶은 종합 통찰
- explainer: 특정 개념을 설명하는 문서

## 예시 제목
- `2026-04-03-memory-distillation-workflow.md`
- `2026-04-03-family-culture-recommendation-rubric.md`
- `2026-04-03-knowledge-base-health-check-patterns.md`
