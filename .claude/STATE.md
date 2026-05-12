# STATE — 현재 작업 상태

> 최종 업데이트: 2026-05-12 (퇴근 시점)

## 오늘 진척 (2026-05-12 화)

### AIJOB 세션 — 출근/갭 동기화 + Slack 알림 이슈 디버깅

- **갭 동기화 (5/10·11)**:
  - IW-497 (mico-3d 유니티 업그레이드) 5/11 17:39 Done 확인 — STATE 누락 반영
  - IW-486 (`/latest/data` 신규 API) 5/11 17:09 본인이 담당자로 추가됨 확인 (백엔드 양영준 주, 본인은 유니티 schema 합의 역할)
- **Slack 이중 알림 이슈 디버깅**:
  - 증상: Plane → Slack 알림이 같은 채널에 동일 메시지 2번 post (스크린샷 `Desktop/slack.png` 확인)
  - 원인: 워크스페이스 Slack integration 또는 Webhook 중복 등록 추정
  - 본인 권한 Member라 Workspace Settings → Integrations 메뉴 접근 불가
  - **TODO**: Workspace Admin(조윤찬/전종현)에게 정리 요청 필요

### Demo 세션 (IW-187/188) — **오늘 진척 0**

오늘 Demo 세션 작업하지 않음. Plane 상태 진행 중 유지. 내일 본격 진행 예정.

## 내일 계획 (2026-05-13 수)

- **IW-187** Demo 프로젝트 구조 세팅 — 오늘 못 한 것 그대로: ClickableObject 부착 + CameraPreset 세팅 (Factory 프리셋에서 Floor 가림 해결 포함). **내일 메인**
- **IW-188** Demo UI 디자인 — IW-187과 같은 세션에서 병행 가능
- **Slack 알림 중복 정리 요청** — Admin에게 ingle-work 워크스페이스 Slack integration 중복 점검 요청
- **IW-486** schema 협의 — 양영준 측 draft 들어오면 검토

## 보류/대기
- **IW-481** 모니터링 정합성 오류 수정 — 부모(IW-438) 완료로 후순위
- **IW-483** T2 장비 배치 수정 — 미코·윈텍 데이터 수정 선행 대기

## ACTIVE_TASK
- IW-187 Demo 프로젝트 구조 세팅 (진행 중, 내일 이어감)
- IW-188 Demo UI 디자인 (진행 중, 병행)

## 참고
- 본인 담당 work 지시서 현황: `mico/IW-481.md`, `mico/IW-483.md`, `Demo/IW-187.md`
- IW-188 work 지시서 미생성 — Demo 세션에서 작업 착수 시 필요하면 생성
- IW-486 work 지시서 미생성 — mico-backend 티켓이고 본인은 schema 합의 역할이라 보류
- IW-497 work 지시서는 완료로 삭제됨
- IW-404 (MCT 2차 현장검증) 4/29 분석 본문은 Plane IW-404 description에 풀로 보존됨
- 글로벌 CLAUDE.md 다중 PC 동기화: `shared/global-CLAUDE.md` symlink (4/30 세팅)
