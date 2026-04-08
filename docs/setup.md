# 환경 세팅 가이드

## 사전 요구사항
- Claude Code (`npm install -g @anthropic-ai/claude-code`)
- Git + GitHub CLI

## Jira MCP 인증 구조

```
각 프로젝트/.mcp.json   ← 인증 정보 포함 (.gitignore 대상)
```

- `.mcp.json`에 사이트명, 이메일, API 토큰을 직접 넣는다
- **`.mcp.json`은 반드시 `.gitignore`에 추가** — 토큰이 포함되어 있으므로 커밋 금지
- 토큰 변경 시 각 프로젝트의 `.mcp.json`을 모두 업데이트해야 함

## 새 PC 세팅 절차

1. `Dev_AIJOB` 레포를 clone한다.

2. `~/.bashrc`에 아래를 추가한다.
```bash
# AIJOB
export AIJOB_ROOT="$HOME/gitproj/Dev_AIJOB"  # ← 실제 clone 경로로 변경
```

3. Jira를 사용할 프로젝트 루트에 `.mcp.json`을 넣는다.
```json
{
  "mcpServers": {
    "jira": {
      "command": "cmd",
      "args": ["/c", "npx", "-y", "@aashari/mcp-server-atlassian-jira"],
      "env": {
        "ATLASSIAN_SITE_NAME": "ingkle",
        "ATLASSIAN_USER_EMAIL": "younseok.oh@ingkle.com",
        "ATLASSIAN_API_TOKEN": "<본인 Jira API 토큰>"
      }
    }
  }
}
```

4. 각 프로젝트의 `.gitignore`에 `.mcp.json`을 추가한다.

5. 터미널을 새로 열고 `claude`를 실행하면 Jira 연동 정상 동작.

토큰 발급: `https://id.atlassian.com/manage-profile/security/api-tokens`

## 현재 적용된 프로젝트
`Dev_AIJOB`, `mico-3d`, `mu`, `Demo`, `nazare-analyzer`
