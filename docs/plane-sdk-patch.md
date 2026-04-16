# Plane Python SDK 패치 기록

## 대상
- **패키지**: `plane-sdk` v0.2.8 (`plane-mcp-server` 0.2.8 의존)
- **파일**: `plane/models/work_items.py` (line 56-57)

## 증상
`retrieve_work_item_by_identifier` 호출 시 Pydantic 검증 에러:
```
assignees.0 — Input should be a valid dictionary or instance of UserLite, got str
labels.0 — Input should be a valid dictionary or instance of Label, got str
```
Plane API가 expand 없이 호출 시 UUID 문자열 배열을 반환하는데, `WorkItemDetail` 모델이 객체만 허용하여 검증 실패.

## 수정 내용
`WorkItemDetail` 클래스의 타입 힌트를 원소 단위 Union으로 변경 + import 추가:

```python
# import 추가 (line 1)
from typing import TYPE_CHECKING, Any, Union  # Union 추가

# 변경 전 (line 56-57)
assignees: list[UserLite]
labels: list[Label]

# 변경 후
assignees: list[Union[str, UserLite]]
labels: list[Union[str, Label]]
```

> `list[str] | list[UserLite]`는 Pydantic v2에서 list 전체 타입 매칭을 시도하므로 실패할 수 있음.
> `list[Union[str, UserLite]]`는 각 원소별로 str 또는 UserLite를 허용하므로 안전.

## 패치 적용 위치 (uvx 캐시)
```
%LOCALAPPDATA%\uv\cache\archive-v0\<hash>\Lib\site-packages\plane\models\work_items.py
%LOCALAPPDATA%\uv\cache\archive-v0\<hash>\plane\models\work_items.py
```

해시는 `uv cache` 재생성 시 변경됨. 아래 명령으로 파일 위치 재탐색:
```bash
find "$LOCALAPPDATA/uv/cache/archive-v0" -path "*/plane/models/work_items.py"
```

## 재적용 스크립트
```bash
# 패치 대상 파일 찾기 & 일괄 수정
find "$LOCALAPPDATA/uv/cache/archive-v0" -path "*/plane/models/work_items.py" \
  -exec sed -i 's/from typing import TYPE_CHECKING, Any$/from typing import TYPE_CHECKING, Any, Union/' {} \; \
  -exec sed -i 's/assignees: list\[UserLite\]/assignees: list[Union[str, UserLite]]/' {} \; \
  -exec sed -i 's/labels: list\[Label\]$/labels: list[Union[str, Label]]/' {} \;

# pyc 캐시 삭제
find "$LOCALAPPDATA/uv/cache/archive-v0" -name "work_items.cpython*.pyc" -path "*/plane/*" -delete
```

## 비고
- SDK 업데이트 또는 `uv cache clean` 시 패치 소실 — 재적용 필요
- 근본 해결: `makeplane/plane-python-sdk` 에 PR 제출
