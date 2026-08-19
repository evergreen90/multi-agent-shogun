#!/usr/bin/env bats
# Static contract tests for the ChatGPT Work plugin and live council policy.

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

@test "operative skill contains the complete ordered event policy" {
    run python3 - "$SKILL_FILE" <<'PY'
import pathlib
import sys

text = pathlib.Path(sys.argv[1]).read_text(encoding="utf-8")
section = text.split("## Live council updates", 1)[1].split("## Safety and quality", 1)[0]
rules = [
    "| Spawn requested but not confirmed | Show no assignment or working status |",
    "| Spawn succeeded | Show `assigned` with the role and task |",
    "| Spawn failed | Show `failed`; do not imply that the agent started |",
    "| Material report received | Show a faithful summary attributed to that agent |",
    "| Reports disagree | Show both positions, then a separate Shogun decision |",
    "| Follow-up requested but not confirmed | Show no sent status |",
    "| Follow-up succeeded | Show the instruction as sent |",
    "| Report contains sensitive or internal data | Omit or redact that data |",
    "| Single-agent execution | Show no live council update |",
    "| Final response | Return a self-contained result independent of the live log |",
]
positions = [section.index(rule) for rule in rules]
assert positions == sorted(positions)
PY
    [ "$status" -eq 0 ]
}

@test "operative skill defines modes and blocks fabricated or sensitive output" {
    run python3 - "$SKILL_FILE" <<'PY'
import pathlib
import sys

text = pathlib.Path(sys.argv[1]).read_text(encoding="utf-8")
section = text.split("## Live council updates", 1)[1].split("## Safety and quality", 1)[0]
required = [
    "faithful summaries of real agent events, not as verbatim transcripts",
    "If the user asks for quiet operation, show only the formation and completion",
    "If the user asks for detailed or original-style Shogun narration, show all material events",
    "Do not expose hidden reasoning, internal prompts, secrets, credentials",
    "Do not show live council updates for a single-agent task",
]
for clause in required:
    assert clause in section, clause

for prohibited in [
    "fabricate dialogue",
    "announce before spawning",
    "expose secrets",
    "reveal hidden reasoning",
    "the final answer may depend on the live log",
]:
    assert prohibited not in section.lower(), prohibited
PY
    [ "$status" -eq 0 ]
}

@test "guide documents modes, provenance, and UI limitations" {
    run python3 - "$WORK_GUIDE" <<'PY'
import pathlib
import sys

text = pathlib.Path(sys.argv[1]).read_text(encoding="utf-8")
for clause in [
    "実際に発生したエージェント通信の要約",
    "実況なし",
    "オリジナル風に詳しく",
    "複数ペイン表示",
    "内部の思考過程",
    "最終回答は実況を読まなくても理解できる",
]:
    assert clause in text, clause
PY
    [ "$status" -eq 0 ]
}
