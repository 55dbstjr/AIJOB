# Nazare Analyzer — 스토리 초안 (생성 대기)

> 1차 작업 완료 상태. 추가 이슈 발생 시 티켓 생성 예정.

## 배경
공장 PLC/센서 데이터를 산업 프로토콜(OPC UA, Modbus, MQTT 등)로 실시간 수집하여 시계열 차트로 시각화하는 Unity 기반 SCADA 트렌드 뷰어 & 데이터 로거.

## 범위
- 14개 DataSource 프로토콜 수집 (OPC UA, Modbus, MQTT, MC Protocol 등)
- 시계열 데이터 선형/디지털 차트 시각화
- Historian 이력 조회 (청크 기반, 최대 6개월)
- NazareDb Arrow 기반 시계열 DB 연동
- 알려진 치명적 버그 수정 (OPC UA async void 크래시, Modbus 엔디안, NaN 필터링)

## 알려진 버그 (CLAUDE.md 기준)
- OPC UA: async void 크래시, bool.Parse 타입 불일치, 타임아웃 미지원
- Modbus: 32비트 엔디안 처리 불충분, int64 변환 버그, FC04 미지원
- 공통: NaN/Infinity 미필터링으로 그래프 미출력

## 참고
- Git: ingkle/nazare-analyzer (NazareAnalyzer/ 메인 프로젝트)
- 기술 스택: Unity 6000.0.42f1, C#, OPC UA, Modbus, MQTT, Apache Arrow
- Avalonia 리라이트 초기 프로토타입 존재 (NazareAnalyzer.Avalonia/)
- 에픽: IW-174로 요청 중
