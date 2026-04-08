# Architecture Decisions

> 주요 아키텍처 결정 이력. AI가 "왜 이렇게 했는지" 파악할 때 참조.

---

## AD-001: AIJOB 워크스페이스 구조 및 업무 운영 정책 (2026-03-30)

**회의 참여자**: CTO, DevOps Lead, CFO (Agent Teams)

### 결정 사항

#### 1. AIJOB 정체성
- **정의**: Claude와 협업할 때 모든 레포/사이트/엔드포인트를 횡단하는 중앙 컨트롤 타워
- **핵심 목적**: Claude의 컨텍스트 비용을 구조적으로 줄이는 정리 체계
- **제외**: 고객사 배포 템플릿 아님, Installation 모드와 별도

#### 2. Tier 구조 + 업무 단위
| Tier | 파일 | 업무 단위 | 로드 시점 | 완료 시 |
|------|------|----------|----------|--------|
| Hot | CLAUDE.md, STATE.md, TODO.md | 일일 | 매 세션 자동 | 삭제 |
| Warm | CONTEXT.md, DECISIONS.md, endpoints/, work/weekly.md | 주간 | 작업 시작 시 | 삭제 |
| Cold | docs/roadmap.md, runbooks/, integrations/ | 분기/연간 | 요청 시만 | 완료 체크 (이력 보존) |

- Jira가 원본. Hot/Warm은 경량 뷰(휘발), Cold만 이력 보존.
- 업무 흐름: docs/roadmap.md → work/weekly.md → TODO.md (추출), 완료 → 역순으로 체크/삭제

#### 3. 디렉토리 네이밍
- **결정**: 기능별 영문명 (넘버링 00.xxx 제외)
- **근거**: git-friendly, self-documenting, 확장 시 rename 불필요 (전원 일치)

#### 4. endpoints/ 파일 구조
- **결정**: 사이트별 파일 (ingkle-dev.md, mico-prod.md, tp.md, common.md, repos.md)
- **근거**: 프롬프트 패턴이 "mico 사이트에서 ~해줘" 식으로 사이트명이 키워드. devops 레포 sites/ 패턴과 1:1 대응

#### 5. repos.md
- **결정**: 레포×브랜치×사이트×CI×Harbor×ArgoCD 테이블 매핑
- **근거**: 12+ 레포 × 3 사이트 환경에서 컨텍스트 재설명 비용 최대 절감 (전원 일치, 핵심 비용 절감 파일)

#### 6. devops 레포와의 관계
- **결정**: AIJOB은 메타 레이어, devops 레포 내용 복사 금지, 참조 포인터만
- **근거**: devops 레포에 이미 성숙한 .claude 구조 존재 (CONTEXT 358줄, DECISIONS 557줄, work/ 10카테고리). 이중 유지보수 방지

#### 7. 업무 운영 체계
- **결정**: Jira가 원본, AIJOB은 경량 뷰. 3단 구조:
  - TODO.md (Hot, 일일) — 완료 시 삭제
  - work/weekly.md (Warm, 주간) — 완료 시 삭제
  - docs/roadmap.md (Cold, 분기) — 완료 체크, 이력 보존
- **세션 흐름**: 문서 먼저, 작업은 이후
  1. TODO.md + STATE.md 로드
  2. 작업 착수 전 → TODO.md 계획 확정 + STATE.md 갱신
  3. 작업 중 마일스톤 → STATE.md 즉시 갱신 + TODO.md 체크
  4. 어느 시점에 끊겨도 파일만 읽으면 이어갈 수 있어야 함
- **TODO 미티켓화 경고**: 일일 업무가 Jira 티켓화 안 되어 있으면 Claude가 경고
- **이월 규칙**: 3회 이월 시 재검토 자동 질문
- **근거**: 문서를 작업 후에 갱신하면 세션 중단 시 맥락 복구 불가. .claude 시스템이 사용자 개입 없이 유기적으로 돌아가려면 문서가 항상 현재 상태를 반영해야 함

#### 8. 엔드포인트 생명주기
- **결정**: status 필드 (active/deprecated/archived), deprecated 30일 유예 후 archive/ 이동
- **근거**: 엔드포인트는 추가만이 아니라 폐기/교체도 발생. Claude가 구 정보로 작업하는 것 방지

#### 9. CLAUDE.md 압축
- **결정**: 60줄 이하 유지, 세션 종료 플로우차트/work 생명주기 규칙은 DECISIONS.md로 이관
- **근거**: 매 세션 강제 로드되는 Tier 1 파일 토큰 비용 최소화 (CFO)

