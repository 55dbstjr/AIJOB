# Plane 조회 규칙

> 매일 출근 시 Plane 티켓을 빠르게 조회하기 위한 규칙. 서브에이전트 경유·중복 API 호출 금지.

## 공통 원칙
- 서브에이전트로 분석하지 말 것 (2-3분 소요되어 너무 느림)
- 같은 목적으로 API를 여러 번 호출하지 말 것 (expand 실패 시 재호출 금지 — 아래 경로별 규칙 따를 것)
- 본인 담당 필터: assignee ID `2106b5c3-0adc-495f-99a8-3ff5683a6a07`
- 미완료 필터: `state.group`이 `completed`/`cancelled`가 아닌 것

## MCP `list_work_items` 경로

1. `list_work_items(project_id, expand="state", per_page=100)` — 한 번에 가져오기
2. 결과가 파일로 저장되면 jq로 직접 필터링:
   ```
   jq '[.result[]
     | select(.assignees[]?.id == "2106b5c3-0adc-495f-99a8-3ff5683a6a07")
     | select(.state.group != "completed" and .state.group != "cancelled")
     | {id: "IW-\(.sequence_id)", name, state: .state.name, group: .state.group, priority}]
     | sort_by(.group)'
   ```
3. `assignees`가 객체 배열이면 `.assignees[]?.id`, 문자열 배열이면 `.assignees[]?`로 비교
4. state 정보는 `.state` (MCP 경로는 `.state`)
5. advanced search (필터 파라미터) 사용 시 403 발생 — 사용하지 말 것
6. `expand`에 `assignees` 넣으면 응답이 2배 커짐 → `expand=state`만으로 충분 (assignees는 UUID 배열로 비교)

## curl REST API 경로 (`$PLANE_BASE_URL/api/v1/.../issues/`)

1. **`expand=state`가 동작하지 않음** — `state_detail`/`.state` 객체가 `null`로 옴 (ingle-work 인스턴스 확인, 2026-04-22)
2. 대신 `states/` 엔드포인트로 state ID → 이름 매핑을 한 번 받아두고, issues의 `.state` UUID로 직접 조인할 것
3. 순서: `states/` 1회 + `issues/?per_page=100` 1회 = **총 2회**. expand로 재시도하지 말 것
4. 상태 매핑 (ingle-work, IW 프로젝트):
   - `backlog` → "해야 할 일"
   - `unstarted` → "준비 완료"
   - `started` → "진행 중" / "검토"
   - `completed` → "완료"
   - `cancelled` → "취소"

### 예시 명령
```bash
PROJ=f07efb90-a9fa-4605-bcdc-99708ba07069

# 1. states 매핑
curl -s -H "X-API-Key: $PLANE_API_KEY" \
  "$PLANE_BASE_URL/api/v1/workspaces/$PLANE_WORKSPACE_SLUG/projects/$PROJ/states/" \
  | jq -r '.results[] | "\(.id)\t\(.name)\t\(.group)"'

# 2. issues (state UUID로 조인)
curl -s -H "X-API-Key: $PLANE_API_KEY" \
  "$PLANE_BASE_URL/api/v1/workspaces/$PLANE_WORKSPACE_SLUG/projects/$PROJ/issues/?per_page=100" \
  | jq -r '.results[] | "IW-\(.sequence_id)\t\(.state)\t\(.name)"'
```
