# STATE — 현재 작업 상태

> 최종 업데이트: 2026-04-27

## 오늘 완료/진척
- IW-345 시뮬 5종 CSV 가드 위반 0건 달성 (mico-3d 커밋 f69c04e)
  - `UIMaterialRenderer.cs` 갭 보정 코드 통째 제거
  - `UI_MCTMaterial.cs` / `UI_Room_MCTMaterial.cs` 조기 continue 분기 `_drawSkippedByGuard=true` 토글 추가
  - SigSTL 0→1 전환 시 2D/3D 초기화 보강 (사이클 잔상 제거)
- IW-345 부수 작업 — Fanuc 좌표 통합 문자열 폴백 파싱
  - `MQTT_MCT_Manager` 매니저 단 정규화 + `FanucMctDataParserSO` 파서 단 폴백
  - 일부 장비의 `"X -1890|Y 87301|Z -879"` 통합 문자열 + NULL 꼬리 처리
- 인계 문서 작성: `docs/mu-port-mct-line-fixes.md`, `docs/mu-port-mqtt-pos-parser.md`
- IW-345 #3 HW16MM-BAC 대각선: 신호로 못 잡는 케이스로 분류 (별도 이슈 분리 예정, 거리 임계값 휴리스틱은 false positive 위험으로 보류)
- IW-343 / IW-344: 미착수 (오늘 mico-3d 작업이 IW-345 묶음으로 흡수됨)

## 내일 이어갈 작업 (2026-04-28)
- IW-345 Unity Editor 실 검증 (PLT/HW16MM/SHBT/OR22MM 5종)
- SigSTL 0→1 초기화 실 환경 검증 (잔상 미이월)
- 박아둔 `[P1-DEBUG]` 디버그 로그 정리
- 회귀 테스트 — `FinalizeToEndPosition`만으로 cancel-restart 끊김 보정 충분한지
- IW-343 / IW-344 착수 (검증 마무리 후)

## ACTIVE_TASK
- IW-345 Unity 실 검증부터 시작

## 참고
- IW-254 묶음(IW-343/344/345)은 mico-3d 프로젝트에서 작업 중 (mu 세션 아님)
- mico-3d 메모리에 fix 상세 보존: `project_mct_phantom_diagonal_p1.md`, `feedback_data_guard_absolute.md`, `project_mct_cut_signal_unreliable.md`
