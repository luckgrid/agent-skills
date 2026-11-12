---
id: AS-RESOURCES
kind: resources
title: Sources
summary: "The format, tools, upstream repositories and Luckgrid pages behind agent-skills, with the versions and commits they were read at."
status: active
created: 2026-11-12
updated: 2026-11-12
related: [AS-ARCH-SKILL-SOURCES, AS-ARCH-GUEST-INSTALL, GW-ADR-0014]
---

# Sources

## Format and tools

| Source | What it gives | Read at |
| --- | --- | --- |
| [Agent Skills specification](https://agentskills.io/specification) ([agentskills/agentskills](https://github.com/agentskills/agentskills)) | The `SKILL.md` format: folder, front matter, `name` and `description` limits | 2026-11-12 |
| [Vercel's skills CLI](https://github.com/vercel-labs/skills) (behind skills.sh) | The installer Workbench pins | 1.7.6, tested 2026-11-10 (agent-skills#2), code read 2026-11-11 (Groundwork's GW-RES-0007) |
| [herdr](https://herdr.dev) | The terminal multiplexer the guest's agents run in; `herdr --skill` | 0.9.5 (tag v0.9.5, commit `2ecf19a`) |
| [rumdl](https://github.com/rvben/rumdl) | Markdown checks for this wiki | 0.3.2 |

## Linked upstream repositories

Pinned commits and digests are in `upstream.toml`, which decides; this table is a summary.

| Repository | Licence | Commit | Skills linked |
| --- | --- | --- | --- |
| [obra/superpowers](https://github.com/obra/superpowers) | MIT | `22f0b463` (v7.0.2) | `verification-before-completion`, `receiving-code-review`, `systematic-debugging` |
| [trailofbits/skills](https://github.com/trailofbits/skills) | CC-BY-SA-4.0 | `e4dd0bb5` | `differential-review` |
| [mattpocock/skills](https://github.com/mattpocock/skills) | MIT | `4ae2317d` | `grilling`, `grill-me` |

## Read for the thin herdr skill, nothing copied

From the 2026-11-11 review of herdr skills listed on skills.sh, read at pinned commits with nothing installed, which led to the owner's decisions ([program](program.md#p1-a-thin-herdr-skill)):

- callstack/agent-device `skills/dogfood` (MIT, `5a836c05`): the skill's shape;
- whamp/skills (MIT, `c91b3414`): the maintenance block;
- gregbarbosa/skills (no licence, `e79c1a60`): facts, used only once `herdr --help` confirms them, in Luckgrid's own words;
- yangyang0507/herdr-skill (no licence, `87fef40`): branches between the herdr TUI and Core; for reading only.

## Luckgrid pages

In luckgrid/workstation, which is still in development and private for now:

- Groundwork's [GW-ADR-0014](https://github.com/luckgrid/workstation/blob/main/wiki/groundwork/records/decisions/0014-shared-skills-and-agent-workflows.md): shared agent skills and herdr-driven review workflows (proposed).
- Workbench's [agent workflows](https://github.com/luckgrid/workstation/blob/main/wiki/workbench/agent-workflows.md) and [daily use](https://github.com/luckgrid/workstation/blob/main/wiki/workbench/daily-use.md#guest-tools-wb-setup) (U16).
- Groundwork's records: [the guest agent environment](https://github.com/luckgrid/workstation/blob/main/wiki/groundwork/records/2026-11-10-guest-agent-environment.md) (agent-skills#1's round trip), [the agent tooling session](https://github.com/luckgrid/workstation/blob/main/wiki/groundwork/records/2026-11-11-agent-tooling-session.md) and [its review](https://github.com/luckgrid/workstation/blob/main/wiki/groundwork/records/2026-11-11-agent-tooling-review.md) (WB-06), [the herdr-core record](https://github.com/luckgrid/workstation/blob/main/wiki/groundwork/records/2026-11-11-herdr-core-terminal-workflows.md) (the herdr skill decisions).
- Workstation's [consolidation review](https://github.com/luckgrid/workstation/blob/main/wiki/records/2026-11-12-consolidation-review.md) (CR-08).

In luckgrid/wiki-nest (private): `wiki-structure.md`, the shared wiki template this wiki follows.
