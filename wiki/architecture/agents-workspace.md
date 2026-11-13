---
id: AS-ARCH-AGENTS-WORKSPACE
kind: architecture
title: Agents workspace and configuration boundaries
summary: "The proposed agents monorepo: skills at the root as today, public harness defaults under configs/, a private overlay in Groundwork's agent-config repository with the stricter value winning for sandbox settings, Rust from AG1, and proof gates AG1 to AG3."
status: proposed
created: 2026-11-12
updated: 2026-11-13  # the rename done; before that, after the independent review and the owner's choices: skills stay at the root; the package map trimmed to skills, configs, crates and wiki; defaults and overlay with the stricter-wins rule; proof steps AG1 to AG3
derived_from: AS-ADR-0001
related: [AS-ADR-0001, AS-RES-AGENTS-LINEAGE, AS-PROGRAM, AS-ARCH-GUEST-INSTALL, WS-ADR-0004, WS-ARCH-CONTRACTS, GW-ADR-0011, GW-ADR-0016]
---

# Agents workspace and configuration boundaries

The [decision](../records/decisions/0001-agents-monorepo.md) records what the owner decided. This page proposes how to build it; [STATE](../records/STATE.md) holds delivery status. Today's skill paths and installation are in [skill sources](skill-sources.md) and [guest install](guest-install.md).

## Layout

