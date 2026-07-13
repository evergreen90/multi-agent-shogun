# Multi-Agent Shogun for ChatGPT Work

This repository supports two execution modes:

- **CLI mode**: the original tmux and YAML-mailbox formation.
- **ChatGPT Work mode**: one lead agent coordinates up to three native subagents and integrates their results.

ChatGPT Work mode does not emulate tmux or launch additional Claude, Codex, or Copilot CLI processes. It uses the platform's native subagent workflow, so agent activity remains visible in ChatGPT Work and does not require local background processes.

## Install

Install this repository as a plugin in ChatGPT Work or Codex using its GitHub repository URL:

`https://github.com/evergreen90/multi-agent-shogun`

The plugin manifest is `.codex-plugin/plugin.json`. The bundled skill is `run-shogun-work`.

Plugin installation and sharing can be controlled by workspace policy. If the repository cannot be installed, ask the workspace administrator to allow the plugin or share it with the workspace.

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
python3 /path/to/plugin-creator/scripts/validate_plugin.py .
python3 /path/to/skill-creator/scripts/quick_validate.py skills/run-shogun-work
```