#### 10. 정책 배포 → 삭제 (2026-03-30)
- **원래 결정**: policy/ 디렉토리로 다른 레포에 템플릿 배포
- **변경**: policy/ 삭제. 각 레포가 자체 .claude 구조를 갖고 있으므로 공통 템플릿 불필요
- **향후**: 전사 공통 규칙(커밋 정책, Jira 정책 등)이 확립되면 그때 재검토

#### 11. 업무 유입 경로
- **결정**: Slack/메일/회의록/직접전달/모니터링 알림 등 다양한 경로 → 모두 Jira 티켓화 → TODO.md 수렴
- **근거**: 어떤 경로든 하나의 Todo 리스트로 수렴해야 Claude가 일관된 컨텍스트 유지

#### 12. work/ 컨텍스트 버퍼 생명주기 (2026-03-30 추가)
- **결정**: work/는 작업 중 컨텍스트 축적 공간 (스크립팅, 트러블슈팅, Q&A 과정 기록)
- **생명주기**:
  1. 작업 중 → work/에 작업 단위 파일로 컨텍스트 축적
  2. 목표 달성 → 문서화할 것은 docs/, 루틴화할 것은 Jira 티켓
  3. 추출 완료 → work/ 해당 파일 삭제
- **주제 전환 시**: Claude가 이전 work/ 컨텍스트를 docs/ 문서화 / 유지 / 삭제 중 선택 질문
- **줄 제한 없음**: devops처럼 200줄 하드 제한 대신, 주제 전환 트리거로 자연 관리
- **근거**: 별도 시간 안 들이고 업무 과정에서 자연스럽게 지식 축적 → 문서화 → 신규 인원 경험 주입

#### 13. DECISIONS.md 항목 생명주기 (2026-03-30 추가)
- **결정**: AD 항목은 상세 → 압축 2단계
  - **상세 상태**: 신규 결정. 사유/과정/배경 전부 기록. 업무 적용 테스트 중
  - **압축 상태**: 검증 완료. 정책 한줄만 남기고 상세 삭제. 루틴화된 것
- **전환 조건**: 해당 정책이 문서화/루틴화 완료되면 압축
- **근거**: 상세 이력은 Jira + 회의록 + docs/에 이미 존재. DECISIONS.md는 정책 레지스트리이지 로그가 아님

---

## AD-002: Jira IW 프로젝트 애자일(칸반) 구조 세팅 (2026-03-30)

**회의 참여자**: 개발팀장, DevOps 팀장, CTO (Agent Teams)

### 핵심 원칙
- **제1원칙**: 기존 38개 프로젝트는 무시. 모든 새 규칙은 IW(Ingkle-work) 프로젝트 내에서만 적용
- **제2원칙**: 티켓은 사용자가 직접 수동 생성하지 않는다 (자동화)

### 결정 사항

#### 1. 프로젝트 정보
- 프로젝트명: Ingkle-work
- Key: IW
- ID: 10351
- 요금제: Jira Cloud PAID (Standard 이상)
- 활성 사용자: 10명

#### 2. 조직 구조: 스쿼드 + 칸반
- 스쿼드 형태, 직무 중복 없음
- 칸반 보드 (스프린트 없음, 연속 플로우)

#### 3. 인원 × 직무 매핑
| 이름 | 직무 | 담당 영역 |
|------|------|-----------|
| 조윤찬 | 대표/CTO | 전체 의사결정 |
| 오승준 | 프론트 + PM | mico-frontend, nzboard, 제품 기획 |
| 양영준 | 백엔드 | mico-backend, nzstore, NZCatalog |
| 유승주 | 데이터엔지니어 | edge 계열, nazaredb, 데이터 파이프라인 |
| 황인성 | 데이터엔지니어 | edge 계열, nazaredb, 데이터 파이프라인 |
| 표영종 | 데이터사이언티스트 | 분석/모델링, MLOps |
| 안준혁 | Edge(임베디드) | PLC, 백단 임베디드 |
| 오윤석 | 유니티 개발자 | Nazare 시각화/3D 모델링 |
| 서동주 | 인턴 | (배정 필요) |
| 전종현 | DevOps | CI/CD, 모니터링, 인프라 전체 |

#### 4. 제품 구조
- **NAZARE**: IoT/데이터 플랫폼 (메인 제품) — Edge → Ingestion → Pipeline → Storage → Backend → Board
- **NAVIS**: AI 에이전트 챗봇 시스템 (프로토타입 개발중)