| Location | Holds | Boundary |
| --- | --- | --- |
| `skills/` (root, as today) | The skills package: one module per folder, `skills/<name>/SKILL.md`, with `references/` and `CREDITS.md` ([module shape](../program.md#the-module-shape)) | The skills CLI finds it without a deep search. No Cargo or Moon needed to read or install it |
| `configs/<harness>/` | Public defaults for one harness, in its own file formats: a user-level instructions file first (AG2), generic settings and a sandbox baseline later (AG3) | No secrets, hostnames or personal paths. A README per harness lists the supported keys, which ones are policy keys, and the evidence for each |
| `crates/` | From AG1: the validator that replaces `scripts/check.sh`; a composer only if AG2 or AG3 needs one | A Cargo workspace with its own lockfile; Moon runs its tasks |
| `.moon/`, `.prototools` | From AG1: tasks and tool pins | Needs Moon's guest admission extended to this repository (GW-ADR-0016 covers Workstation only) |
| `wiki/` | Agents-specific knowledge, decisions, compatibility evidence and source lineage | Current owning contracts outrank historical descriptions |

A directory is created when it has content, not ahead of time. Not planned:

- **`providers/` and `adapters/`.** What a provider supports is recorded in the harness README that uses it, with evidence. A separate description package would copy native state that goes stale.
- **Session backends** (herdr, tmux, TUIOS). Their settings belong to Workbench, behind its adapter contract (WS-ADR-0004 decision 9); the [`multiplex`](../program.md#m3-multiplex) module describes how agents use them.
- **A `tools/` package.** A reusable tool gets its own directory when one exists. A module that needs a tool checks for it and never installs it.

## Who interprets which configuration

| Concern | Interpreter and authority |
| --- | --- |
| Tools and harnesses selected for observation | `ws`, using its small profile contract |
| Environment provisioning and admitted tool sets | Groundwork and Workbench's setup procedures |
| Guest session backend and daily-use settings | Workbench, under its reviewed interfaces |
| Public agent config defaults | This repository (`configs/`) |
| Private agent config overlay | Groundwork's agent-config repository ([GW-ADR-0011](https://github.com/luckgrid/workstation/blob/main/wiki/groundwork/records/decisions/0011-agent-harnesses-and-subscription-logins.md), private), pinned to a commit |
| The guest's installed harness settings, sandbox and deny rules included | Workbench's stage C, combining the two pinned sources (amendment proposed, not made); gate A2 checks the result |
| Effective model settings, sessions and authentication | The native harness and provider |
| Credentials, containment and network policy | OS, VM, credentials and provider policy |
| Workflow execution, queues and continuity | An independently chosen runtime, or Workflow Factory if adopted |

"Profile" already names `ws` profiles, Groundwork's environment profiles and GW-ADR-0011's agent layer, so this repository says "config defaults" instead.

## Defaults and overlay

The owner chose public defaults here with a private overlay ([AS-ADR-0001](../records/decisions/0001-agents-monorepo.md), decisions 5 and 6). Proposed composition:

1. **Two pinned layers.** The defaults at a pinned commit of this repository, then the overlay at a pinned commit of agent-config. Flags and environment variables don't change the composed files, so the same two commits always give the same result. WS-ADR-0004's broader precedence ([decision 4](https://github.com/luckgrid/workstation/blob/main/wiki/records/decisions/0004-profiles-private-sources-and-secret-references.md)) is adopted only through Workstation's W4.
2. **Ordinary keys:** the overlay's value replaces the default.
3. **Policy keys** (sandbox mode, deny rules, permission rules, as each harness README lists them): the stricter value wins. Deny lists combine. A mode can only move to a stricter one. An overlay entry that would loosen a default is refused unless a recorded exception names the key, the value, the reason and the owner's approval with its date. A policy key without a defined order of strictness keeps the default.
4. **User scope only.** Composition writes the harness's user-level files. Project, local and managed settings keep their native precedence, and a project's own rules are never replaced.
5. **Visible and owned.** The composer shows a diff before writing, records both source commits in the result, reports keys the harness doesn't support, and doesn't overwrite a file the user has edited. Instruction text is never described as enforcement.

Configuration holds references to secrets, never secrets. Secret backends, scopes and reachability belong to each environment; fnox is Workstation's first evaluation candidate, not a dependency here. A missing required value is reported by its reference.

## Installer and Rust

Skills stay at `skills/`, so the installer path doesn't change. Workbench's U16 step and its tests against skills CLI 1.7.6 remain the baseline; a CLI pin change is Workbench's to review. Telemetry stays off as the install procedure requires.

Rust starts at AG1 with a concrete job: replacing `check.sh`. Cargo owns Rust builds and dependencies; Moon runs the checks. Skill users need neither. Any new dependency, tool pin or install command follows the owning environment's admission procedure.

## Steps and proof gates

1. **This documentation.** The decision, this design and the lineage, with Workstation's matching note.
2. **Rename** to `luckgrid/agents`: done by the owner on 2026-11-13, after this design's PR merged. Workstation's PR updates `wb sync`, U16's clone path (`~/Workspaces/agents`), GW-ADR-0014 decision 1 and its current pages. U16's export folder and the `agent_skills_commit` lock key keep their names, because `~/.local/share/lg-workbench/agents` already holds the guest harnesses' npm packages.
3. **M0 and M2**, as the [roadmap](../program.md) sets them (M7 is done; M1 moved to Workstation on 2026-11-13). M0 is unchanged by this design.
4. **AG1, after M2: the Rust validator.** It makes the same checks as M0's `check.sh`, which it replaces, with the same output for the same tree. Moon and its pins arrive with an admission note extending GW-ADR-0016 to this repository.
5. **AG2: one shared default, two harnesses.** User-level instructions for Claude Code and Codex in `configs/claude-code/` and `configs/codex/`, each in the file its harness documents for user-level instructions (confirmed from each harness's documentation at the installed version, not assumed). Proved in the guest: both harnesses load the text, the diff and source commit are shown, and a user edit isn't overwritten. No settings or policy keys yet.
6. **AG3: settings with the overlay.** Generic settings and a sandbox baseline in `configs/`, the agent-config overlay, and composition with the stricter-wins rule. Needs GW-ADR-0011's stage C amendment in Workstation and gate A2 on the composed result; private sources follow W4. A docs merge doesn't pass A2 or W4.

Workflow Factory stays independent and in progress. WfOS resumption remains optional; no Ontarch/Panoply/Takogami package, policy engine, universal graph, hosted registry or continuity store is required by these steps.
