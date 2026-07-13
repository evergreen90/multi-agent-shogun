# Multi-Agent Shogun for ChatGPT Work

This repository supports two execution modes:

- **CLI mode**: the original tmux and YAML-mailbox formation.
- **ChatGPT Work mode**: one lead agent coordinates up to three native subagents and integrates their results.

ChatGPT Work mode does not emulate tmux or launch additional Claude, Codex, or Copilot CLI processes. It uses the platform's native subagent workflow, so agent activity remains visible in ChatGPT Work and does not require local background processes.

## Install

The repository includes a repo-scoped marketplace at `.agents/plugins/marketplace.json`. Its plugin package lives at `plugins/multi-agent-shogun/` and bundles the `run-shogun-work` skill.

### ChatGPT desktop app (Work or Codex)

1. Clone or open this repository as a project.
2. Restart the ChatGPT desktop app so it discovers the repo marketplace.
3. Open the plugin directory and select the **Multi-Agent Shogun** marketplace.
4. Open **Multi-Agent Shogun**, select the plus button to install it, and start a new task.

### ChatGPT Work on the web

A local repo marketplace is not automatically published to the web plugin directory. A workspace administrator must distribute the plugin through an approved marketplace or workspace policy, or the plugin must be submitted for publication. After it is available in the plugin directory, install it there and start a new task.

See the official OpenAI documentation for [building plugins](https://developers.openai.com/codex/build-plugins), [installing plugins](https://developers.openai.com/codex/plugins), and [using subagents](https://developers.openai.com/codex/subagents).

## Use

Invoke the skill explicitly when you want predictable delegation:

> Use $run-shogun-work to investigate this issue, implement the fix, and have another agent review it.

Other examples:

- “Use the Shogun formation to compare these policy options using primary sources.”
- “Delegate code exploration, implementation, and testing to separate agents.”
- “Use three agents to analyze these documents, then return one reconciled report.”

The skill can also activate implicitly for requests that explicitly ask for Multi-Agent Shogun, subagents, delegation, or parallel agent work.

## Differences from CLI mode

| Area | CLI mode | ChatGPT Work mode |
|---|---|---|
| Runtime | tmux plus multiple AI CLIs | Native ChatGPT Work subagents |
| Formation | Shogun, Karo, 7 Ashigaru, Gunshi | Lead Shogun/Karo plus up to 3 subagents |
| Coordination | YAML queues and inbox files | Native agent threads and messages |
| Persistence | tmux sessions and repository files | Current Work task and saved artifacts |
| Setup | Shell scripts and CLI authentication | Install plugin and invoke the skill |

The Work formation deliberately combines Shogun and Karo in the lead agent. With a four-agent capacity, a separate manager would consume a slot without adding execution capacity.

## Verification

Validate the package with the built-in plugin and skill validators before publishing changes:

```bash
python3 /path/to/plugin-creator/scripts/validate_plugin.py plugins/multi-agent-shogun
python3 /path/to/skill-creator/scripts/quick_validate.py plugins/multi-agent-shogun/skills/run-shogun-work
```
