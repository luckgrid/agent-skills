---
id: AS-STATE
kind: state
title: State
summary: "Where agent-skills stands: nine skills on main (two written here, one copy, six linked), check.sh passing with submodules; nothing installed in the guest yet; the agents monorepo direction and knowledge consolidation, plus the refactor to custom skill modules M0 to M9 (owner, 2026-11-12), the site-system project skill first; the decisions in force."
status: active
created: 2026-11-12
updated: 2026-11-12  # agents monorepo direction and knowledge consolidation; before that, the custom-modules plan (owner, 2026-11-12)
related: [AS-ADR-0001, AS-ARCH-AGENTS-WORKSPACE, AS-RES-AGENTS-LINEAGE, AS-REC-2026-11-12-SKILL-MODULES, AS-RES-SKILL-REFERENCES, AS-PROGRAM, AS-ARCH-SKILL-SOURCES, AS-ARCH-GUEST-INSTALL, GW-ADR-0014]
---

# State

**As of 2026-11-12.** Runtime results remain as their records give them; the documentation research baseline is recorded in the [agents monorepo session](2026-11-12-agents-monorepo.md).

## Where it stands

| Area | Position |
| --- | --- |
| Skills on `main` | Nine: `wb-herdr` and `wb-guest-rules` written here; `herdr` copied from herdr 0.9.5; six linked from obra/superpowers, trailofbits/skills and mattpocock/skills ([skill sources](../architecture/skill-sources.md)) |
| `scripts/check.sh` | `ok: 9 skills checked (6 linked from 3 upstream repositories)` with the submodules at their pinned commits, before agent-skills#2 merged on 2026-11-11 ([record](2026-11-10-linked-upstream-skills.md#the-independent-reviews-wb-06-and-the-merge)); agent-skills#3 and #4 changed only the README and the wiki |
| In the guest | **Nothing installed.** Workbench's U16 is built but inert until this repository's commit and the skills CLI are pinned; before a commit with linked skills is pinned, F1 changes U16 ([guest install](../architecture/guest-install.md)). The guest's read-only clone is on `main` at `cfa2c6a` (Workstation's guest home layout record, 2026-11-12) |
| The wiki | Added on 2026-11-12 ([record](2026-11-12-wiki.md)) |
| The plan | Fully custom skill modules, planned on 2026-11-12 ([record](2026-11-12-skill-modules.md), [roadmap](../program.md)); nothing built yet |

## Agents workspace direction (owner, 2026-11-12)

[AS-ADR-0001](2026-11-12-agents-monorepo-decision.md) records the expansion into an agents monorepo and its reasons. The [workspace design](../architecture/agents-workspace.md) and [knowledge lineage](../resources/agents-knowledge-lineage.md) consolidate profiles, providers and native projections using Workstation as the latest source. Detailed layout, adapters, schemas, rename and install changes remain proposed; this documentation delivers no implementation. Workflow Factory stays independent WIP, WfOS resumption is optional, and wiki-nest context creates no migration task.

## Open

| Item | Gate | Page |
| --- | --- | --- |
| M7: `site-system`, a project skill in the site-system repository, with `design-system`'s consume rules until M6 | **First** (owner, 2026-11-12) | [M7](../program.md#m7-site-system-a-project-skill-in-site-system) |
| M0: remove the linked skills; `check.sh` and the README for modules; prove the agents package foundation and installer compatibility | After M7; detailed layout remains proposed | [M0](../program.md#m0-the-module-foundation) |
| M1: `workbench` (replaces `wb-guest-rules`, `wb-herdr`) | After M0 | [M1](../program.md#m1-workbench) |
| M2: `council` (takes in `wb-review`, `wb-remediate`; reviewers with lenses, in rounds) | After M1; Workbench's step F1 needs it | [M2](../program.md#m2-council) |
| M3: `multiplex` (replaces `herdr`; herdr the default backend, H1 and H3) | After M2 | [M3](../program.md#m3-multiplex) |
| M4: `wiki` | After M3 | [M4](../program.md#m4-wiki) |
| M5: `grill` | After M4 | [M5](../program.md#m5-grill) |
| M6: `design-system`; M7 then points to it | After M5 | [M6](../program.md#m6-design-system) |
| M8: `frugal`; rtk and qmd as separate Workbench catalog items | After M6 | [M8](../program.md#m8-frugal) |
| M9: `triage` (debugging, isolation, queues, incidents; takes `systematic-debugging`) | Last | [M9](../program.md#m9-triage) |

WB-06 closes with M0, which removes the skills it is about.

## Decisions in force

The owner's decisions that bind this repository, newest first. Groundwork's GW-ADR-0014 is still **proposed**; its decisions 1 and 2 are the owner's choices and are followed here, but GW-ADR-0014 itself is accepted only in Workstation.

| Date | Decision | Where recorded |
| --- | --- | --- |
| 2026-11-12 | Expand into an agents monorepo; skills become a package; consolidate relevant knowledge using Workstation as latest source; Workflow Factory stays independent and WfOS optional | [AS-ADR-0001](2026-11-12-agents-monorepo-decision.md), [session](2026-11-12-agents-monorepo.md) |
| 2026-11-12 | Third round: `wiki` publishes the wiki template's rules in its own words, with `wiki-structure.md` the authority; the `site-system` project skill is built first; a `triage` module, with debugging part of it | [record](2026-11-12-skill-modules.md#third-round-the-open-questions-answered-2026-11-12) |
| 2026-11-12 | Second round: the review module is `council` (several models, each with a lens, in rounds); `multiplex` replaces `herdr`, with herdr the default backend; new modules `design-system` here and `site-system` as a project skill in the site-system repository | [record](2026-11-12-skill-modules.md#second-round-the-owners-feedback-2026-11-12) |
| 2026-11-12 | Fully custom skill modules instead of maintaining an upstream, with a reference list of skills; own words only, ideas credited; the linked skills removed in the first refactor PR; the review module named `peer-review` (renamed `council` the same day); `frugal` as instructions first, rtk and qmd later through Workbench's catalog | [record](2026-11-12-skill-modules.md#the-owners-choices-2026-11-12) |
| 2026-11-12 | Pages here may link to Luckgrid's private Workstation, with a note that it is still in development and private for now (CR-08) | [record](2026-11-12-workstation-links.md) |
| 2026-11-11 | Replace the copied `herdr` skill with a thin Luckgrid skill; third-party herdr facts only once `--help` confirms them, in Luckgrid's words (H1, H3) | [record](2026-11-10-linked-upstream-skills.md#the-owners-decision-on-the-herdr-skill-2026-11-11) |
| 2026-11-11 | Merge agent-skills#2 with WB-06 open, gated on F1; with it, public skills are linked from their authors at reviewed commits, not copied (the PR's design; superseded by the 2026-11-12 decision once M0 merges) | [record](2026-11-10-linked-upstream-skills.md#the-independent-reviews-wb-06-and-the-merge) |
| 2026-11-10 | The repository's licence is Apache-2.0 | [record](2026-11-10-first-skills.md#what-the-session-wrote) |
| 2026-11-07 | One public skills repository, `luckgrid/agent-skills`; the skills CLI pinned and run on a local checkout only (GW-ADR-0014 decisions 1 and 2, proposed) | [record](2026-11-07-origin.md#the-choices-owner-2026-11-07) |
