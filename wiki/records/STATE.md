---
id: AS-STATE
kind: state
title: State
summary: "Where agent-skills stands: nine skills on main (two written here, one copy, six linked), check.sh passing with submodules; nothing installed in the guest yet; open: the thin herdr skill, WB-06, and the F1 review skills; the decisions in force."
status: active
created: 2026-11-12
updated: 2026-11-12
related: [AS-PROGRAM, AS-ARCH-SKILL-SOURCES, AS-ARCH-GUEST-INSTALL, GW-ADR-0014]
---

# State

**As of 2026-11-12, `main` at `cfa2c6a`.** Results are as their records give them.

## Where it stands

| Area | Position |
| --- | --- |
| Skills on `main` | Nine: `wb-herdr` and `wb-guest-rules` written here; `herdr` copied from herdr 0.9.5; six linked from obra/superpowers, trailofbits/skills and mattpocock/skills ([skill sources](../architecture/skill-sources.md)) |
| `scripts/check.sh` | `ok: 9 skills checked (6 linked from 3 upstream repositories)` with the submodules at their pinned commits, before agent-skills#2 merged on 2026-11-11 ([record](2026-11-10-linked-upstream-skills.md#the-independent-reviews-wb-06-and-the-merge)); agent-skills#3 changed only the README |
| In the guest | **Nothing installed.** Workbench's U16 is built but inert until this repository's commit and the skills CLI are pinned; before a commit with linked skills is pinned, F1 changes U16 ([guest install](../architecture/guest-install.md)). The guest's read-only clone is on `main` at `cfa2c6a` (Workstation's guest home layout record, 2026-11-12) |
| The wiki | Added on 2026-11-12 ([record](2026-11-12-wiki.md)) |

## Open

| Item | Gate | Page |
| --- | --- | --- |
| A thin herdr skill replaces the copy | Owner decision made (2026-11-11); not started | [P1](../program.md#p1-a-thin-herdr-skill) |
| Confirmed facts in `wb-herdr` | Owner decision made (2026-11-11); not started | [P1b](../program.md#p1b-confirmed-facts-in-wb-herdr) |
| WB-06: helpers the linked skills name | Before U16 pins a commit with linked skills | [P2](../program.md#p2-wb-06-helpers-the-linked-skills-name) |
| `wb-review` and `wb-remediate` | Workbench's step F1 | [P3](../program.md#p3-the-review-and-remediation-skills-f1) |

## Decisions in force

The owner's decisions that bind this repository, newest first. Groundwork's GW-ADR-0014 is still **proposed**; its decisions 1 and 2 are the owner's choices and are followed here, but GW-ADR-0014 itself is accepted only in Workstation.

| Date | Decision | Where recorded |
| --- | --- | --- |
| 2026-11-12 | Pages here may link to Luckgrid's private Workstation, with a note that it is still in development and private for now (CR-08) | [record](2026-11-12-workstation-links.md) |
| 2026-11-11 | Replace the copied `herdr` skill with a thin Luckgrid skill; third-party herdr facts only once `--help` confirms them, in Luckgrid's words (H1, H3) | [record](2026-11-10-linked-upstream-skills.md#the-owners-decision-on-the-herdr-skill-2026-11-11) |
| 2026-11-11 | Merge agent-skills#2 with WB-06 open, gated on F1; with it, public skills are linked from their authors at reviewed commits, not copied (the PR's design) | [record](2026-11-10-linked-upstream-skills.md#the-independent-reviews-wb-06-and-the-merge) |
| 2026-11-10 | The repository's licence is Apache-2.0 | [record](2026-11-10-first-skills.md#what-the-session-wrote) |
| 2026-11-07 | One public skills repository, `luckgrid/agent-skills`; the skills CLI pinned and run on a local checkout only (GW-ADR-0014 decisions 1 and 2, proposed) | [record](2026-11-07-origin.md#the-choices-owner-2026-11-07) |
