# AIJOB — 개인 AI 업무 게이트웨이

> 핵심 목적: Claude의 컨텍스트 비용을 구조적으로 줄이는 정리 체계

## Tier 구조
| Tier | 파일 | 로드 시점 | 완료 시 |
|------|------|----------|--------|
| Hot | CLAUDE.md, STATE.md, TODO.md | 매 세션 자동 | 삭제 |
| Warm | CONTEXT.md, DECISIONS.md, endpoints/, work/weekly.md | 작업 시작 시 | 삭제 |
| Cold | docs/roadmap.md, runbooks/, integrations/ | 요청 시만 | 이력 보존 |

> Plane이 원본. Hot/Warm은 경량 뷰(휘발), Cold만 이력 보존.

## 세션 흐름
**하루 시작** (사용자가 시작/출근/오늘 등 하루 시작 의도를 표현하면):
1. `TODO.md` + `.claude/STATE.md` 로드
2. 전일자 TODO 미완료 항목 → Plane 상태 조회 → 정리 제안
3. 오늘 TODO 구성 → Plane 풀에서 추가 선택 + TODO.md 확정

**작업 중**:
4. 작업 착수 전 → TODO.md 계획 확정 + STATE.md 갱신
5. 작업 중 마일스톤 → STATE.md 즉시 갱신 + TODO.md 체크
6. 미티켓 업무 감지 → "Plane 티켓 없음. 생성할까요?"

**하루 마무리** (사용자가 정리/퇴근/마무리 등 종료 의도를 표현하면):
7. STATE.md 갱신: 오늘 완료한 작업 + 내일 이어갈 작업
8. TODO.md: 완료 항목 체크/삭제
9. Plane: 완료 티켓 Done 전환, 미완료는 진행 중 유지
10. Git: 변경된 파일 git add + commit (push는 별도 확인)

> 어느 시점에 끊겨도 파일만 읽으면 이어갈 수 있어야 함

## 핵심 규칙
- **Plane이 원본** — 이중 관리 금지. "티켓" = Plane, "지라 티켓"이라고 명시할 때만 Jira
- **문서 먼저, 작업은 이후** — TODO.md + STATE.md 갱신 후 작업 착수
- **TODO 항목에 Plane 티켓 없으면 경고**
- **이월 3회 시** 재검토 질문 (기한 초과 후부터 카운트, 기한 내는 이월 0회)
- **시크릿은 Vault 경로만** — 실제 값 커밋 금지
- **하위 티켓은 부모 모듈에 반드시 배정** — 모듈 미배정 금지
- **퇴근 시 7→8→9→10 순서 엄수** — 건너뛰거나 커밋부터 하지 말 것
- **공유가 필요한 규칙/노하우는 메모리가 아니라 레포 md에 기록** — 메모리(`~/.claude/`)는 로컬에만 남아 다른 컴퓨터에서 적용 안 됨. 여러 머신에서 같은 조건으로 작업하려면 `CLAUDE.md` 또는 `docs/*.md`에 적어 git으로 공유할 것

## 참고 문서
- Plane 조회 규칙: `docs/plane-query.md` (curl REST는 `expand=state` 미작동 등)
- 환경변수 세팅: `docs/setup.md`
- Jira 구조: `docs/jira-structure.md`

## Work 운영 규칙
- 티켓 생성 시 work 지시서도 함께 생성 (`.claude/work/{프로젝트}/{티켓번호}.md`)
- 프로젝트 폴더: mico, mu, Analyzer, Demo
- 각 유니티 프로젝트 세션에서 `/work`로 지시서 확인 후 작업 착수
- AIJOB 세션은 업무 관리 허브, 실제 코딩은 각 프로젝트 세션에서 진행
- 작업 완료 시: Plane 티켓 Done 전환 + 해당 md 파일 삭제

## MCP 토큰 관리
- 민감 정보(API 토큰 등)는 .env 파일에 `export VAR=값` 형태로 저장
- ~/.bashrc에서 source하여 셸 시작 시 자동 로드
- .mcp.json env 블록에 토큰을 넣지 말 것 — 셸 환경변수 상속으로 전달

## 보안 규칙
- .env, credentials, API key, kubeconfig, *.pem, *.key 커밋 금지
- 민감 정보는 Vault 경로 참조만 기록
- 환경변수 세팅 방법: `docs/setup.md` 참조

## 응답 스타일
- 한국어로 응답
- 요약 없이 바로 본론
