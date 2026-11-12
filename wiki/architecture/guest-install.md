---
id: AS-ARCH-GUEST-INSTALL
kind: architecture
title: Guest install
summary: "How the Workbench guest is to install these skills: Workbench's step U16, built but inert until pinned; what the skills CLI 1.7.6 was tested to write; and what U16 needs before a commit with linked upstream skills is pinned."
status: active
created: 2026-11-12
updated: 2026-11-12
related: [GW-ADR-0014, GW-ARCH-WORKBENCH-AGENT-WORKFLOWS, GW-GUIDE-WORKBENCH-DAILY-USE, GW-RES-0007, GW-REC-2026-11-11-AGENT-TOOLING-REVIEW, AS-ARCH-SKILL-SOURCES, AS-REC-2026-11-10-LINKED-UPSTREAM-SKILLS, AS-STATE]
derived_from: GW-ADR-0014
---

# Guest install

**Status:** planned. Nothing installs these skills in the guest yet. Workbench's `wb setup` has the step, U16, but it does nothing until this repository's commit and the skills CLI are both pinned. The step is Workbench's, and is described in full in its [daily use](https://github.com/luckgrid/workstation/blob/main/wiki/workbench/daily-use.md#guest-tools-wb-setup) page, in luckgrid/workstation (private for now). This page records what it needs from this repository. Where the two disagree, Workbench's page decides for the step, and this page is corrected.

## The decided shape

From Groundwork's GW-ADR-0014 decision 2 (proposed; owner, 2026-11-07: "Pinned, local checkout only"):

- The guest checks out a **full commit** of this repository, pinned in Workbench's tool list, and loads nothing before that check passes.
- Vercel's [skills CLI](https://github.com/vercel-labs/skills) (the tool behind skills.sh) is pinned at an exact version in a lockfile with integrity hashes and installed with `npm ci --ignore-scripts`. Its lockfile pins 1.7.6.
- It runs only from `wb setup`, outside every agent's sandbox, with `DISABLE_TELEMETRY=1` and `DO_NOT_TRACK=1`, against the **local** checkout by its **absolute** path. A source that isn't absolute or `./`-relative is read as a GitHub repository and cloned, and a remote source falls back to `gh` or SSH credentials. Never `npx`, a remote source or `skills use`.
- U16 installs from a `git archive` export of the pinned commit, so an agent's uncommitted edit in the guest's clone is never installed.

## What the CLI writes (tested, 2026-11-10)

Tested with 1.7.6 in an empty home with no network, with telemetry off (agent-skills#2):

- each skill is copied to `~/.agents/skills/<name>`, byte-identical to the folder digests in `upstream.toml`;
- `~/.claude/skills/<name>` is a link to that copy, for Claude Code; Codex and Cursor read `~/.agents/skills` directly;
- nothing is written to `~/.cursor/skills`;
- the lock file is `~/.agents/.skill-lock.json`, each source recorded as a local path;
- the CLI does **not** follow symlinked folders when it scans a checkout, so a single `skills add <checkout>` installs only the skills written here.

Groundwork's read of the CLI's code (GW-RES-0007, 2026-11-11) agrees. It also found that `skills remove -g` deletes the name from every agent's skills folder it knows, whoever put it there, so U16 never uses it: it removes only what it installed itself, tracked by its own digests.

## What U16 needs before linked skills are pinned

> **Planned change (owner, 2026-11-12):** M0 removes the linked skills, so none of this section will be needed: U16's single `skills add` on a `git archive` export installs every module ([roadmap](../program.md#m0-the-module-foundation)).

As built, U16 runs the CLI once on a `git archive` export. That export has no submodules, so it would install only the skills written here. Before a commit with linked skills is pinned, Workbench's agent workflows step F1 changes U16 to:

1. put the submodules' pinned content in the export;
2. run this repository's `scripts/check.sh` on it, and stop unless it passes;
3. run the CLI once for the export and once per `[skill.<name>]` in `upstream.toml`, by the link's path:

```sh
skills add <export> -g -a claude-code codex cursor -y
skills add <export>/skills/<name> -g -a claude-code codex cursor -y   # each [skill.<name>]
```

These are changes to Workbench, not to this repository. This repository's part is to keep `scripts/check.sh` passing at every commit that may be pinned, and to settle WB-06 ([program](../program.md#p2-wb-06-helpers-the-linked-skills-name)) first.

## What installing doesn't prove

A skill that installs is not a workflow that works. A linked skill may name a helper that isn't installed with it (WB-06). Cell S1 of step F1 is the runtime check: each harness lists the skills, and a skill turned off is hidden.
