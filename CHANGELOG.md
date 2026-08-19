# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased]

### Added
- **ChatGPT Work plugin 0.2.0**: concise live council updates that relay confirmed delegation, material reports, disagreements, re-steering, failures, and completion from native subagents
- Contract tests for event-grounded narration, sensitive-data safeguards, quiet/detailed modes, and documented UI limitations

### Changed
- ChatGPT Work skill and plugin metadata now distinguish faithful event summaries from verbatim transcripts and keep final answers self-contained

## [5.2.0] - 2026-06-06

### Added
- **Cursor Agent CLI** support as 6th CLI (`type: cursor`): `cursor-agent --yolo` launch, `/new-chat` context reset, busy detection via `ctrl+c to stop` marker, generated instructions for all 4 roles, `.cursor/skills/inbox-write/` skill (PR #155)
- **Antigravity CLI** support as 7th CLI (`type: antigravity`): `agy --dangerously-skip-permissions` launch, `gemini`/`agy` legacy alias normalization, tests for cli_adapter/switch_cli/build_system/send_wakeup (PR #154)

### Fixed
- `scripts/watcher_supervisor.sh`: prevent duplicate `inbox_watcher.sh` startup via per-agent `flock -n` — eliminates TOCTOU race on supervisor restart (closes #159)
- `.claude/settings.json`: stop hook path changed from hardcoded absolute to relative `bash scripts/stop_hook_inbox.sh` — works on any clone path (PR #161, closes #160)
- `instructions/karo.md`, `instructions/roles/karo_role.md`: removed hardcoded `/home/tono/` and `/mnt/c/tools/multi-agent-shogun/` paths; regenerated all CLI-specific instruction files
- `scripts/seo_qc.py`: replaced hardcoded `/home/yohei/seo-affiliate` with `Path.home() / "seo-affiliate"`

### Tests
- Added `tests/unit/test_watcher_supervisor.bats` — 4 tests for flock-based duplicate prevention

## [5.1.0] - 2026-05-23

### Changed
- Clarified Karo as a workflow traffic controller instead of an execution bottleneck
- Moved qualitative review ownership to Gunshi for QC, evidence review, RCA, adoption/drop decisions, and deploy blocker classification
- Reframed E2E ownership: Karo reviews the plan, checks prerequisites, and makes the final pass/fail decision while execution is delegated by default
- Regenerated Claude, Codex, Copilot, Kimi, and OpenCode instruction files from the updated role definitions

### Fixed
- Prevented old instructions from implying that Karo should directly run E2E commands or perform review work by default
- Added Android local cache/toolchain ignore entries for `.android-user/`, `.gradle-user/`, and `.toolchain/`

## [5.0.0] - 2026-05-21

### Added
- OpenCode first-class CLI support across Shogun, Karo, Ashigaru 1-7, and Gunshi
- Generated `.opencode/agents/*.md` agent definitions from the shared instruction build system
- `instructions/cli_specific/opencode_tools.md` for OpenCode-specific operational rules
- `config/opencode-permissions.yaml` to generate role-scoped OpenCode permission frontmatter
- `config/opencode-tui.json` to pin tmux-safe OpenCode keybindings
- Provider-qualified OpenCode model routing, including OpenCode free models and OpenRouter models
- OpenCode startup E2E coverage and build checks for generated agent files

### Changed
- `lib/cli_adapter.sh` can launch OpenCode with `--agent <agent_id>` and `OPENCODE_TUI_CONFIG`
- `scripts/build_instructions.sh` now checks generated instruction files and OpenCode agent files together
- README and README_ja document OpenCode setup, model IDs, generated agents, and VPS validation

### Fixed
- macOS CI now runs `scripts/slim_yaml.py` through the project venv so PyYAML is available
- `tests/unit/test_slim_yaml.bats` uses the same venv-backed Python path as CI
- `tests/unit/test_ntfy_ack.bats` failure injection is UID-independent, so root-based VPS test runs behave the same as normal CI users

### Verified
- Multi-CLI Test Suite on `main`: Ubuntu unit, macOS unit, shellcheck, build check, E2E mock CLI, and integration tests all PASS
- VPS smoke test with all agents launched as OpenCode confirmed Shogun → Karo → `dashboard.md` execution

## [4.6.0] - 2026-04-19

### Added
- `shutsujin_departure.sh`: `--auto-mode-on` flag (maps to `--dangerously-skip-permissions`) and `--permission-mode <mode>` for custom permission flags (Issue #124)
- `lib/cli_adapter.sh`: accept `PERMISSION_FLAG` override from departure script, backward-compatible

### Fixed
- Report flow unified to `Ashigaru → Gunshi → Karo` across all instruction files (`instructions/ashigaru.md`, `karo.md`, `gunshi.md`, `CLAUDE.md`, all generated CLI variants) (Issue #121)

### Changed
- `PERMISSION_FLAG` variable centralizes permission handling in `shutsujin_departure.sh` (10 call sites)
- `tests/unit/test_cli_adapter.bats`: additional coverage for permission flag logic

## [4.5.0] - 2026-04-19

### Added
- `scripts/dashboard-viewer.py`: live Markdown viewer for `dashboard.md` via `dash` command (PR #122)
- `first_setup.sh`: auto-register `dash()` function to `.bashrc` on setup
- GitHub Sponsors section to README and README_ja

### Fixed
- `scripts/inbox_write.sh`: self-send guard — prevent agents from messaging themselves (PR #116)
- README quick start: missing `source ~/.bashrc` and `claude --dangerously-skip-permissions` steps (Issue #120)

### Changed
- `tests/test_inbox_write.bats`: updated for mandatory `type`/`from` arguments

## [4.4.2] - 2026-04-10

### Added
- `first_setup.sh`: auto-install OSS skills to `~/.claude/skills/` on setup (skips existing, idempotent)

## [4.4.1] - 2026-03-28

### Added
- Android: Raw/UI toggle in ratelimit dialog for debugging SSH output
- Android: SSH key file picker in settings (load private key from device storage)
- Android: parse failure fallback — show raw output when no data parsed
- `ratelimit_check.sh`: zoom-capture for Codex /status blocks (fixes narrow pane truncation)

### Fixed
- Android: ratelimit display not working (stderr not captured, missing 2>&1)
- Android: SSH private key loading (read file bytes instead of path reference)
- `ratelimit_check.sh`: extract latest /status block with awk parser to avoid stale data

### Changed
- SshManager: capture stderr + log for diagnostics
- AgentsViewModel: show executed command in SSH error messages

## [4.4.0] - 2026-03-28

### Added
- karo daily log: cmd完了時に `logs/daily/YYYY-MM-DD.md` へサマリーを自動追記する機能を導入 (PR #95)
- `.gitignore`: `.claude/settings.local.json` を除外対象に追加

### Changed
- `instructions/karo.md`: ntfy通知ステップを6→7に移動、daily log appendをステップ6に挿入
- `instructions/roles/karo_role.md`: 同期済み
- 全CLI向け generated instructions を再生成（codex/copilot/kimi-karo.md）

## [4.3.0] - 2026-03-28

### Added
- `shutsujin_departure.sh`: all Claude Code agents now launch with `--effort max` by default (shogun, karo, ashigaru, gunshi)

## [4.2.0] - 2026-03-24

### Added
- `install.bat`: dynamically resolve WSL `$HOME` via `wsl -e bash -c "echo $HOME"` so instructions work on any username/PC
- `shutsujin_departure.sh`: `csst` alias now uses `$HOME/multi-agent-shogun` instead of hardcoded path

### Changed
- `install.bat`: repository reference updated from `feature-shogun` to `multi-agent-shogun`
- `config/settings.yaml`: `skills/logs/images` paths changed to relative `./` paths for portability
- `scripts/backup_daily.sh`: cron example uses `$HOME`-based path
- Regenerated `AGENTS.md` and `copilot-instructions.md` (bloom_routing_rule + Post-Compaction Recovery section)

### Fixed
- `inbox_write.sh`: removed `xxd` dependency (CI compatibility)
- `tests/unit/test_idle_flag.bats`: updated T-008 to match v4.0.1 idle flag design (preserve not delete)