---
id: AS-PROGRAM
kind: roadmap
title: Roadmap
summary: "What comes next for agent-skills: the thin herdr skill and wb-herdr's confirmed facts (owner, 2026-11-11), WB-06 before linked skills are pinned, the review and remediation skills for Workbench's step F1, and later skills."
status: active
created: 2026-11-12
updated: 2026-11-12
related: [AS-STATE, GW-ADR-0014, GW-REC-2026-11-11-HERDR-CORE, GW-REC-2026-11-11-AGENT-TOOLING-REVIEW, GW-ARCH-WORKBENCH-AGENT-WORKFLOWS, AS-REC-2026-11-10-LINKED-UPSTREAM-SKILLS]
---

# Roadmap

Each item says where it comes from. Where things stand is in [STATE](records/STATE.md); this page doesn't restate it. Nothing here is pinned into the guest until Workbench's step F1 pins a commit of this repository ([guest install](architecture/guest-install.md)).

## P1: a thin herdr skill

**From:** the owner's decision 1 of 2026-11-11, recorded in Groundwork's [herdr-core record](https://github.com/luckgrid/workstation/blob/main/wiki/groundwork/records/2026-11-11-herdr-core-terminal-workflows.md#herdr-skill-decisions-that-bear-on-core-owner-2026-11-11) and on agent-skills#2.

`skills/herdr/` becomes about 25 lines of Luckgrid's own:

- it stops unless `HERDR_ENV=1`;
- it checks `herdr --version` against a version floor (0.9.5);
- it defers to the installed binary's `herdr --skill`, and never upgrades herdr;
- it covers the herdr TUI only, not herdr-core's `hc`, which would need its own skill or a branch on `HC_TERMINAL_ID`, decided when Core is tried;
- in the guest, `wb-guest-rules` decides what an agent may run.

With it:

- herdr's copied `SKILL.md`, its `LICENSE` and `UPSTREAM.md` go away, and so does `check.sh`'s "herdr copy edited" case, replaced by checks for a missing `name` and a stale floor;
- a "Reviewed against" block records herdr 0.9.5, the bundled skill's SHA-256 and what triggers a re-review;
- the README credits the shapes it follows, with no text copied: callstack/agent-device's `skills/dogfood` (MIT, `5a836c05`) and the maintenance block of whamp/skills (MIT, `c91b3414`).

**Done when:** the thin skill is merged, `check.sh` passes, and nothing of herdr's text remains here.

## P1b: confirmed facts in `wb-herdr`

**From:** the owner's decision 3 of 2026-11-11 (same record). Facts first noted in gregbarbosa/skills (no licence; read only, `e79c1a60`) go into `wb-herdr` only after `herdr <group> --help` on 0.9.5 confirms them, written in Luckgrid's own words and credited.

## P2: WB-06, helpers the linked skills name

**From:** the independent review of 2026-11-11 ([Groundwork's review record](https://github.com/luckgrid/workstation/blob/main/wiki/groundwork/records/2026-11-11-agent-tooling-review.md)), left open when agent-skills#2 merged, gated on F1.

- `systematic-debugging` names `superpowers:test-driven-development` and `superpowers:verification-before-completion`; this repository links no test-driven-development skill, and installs `verification-before-completion` as a standalone skill, not in the Superpowers plugin's namespace.
- `differential-review` delegates high-risk review to the plugin agent `differential-review:adversarial-modeler`, which lives outside the linked folder.

The review's required correction: document these dependencies and provide reviewed standalone fallbacks or adapters before F1 activation, without silently installing whole upstream plugins or growing the admitted set.

**Done when:** each named helper is either documented as unavailable, with what the agent does instead, or supplied by a reviewed skill here; and Workbench's U16 can pin a commit with linked skills.

## P3: the review and remediation skills (F1)

**From:** Workbench's [agent workflows](https://github.com/luckgrid/workstation/blob/main/wiki/workbench/agent-workflows.md) and GW-ADR-0014, both proposed; first named in the owner's kickoff for this repository (2026-11-10).

- `wb-review`: read-only; reviews the diff between two named commits; severities blocker, major, minor and nit; at most ten findings; prints one JSON object (a verdict and findings with severity, file, line, title and reason) between begin and end markers the skill itself defines, so the markers never appear in a prompt.
- `wb-remediate`: reads a findings file; fixes blockers and majors, and minors where small; one commit per round with the finding IDs in the message; never pushes and never edits the findings file; ends by printing the new head.

The `wb-` names keep them apart from Codex's and Claude Code's built-in `/review`. They were deferred from agent-skills#1 to F1, where `wb-flow` is built with them.

**Done when:** F1's cell S1 lists both in Claude Code and Codex, and one review loop runs as the agent workflows page describes.

## Later

- **Workbench's own security and thinking skills.** agent-skills#2 left out the thinking skills of the set the owner uploaded for review; Workbench's own come later.
- **Cursor in the loops.** Cursor reads the installed skills already; it joins review loops only after its herdr hand-off gate (F4).
- **Keeping linked skills current.** Each upstream move is a new review at a specific commit, then the submodule, `commit`, `reviewed` and digests in one commit.
