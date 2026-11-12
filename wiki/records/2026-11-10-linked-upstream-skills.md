---
id: AS-REC-2026-11-10-LINKED-UPSTREAM-SKILLS
kind: session
title: Linked upstream skills, pinned as submodules (agent-skills#2, 2026-11-10 to 2026-11-11)
summary: "Six public skills linked from their authors at reviewed commits (obra/superpowers, trailofbits/skills, mattpocock/skills) instead of copied, check.sh taught to verify the links (15 mutations), the skills CLI 1.7.6 tested in an empty home; reviewed and held while Workbench's agent tooling was reviewed; the owner's thin-herdr-skill decision posted on it; merged on the owner's word as ee9d54e with WB-06 open."
status: done
created: 2026-11-10
updated: 2026-11-12
related: [AS-ARCH-SKILL-SOURCES, AS-ARCH-GUEST-INSTALL, GW-ADR-0014, GW-REC-2026-11-11-AGENT-TOOLING-SESSION, GW-REC-2026-11-11-AGENT-TOOLING-REVIEW, GW-REC-2026-11-11-HERDR-CORE, GW-RES-0007, AS-PROGRAM, AS-STATE]
---

# Linked upstream skills (agent-skills#2)

Written on 2026-11-12 from [agent-skills#2](https://github.com/luckgrid/agent-skills/pull/2): its description, its three comments, and the commit it merged as. The review of the candidate skills is in the owner's private project notes (`claude/agent-skills-shortlist.md` in the Workbench project, as the PR names it) and is not reproduced here.

## What was linked (reviewed 2026-11-10)

| Skill | Upstream (licence) | Commit |
| --- | --- | --- |
| `verification-before-completion`, `receiving-code-review`, `systematic-debugging` | obra/superpowers (MIT) | `22f0b463` (v7.0.2) |
| `differential-review` | trailofbits/skills (CC-BY-SA-4.0) | `e4dd0bb5` |
| `grilling`, `grill-me` | mattpocock/skills (MIT) | `4ae2317d` |

The PR left out the thinking skills of the set the owner uploaded for review: "Workbench's own security and thinking skills come later" ([program](../program.md#later)).

## The design, and why

Each upstream repository is a shallow submodule under `upstream/<id>/`; `skills/<name>` is a relative symlink into it; `upstream.toml` records the URL, commit, licence and review date, and each skill's `SKILL.md` SHA-256 and whole-folder digest. The PR's reasons, as it gives them:

- "The authors keep their skills and their credit. Someone adding this repository with the skills CLI gets only the skills written here: the CLI clones without submodules and skips the dangling links (checked: a clone without submodules lists `herdr`, `wb-guest-rules` and `wb-herdr` only)."
- "No other licence's files are committed here, so the CC-BY-SA question doesn't arise."

The standing description is [skill sources](../architecture/skill-sources.md).

## `check.sh`

It was extended to fail on a link pointing anywhere but `../upstream/<repo>/<path>`, a submodule whose recorded gitlink or checkout isn't the pinned commit, a `.gitmodules` URL that differs, a changed `SKILL.md` or file in a linked folder, a symlink inside a linked folder, a missing licence file, and anything unlisted under `skills/` or `upstream/`. It runs on Python 3.9 (macOS's `python3`) and later, plus `git`.

Each failure was checked by a mutation the script catches: 15 cases (edited `SKILL.md`, added file, retargeted link, submodule moved, manifest commit changed, unlisted link, submodule not checked out, symlink inside a folder, `..` and absolute paths, herdr copy edited, malformed line, link replaced by a copy, unlisted `upstream/` folder, changed URL), plus an unmutated control. Every commit passed on its own.

## The skills CLI, tested

Tested in an empty home, in a network namespace with no network, with `DISABLE_TELEMETRY=1 DO_NOT_TRACK=1` (the PR's words):

> - all nine skills installed, each a real copy in `~/.agents/skills/<name>`, byte-identical to the folder digests (`agents/openai.yaml` included);
> - `~/.claude/skills/<name>` links to each copy; Codex and Cursor read `~/.agents/skills` directly; nothing is written to `~/.cursor/skills`;
> - lock file `~/.agents/.skill-lock.json`, each source recorded as a local path.

The CLI 1.7.6 skips symlinked folders when it scans a checkout, so `wb setup` has to run it once for the checkout and once per linked skill. That changed GW-ADR-0014 decision 2's single invocation and the catalog's note that the CLI writes `~/.cursor/skills`; the PR named those as F1 changes for Workbench and Groundwork, not made here. Workbench's U16 docs were reconciled with it the next day (wiki-nest#64). The result is [guest install](../architecture/guest-install.md).

## Review, held open (2026-11-11)

A cloud session's review, posted 2026-11-11 and held open by the owner "until the Workbench agent tooling review is done":

- with the submodules initialised, `scripts/check.sh` passed (9 skills, 6 linked);
- the linked folders were spot-checked: they install, fetch and push nothing; `systematic-debugging` ships `find-polluter.sh`, which runs a repository's tests, a debugging helper that nothing installs;
- commit `0d16d19` added to the README that wiki-nest's U16 was built but inert (wiki-nest#64), and that as built its single `git archive` run would install only the skills written here.

## The owner's decision on the herdr skill (2026-11-11)

Posted on the PR the same day, as follow-up work rather than a change to it: "replace the copied `herdr` skill with a thin luckgrid skill", the owner's decisions H1 and H3, recorded in Groundwork's [herdr-core record](https://github.com/luckgrid/workstation/blob/main/wiki/groundwork/records/2026-11-11-herdr-core-terminal-workflows.md#herdr-skill-decisions-that-bear-on-core-owner-2026-11-11) (then luckgrid/groundwork#34). What it changes here is [program](../program.md#p1-a-thin-herdr-skill) items P1 and P1b.

## The independent review's WB-06, and the merge

The independent review of Workbench's agent tooling ([Groundwork's review record](https://github.com/luckgrid/workstation/blob/main/wiki/groundwork/records/2026-11-11-agent-tooling-review.md)) raised WB-06 on this PR, a should-fix: the linked skills name helpers that the standalone installation doesn't provide. It was left with this PR as a follow-up, since the PR was another session's.

The PR was merged on the owner's word on 2026-11-11 as `ee9d54e`, with WB-06 open, gated on F1. Before merging, `scripts/check.sh` was run with the submodules at their pinned commits (`4ae2317`, `22f0b46` v7.0.2, `e4dd0bb`):

```text
ok: 9 skills checked (6 linked from 3 upstream repositories)
```

The merge comment's condition stands: U16 stays inactive until F1 pins it, and pinning also needs the submodules' content in the export and one `add` per linked skill. WB-06 is [program](../program.md#p2-wb-06-helpers-the-linked-skills-name) item P2.
