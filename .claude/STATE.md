# STATE — 현재 작업 상태

> 최종 업데이트: 2026-05-13 (퇴근 시점)

## 오늘 진척 (2026-05-13 수)

### AIJOB 세션 — 출근 동기화 + 신규 티켓 생성

- **Plane 상태 갭 동기화**: IW-187/188 진행 중 유지, IW-486 `해야 할 일`(schema draft 대기), IW-481·IW-483 `준비 완료`(보류 분류 일치)
- **신규 티켓 생성**: **IW-525** Demo: 배경 오브젝트 세팅 (IW-188 하위, 본인 담당, `BIZ · 영업 · 2026` 모듈 배정)

### Demo 세션 — IW-525 당일 완료

- **IW-525 완료 (17:52 Done)** — 생성 당일 클로즈. Plane description에 작업 풀로 보존:
  - `/Object/Urban_BG_V2` 외곽 도시 4,248개 인스턴스 (Roads 1000 / Sidewalks 1984 / Buildings 724 / Lights 280 / Vegetation 200 / Props 60), warehouse_2·Building_2_Cover 보호구역 침범 0
  - `/Object/Urban_BG_V2/Inner` 보호구역 내 172개 (Buildings 22 + Diverse Buildings 120 + Vegetation 100 + Props 30, 1m 그리드 빈공간 스캔)
  - 가로등 yaw +180° (Urban_BG_V2/Lights 143개) + 세로 도로 차선 yaw=90 (476개) 보정
  - `/Object/Floor` Plane primitive 복구 (localScale 50,1,50, sibling 0)
  - `Assets/2.Script/MainController.cs` line 222-262 — buildings[] SetActive → SetBuildingClickable(Collider enabled 토글)로 교체. warehouse_2/Building_2_Cover 진입 시 다른 건물 사라지지 않고 클릭만 차단
- **IW-187 / IW-188 진척 0** — IW-525 작업에 시간 집중, 남은 작업 그대로 이월

## 내일 계획 (2026-05-14 목)

- **IW-187** Demo 프로젝트 구조 세팅 — ClickableObject 부착 + CameraPreset 세팅 (Factory 프리셋 Floor 가림 해결). 5/12·13 진척 0으로 이월 2회 (기한 미설정이라 카운트는 참고용)
- **IW-188** Demo UI 디자인 — IW-187과 같은 Demo 세션에서 병행
- **Slack 알림 중복 정리 요청** — Admin(조윤찬/전종현)에게 ingle-work 워크스페이스 Slack integration 중복 점검 요청 (오늘 미진행)
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
- IW-497·IW-525 work 지시서는 완료로 삭제됨
- IW-404 (MCT 2차 현장검증) 4/29 분석 본문은 Plane IW-404 description에 풀로 보존됨
- 글로벌 CLAUDE.md 다중 PC 동기화: `shared/global-CLAUDE.md` symlink (4/30 세팅)
