# STATE — 현재 작업 상태

> 최종 업데이트: 2026-05-04

## 오늘 완료/진척 (2026-05-04)
- **IW-438 신규 — Mico 4월 마무리 작업** (부모, 진행 중, target 2026-05-09)
- **IW-439 신규 — UI 수정 및 변경작업** (IW-438 하위, 진행 중)
  - RoomPage 관련 UI 수정 5건 정리:
    1. RealTime_LabelData 풀 재사용 fold 잔상 수정 검증 — `SetMachine` 시작부 강제 닫힘 + `Set_MachineLable` 데이터 로딩 후 정식 fold. 핵심 fix는 견고하나 부수 이슈 2건(API 실패 시 fold 영구 무반응, race condition) 추가 식별
    2. T2 1번룸 "S/D #1 자동화" 라벨 중복 표시 진단 — 4 머신 SO 동일 식별자(`_tableName=t2_room01_port2, _tag=20`) 원인 확정 → 데이터 측 처리 완료
    3. RoomPage datalabel pivot 동적 적용 — `UI_RoomTopPopup.cs`, visibleIndex 기준 (0.5,1) / (0.5,0) 분기
    4. 장비 순서 정렬 — Hierarchy 자식 순서 그대로 반영 확인, 코드 변경 없이 재배열로 해결
    5. 장비 마우스 오버 highlight — `UI_RoomTopPopup.cs` + `UIController.cs` + `MicoRoom.cs` 3파일 변경, MachineSO.GetAllMachines로 부모+SubMachines 매칭
- stale work 지시서 정리 — `.claude/work/mico/IW-209.md`, `.claude/work/mu/IW-228.md` 삭제 (둘 다 서동주 담당 + 4/17 완료)

## 내일 이어갈 작업 (2026-05-05)
- IW-439 부수 이슈 2건 — fold 잔상 fix의 후속:
  - API 실패 시 fold 버튼 영구 무반응
  - race condition 처리
- IW-438 4월 마무리 잔여 — 추가 하위 작업 식별 필요

## ACTIVE_TASK
- IW-439 (UI 수정 및 변경작업, 진행 중)

## 참고
- 본인 담당 work 지시서 현황: `Demo/IW-187.md`, `Analyzer/nazare-analyzer.md`, `mico/IW-438.md`(신규)
- IW-254 묶음(IW-343/344/345) mico-3d 프로젝트에서 4/30 종료
- 글로벌 CLAUDE.md 다중 PC 동기화: `shared/global-CLAUDE.md` symlink 방식 (4/30 세팅)
