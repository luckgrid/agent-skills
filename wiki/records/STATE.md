---
id: AS-STATE
kind: state
title: State
summary: "Where agent-skills stands: nine skills on main (two written here, one copy, six linked), check.sh passing with submodules; nothing installed in the guest yet; next, the refactor to custom skill modules M0 to M6 (owner, 2026-11-12); the decisions in force."
status: active
created: 2026-11-12
updated: 2026-11-12  # the custom-modules plan (owner, 2026-11-12)
related: [AS-REC-2026-11-12-SKILL-MODULES, AS-RES-SKILL-REFERENCES, AS-PROGRAM, AS-ARCH-SKILL-SOURCES, AS-ARCH-GUEST-INSTALL, GW-ADR-0014]
---

# State

**As of 2026-11-12, `main` at `9ff8b6c`.** Results are as their records give them.

## Where it stands

| Area | Position |
| --- | --- |
| Skills on `main` | Nine: `wb-herdr` and `wb-guest-rules` written here; `herdr` copied from herdr 0.9.5; six linked from obra/superpowers, trailofbits/skills and mattpocock/skills ([skill sources](../architecture/skill-sources.md)) |
| `scripts/check.sh` | `ok: 9 skills checked (6 linked from 3 upstream repositories)` with the submodules at their pinned commits, before agent-skills#2 merged on 2026-11-11 ([record](2026-11-10-linked-upstream-skills.md#the-independent-reviews-wb-06-and-the-merge)); agent-skills#3 and #4 changed only the README and the wiki |
| In the guest | **Nothing installed.** Workbench's U16 is built but inert until this repository's commit and the skills CLI are pinned; before a commit with linked skills is pinned, F1 changes U16 ([guest install](../architecture/guest-install.md)). The guest's read-only clone is on `main` at `cfa2c6a` (Workstation's guest home layout record, 2026-11-12) |
| The wiki | Added on 2026-11-12 ([record](2026-11-12-wiki.md)) |
| The plan | Fully custom skill modules, planned on 2026-11-12 ([record](2026-11-12-skill-modules.md), [roadmap](../program.md)); nothing built yet |

## Open

| Item | Gate | Page |
| --- | --- | --- |
| M0: remove the linked skills; `check.sh` and the README for modules | Next | [M0](../program.md#m0-the-module-foundation) |
| M1: `workbench` (replaces `wb-guest-rules`, `wb-herdr`) | After M0 | [M1](../program.md#m1-workbench) |
| M2: `peer-review` (takes in `wb-review`, `wb-remediate`) | After M1; Workbench's step F1 needs it | [M2](../program.md#m2-peer-review) |
| M3: `herdr` (the thin skill, H1 and H3, and herdr workflows) | After M2 | [M3](../program.md#m3-herdr) |
| M4: `wiki` | After M3 | [M4](../program.md#m4-wiki) |
| M5: `grill` | After M4 | [M5](../program.md#m5-grill) |
| M6: `frugal`; rtk and qmd as separate Workbench catalog items | Last | [M6](../program.md#m6-frugal) |
| Owner questions: the wiki template in public; the order of M4 to M6; `systematic-debugging` | Owner | [questions](../program.md#open-questions-for-the-owner) |

WB-06 closes with M0, which removes the skills it is about.

## Decisions in force

The owner's decisions that bind this repository, newest first. Groundwork's GW-ADR-0014 is still **proposed**; its decisions 1 and 2 are the owner's choices and are followed here, but GW-ADR-0014 itself is accepted only in Workstation.

| Date | Decision | Where recorded |
| --- | --- | --- |
| 2026-11-12 | Fully custom skill modules instead of maintaining an upstream, with a reference list of skills; own words only, ideas credited; the linked skills removed in the first refactor PR; the review module named `peer-review`; `frugal` as instructions first, rtk and qmd later through Workbench's catalog | [record](2026-11-12-skill-modules.md#the-owners-choices-2026-11-12) |
| 2026-11-12 | Pages here may link to Luckgrid's private Workstation, with a note that it is still in development and private for now (CR-08) | [record](2026-11-12-workstation-links.md) |
| 2026-11-11 | Replace the copied `herdr` skill with a thin Luckgrid skill; third-party herdr facts only once `--help` confirms them, in Luckgrid's words (H1, H3) | [record](2026-11-10-linked-upstream-skills.md#the-owners-decision-on-the-herdr-skill-2026-11-11) |
| 2026-11-11 | Merge agent-skills#2 with WB-06 open, gated on F1; with it, public skills are linked from their authors at reviewed commits, not copied (the PR's design; superseded by the 2026-11-12 decision once M0 merges) | [record](2026-11-10-linked-upstream-skills.md#the-independent-reviews-wb-06-and-the-merge) |
| 2026-11-10 | The repository's licence is Apache-2.0 | [record](2026-11-10-first-skills.md#what-the-session-wrote) |
| 2026-11-07 | One public skills repository, `luckgrid/agent-skills`; the skills CLI pinned and run on a local checkout only (GW-ADR-0014 decisions 1 and 2, proposed) | [record](2026-11-07-origin.md#the-choices-owner-2026-11-07) |
