# STATE — 현재 작업 상태

> 최종 업데이트: 2026-05-09 (퇴근 시점)

## 오늘 완료/진척 (2026-05-09)

### IW-497 — mico-3d 유니티 버전 업그레이드 및 컴파일 경고 수정 (완료)

오늘 신규 생성 → 당일 완료. 작업 본문은 Plane IW-497 description에 풀로 보존됨. 요약:

- Unity 6000.0.55f1 → **6000.3.11f1** 업그레이드 (`ProjectSettings/ProjectVersion.txt`)
- **Unity MCP 셋업** (Claude Code ↔ Unity Editor 연동): `com.unity.ai.assistant` 2.7.0-pre.3, `relay_win.exe --mcp` stdio 연결. 가이드 문서 `docs/unity-mcp-setup.md` 생성. `.mcp.json`은 gitignore라 팀원 각자 작성 필요
- **KMA 날씨 API 재활성화** (2026-02-06 일시 비활성화 → 본문 복구, `return default;` 토글용 주석)
- 컴파일/직렬화 경고 일괄 정리:
  - **CS0114 OnDestroy 부모 미호출** — 위젯 leak 실질 버그 (`ChartCanvas.cs:185`, `GlobalAxisX.cs:112`)
  - **CS0660/CS0661** — `PressAnimationData` Equals/GetHashCode 추가
  - **CS1998 async void 정리** — `UI_Room_MCT_Data.Update_Data`, `RealTime_LabelData.SetMachine`
  - **CS0618 Find API deprecated** — `FindObjectOfType` → `FindAnyObjectByType`/`FindObjectsByType` (`CameraControllerInSpace`, `BSPTree`, `StarlinkEffect`, `WorldMapManager`, `CityManager`)
  - **Serialization depth 10 초과 경고** — JSON DTO 양방향 참조 차단 (`DataField`, `AuthMachineResponse`, `AuthMenuResponse`, `AuthRoomResponse`, `FloorResponse`, `RoomResponse`, `MachineResponse`)

### IW-187/188 — Demo 작업 (진행 중 유지)

오늘 Demo 세션에서는 본격 진행 안 함 (mico-3d 업그레이드 작업이 길어짐). Plane "진행 중" 상태 유지.

## 내일 이어갈 작업 (2026-05-10)

- **IW-187** Demo: 프로젝트 구조 세팅 — 건물/층/방 ClickableObject 부착 + CameraPreset 세팅, 카메라 프리셋 위치/회전 (Floor 가림 해결 포함)
- **IW-188** Demo: UI 디자인 — 색상 테마 적용 + 배경 에셋 리서치/적용
- **IW-497 남은 잠재 작업** — Plane description "남은 잠재 작업" 섹션 참고. `ApiServiceSO.cs` KMA 메서드 CS0162 (unreachable) 처리, RealtimeScroller `new` 키워드 추가 검토 등 (필요 시 별도 티켓 분리)

## 보류/대기
- **IW-481** 모니터링 정합성 오류 수정 — 부모(IW-438) 완료로 후순위, 별도 일정에 잡기
- **IW-483** T2 장비 배치 수정 — 미코·윈텍 데이터 수정 선행 대기
- **IW-486** `/latest/data` Redis-first + ClickHouse fallback (mico-backend) — 우선순위 낮음

## ACTIVE_TASK
- IW-187 Demo 프로젝트 구조 세팅 (진행 중)
- IW-188 Demo UI 디자인 (진행 중)

## 참고
- 본인 담당 work 지시서 현황: `mico/IW-481.md`, `mico/IW-483.md`, `Demo/IW-187.md`
- IW-497 work 지시서는 완료로 삭제됨
- IW-188 work 지시서 미생성 — Demo 세션에서 작업 착수 시 필요하면 생성
- IW-404 (MCT 2차 현장검증) 4/29 분석 본문은 Plane IW-404 description에 풀로 보존됨 — 재작업 시 거기서 시작
- 글로벌 CLAUDE.md 다중 PC 동기화: `shared/global-CLAUDE.md` symlink (4/30 세팅)
