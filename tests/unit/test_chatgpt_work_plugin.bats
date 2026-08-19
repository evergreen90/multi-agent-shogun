#!/usr/bin/env bats
# Contract tests for the ChatGPT Work plugin and live council behavior.

PROJECT_ROOT="$(cd "$(dirname "$BATS_TEST_FILENAME")/../.." && pwd)"
PLUGIN_ROOT="$PROJECT_ROOT/plugins/multi-agent-shogun"
SKILL_FILE="$PLUGIN_ROOT/skills/run-shogun-work/SKILL.md"
WORK_GUIDE="$PROJECT_ROOT/CHATGPT_WORK.md"

@test "ChatGPT Work plugin metadata is version 0.2.0 and valid JSON" {
    run python3 - "$PLUGIN_ROOT/.codex-plugin/plugin.json" <<'PY'
import json
import pathlib
import sys

data = json.loads(pathlib.Path(sys.argv[1]).read_text(encoding="utf-8"))
assert data["version"] == "0.2.0"
assert "Live council updates" in data["interface"]["capabilities"]
PY
    [ "$status" -eq 0 ]
}

@test "skill limits live council output to observed agent events" {
    grep -q "After successful spawning" "$SKILL_FILE"
    grep -q "received report" "$SKILL_FILE"
    grep -q "send the instruction first" "$SKILL_FILE"
    grep -q "failure, or completion" "$SKILL_FILE"
    grep -q "not as verbatim transcripts" "$SKILL_FILE"
}

@test "skill protects sensitive data and keeps the final answer independent" {
    grep -q "hidden reasoning" "$SKILL_FILE"
    grep -q "secrets, credentials" "$SKILL_FILE"
    grep -q "final answer self-contained" "$SKILL_FILE"
    grep -q "single-agent task" "$SKILL_FILE"
}

@test "guide documents live council modes and UI limitations" {
    grep -q "## 軍議実況" "$WORK_GUIDE"
    grep -q "実況なし" "$WORK_GUIDE"
    grep -q "オリジナル風に詳しく" "$WORK_GUIDE"
    grep -q "複数ペイン表示" "$WORK_GUIDE"
    grep -q "内部の思考過程" "$WORK_GUIDE"
}
