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

## 글로벌 CLAUDE.md 공유 (여러 PC 동기화)

`~/.claude/CLAUDE.md`(글로벌 규칙)는 PC마다 따로 존재하지만, AIJOB 레포의 `shared/global-CLAUDE.md`를 원본으로 두고 symlink로 연결해 git 한 번에 동기화한다.

### 새 PC에서 1회 셋업

**전제조건:** AIJOB 레포 clone 완료, Windows 11 기준.

1. **개발자 모드 ON** — 설정 → 개인 정보 및 보안 → 개발자용 → "개발자 모드" 토글 ON
   - 또는 검색창에 "개발자용 설정" 입력
   - 회사 PC라 그룹 정책으로 막혀있으면 관리자 권한 PowerShell로 진행 가능

2. **관리자 권한 PowerShell** 실행 (시작 메뉴 → PowerShell 우클릭 → "관리자 권한으로 실행")

3. 기존 `~/.claude/CLAUDE.md`가 있으면 백업 후 삭제:
   ```powershell
   if (Test-Path "$env:USERPROFILE\.claude\CLAUDE.md") {
     Copy-Item "$env:USERPROFILE\.claude\CLAUDE.md" "$env:USERPROFILE\.claude\CLAUDE.md.bak"
     Remove-Item "$env:USERPROFILE\.claude\CLAUDE.md" -Force
   }
   ```

4. symlink 생성 (AIJOB clone 경로는 본인 환경에 맞게 조정):
   ```powershell
   New-Item -ItemType SymbolicLink `
     -Path "$env:USERPROFILE\.claude\CLAUDE.md" `
     -Target "$env:USERPROFILE\gitproj\dev_AIJOB\shared\global-CLAUDE.md"
   ```

5. 검증 — `Mode` 컬럼에 `l` 표시 + Target 경로가 보이면 정상:
   ```powershell
   Get-Item "$env:USERPROFILE\.claude\CLAUDE.md" | Select-Object Mode, Name, Target
   ```

### 동작 방식
- 한 PC에서 `shared/global-CLAUDE.md` 수정 → `git push`
- 다른 PC에서 `git pull` → 즉시 적용 (symlink가 최신 내용을 자동으로 가리킴)
- 일반 사용자 권한으로는 symlink 생성이 막히므로 **반드시 관리자 권한 PowerShell** 사용
- 일반 사용자 권한 PowerShell에서 개발자 모드만으로 가능한 환경도 있으나, 그룹 정책에 따라 차단되는 경우가 많음