#### 5. 에픽 구조 — 7개 (전원 일치)
| 에픽 | 축 | 자동 티켓 소스 |
|------|-----|---------------|
| NAZARE · ingkle-dev | NAZARE/운영 | Alertmanager, CI/CD 실패 |
| NAZARE · mico-prod | NAZARE/운영 | Alertmanager, CI/CD 실패, 고객 요청 |
| NAZARE · tp | NAZARE/운영 | Alertmanager, CI/CD 실패 |
| NAZARE · 고도화 | NAZARE/개발 | GitHub PR, Claude 대화 |
| NAVIS | NAVIS | Claude 대화, Slack |
| DevOps & Infra | 사내 | Alertmanager, CI/CD |
| 사내 생산성 | 사내 | Claude 대화, Slack |

#### 6. 칸반 보드 컬럼 — 5단계 (전원 일치)
| 컬럼 | 역할 | WIP 제한 |
|------|------|----------|
| Inbox | 자동 생성 티켓 버퍼 (제2원칙) | 없음 |
| Ready | 확인 + 우선순위 확정 | 10 |
| In Progress | 실제 작업 중 | 인당 2개 |
| Review | PR 대기, 검증, 블로킹 | 4 |
| Done | 완료 | 없음 |

#### 7. 컴포넌트 — 레포 slug 기준 (8개)
```
mico-frontend / mico-backend / nzstore / nzboard / nazaredb
edge / devops / common
```

#### 8. 라벨 체계
```
site:ingkle-dev / site:mico-prod / site:tp
source:claude / source:cicd / source:alertmanager / source:slack
priority:critical / priority:high / priority:medium / priority:low
```

---

## AD-003: 티켓 운영 정책 — 필드/마감일/자동화/메트릭 (2026-03-30)

**회의 참여자**: 개발팀장, DevOps 팀장, CTO (Agent Teams)

### 핵심 원칙
- Phase 1 범위: **모든 업무는 사람에게서 시작** → Claude가 형식 맞춰 Jira에 대신 등록
- 정책 강제: ~~패널티~~ → **Jira 필수 필드 게이트** (미입력 시 저장/이동 불가)
- 자동화 분리: **형식(What) = 공용 강제**, **방법(How) = 개인 자율**

### 결정 사항

#### 1. 필수 필드 (6개, 전원 일치)
| 필드 | 채우는 주체 | 비고 |
|------|-----------|------|
| Summary | Claude (템플릿) | |
| Epic Link | Claude (키워드 매핑) | Inbox→Ready 게이트 |
| Component | Claude (레포 slug 매핑) | 담당자 자동 배정 트리거 |
| Assignee | Claude (컴포넌트→담당자) | 수동 변경 가능 |
| Due Date | **필수** (요청자가 제공) | 전원 일치 |
| Labels | Claude (source: + site:) | |

#### 2. NoEstimates (전원 일치)
- Story Points 도입 안 함. 리드타임 퍼센타일(p50/p85/p95)로 대체

#### 3. 담당자 자동 배정 매핑
| 컴포넌트 | 1차 담당자 |
|---------|-----------|
| mico-frontend, nzboard | 오승준 |
| mico-backend, nzstore | 양영준 |
| nazaredb, edge | 유승주 or 황인성 |
| devops, common | 전종현 |

---

## AD-004: Jira 티켓 운영 정책 개정 + Claude 자동화 강제 메커니즘 (2026-03-31)

**회의 참여자**: CTO, HR 최고책임자, DevOps 팀장 (Agent Teams)

### 결정 사항

#### 1. Jira 원본, TODO는 일일 뷰 (이월 시스템)
- TODO.md에 이월 메타데이터 추가하지 않음. Jira 상태 자체가 이월 추적.

#### 2. TODO ↔ Jira 아침 비교
- 세션 시작 시 TODO.md의 티켓 키로 Jira 상태 조회, 불일치 알림.

#### 3. 완료 기준 필수화
- 모든 이슈 타입(하위작업 포함)에 완료 조건 필수. 없으면 생성 금지.

#### 4. 하위작업 생성 기준
- 담당자가 다르거나 독립 추적 필요 시에만 하위작업 생성.

#### 5. 위임 플로우 정의
- 위임 = assignee 영구 변경 + 코멘트(사유/기대결과/기한) + 원래 담당자 watcher 추가 + TODO 삭제.

#### 6. Claude 자동화 강제 — hooks 체계
- hooks로 시스템 레벨 강제.
  | Hook | 트리거 | 동작 |
  |------|--------|------|
  | bootstrap-vault.sh | SessionStart | Vault → JIRA_TOKEN/VAULT_TOKEN 자동 세팅 |
- 원칙: hooks는 "차단형 게이트"에만 사용, 나머지는 정책+컨텍스트 주입.
