# STATE — 현재 작업 상태

> 최종 업데이트: 2026-04-30

## 오늘 완료/진척
- IW-254 묶음 종료 — 어제(4/29) IW-345/343/344 모두 완료, 오늘 부모 IW-254 Done 전환
- 완료 티켓 work 지시서 정리 — `.claude/work/mico/IW-254.md`, `IW-343.md`, `IW-344.md`, `IW-345.md` 삭제
- **글로벌 CLAUDE.md 다중 PC 동기화 세팅**
  - `shared/global-CLAUDE.md` 신규 (글로벌 규칙 원본, git 추적)
  - `~/.claude/CLAUDE.md` → `shared/global-CLAUDE.md` symlink (관리자 PowerShell + 개발자 모드 ON 필요)
  - `docs/setup.md`에 다른 PC 셋업 절차 추가

## 내일 이어갈 작업 (2026-05-01)
- **다음 묶음 착수 결정** — IW-187(Demo 구조) / IW-186(MU CI/CD) / IW-191(deps 이미지) 중 우선순위 정하기
- 부모 에픽 IW-184(MCT FANUC 3D)는 backlog 상태 — 다음 하위 작업 선정 필요
- IW-209 단독 진행 여부 확인 (work 지시서 남아있음, Plane 상태 미점검)

## ACTIVE_TASK
- 없음 — 다음 작업 풀에서 선택 필요

## 참고
- IW-254 묶음(IW-343/344/345) mico-3d 프로젝트에서 작업 종료
- mico-3d 메모리 fix 상세: `project_mct_phantom_diagonal_p1.md`, `feedback_data_guard_absolute.md`, `project_mct_cut_signal_unreliable.md`
- HW16MM-BAC 대각선 복귀 선 이슈는 IW-345 description 내 #3에 보류 사항으로 정리됨 (티켓 별도 생성 안 함)
- 글로벌 규칙 수정 시 `shared/global-CLAUDE.md` 직접 편집 → commit/push → 다른 PC `git pull` 한 번에 동기화
