---
id: AS-REC-2026-11-10-FIRST-SKILLS
kind: session
title: The first skills, written in the guest (agent-skills#1, 2026-11-10)
summary: "A Claude Code session in the Workbench guest, inside herdr, wrote herdr (copied from herdr --skill 0.9.5), wb-herdr and wb-guest-rules, the README, the Apache-2.0 licence (the owner's choice) and scripts/check.sh; the owner promoted, reviewed, added herdr's LICENSE on the Mac and squash-merged it as dac4d36. wb-review and wb-remediate moved to Workbench's step F1."
status: done
created: 2026-11-10
updated: 2026-11-12
related: [AS-REC-2026-11-07-ORIGIN, GW-REC-2026-11-10-GUEST-AGENT-ENV, GW-ADR-0014, AS-ARCH-SKILL-SOURCES, AS-STATE]
---

# The first skills (agent-skills#1, 2026-11-10)

Written on 2026-11-12 from [agent-skills#1](https://github.com/luckgrid/agent-skills/pull/1), the files it merged and Groundwork's [guest agent environment record](https://github.com/luckgrid/workstation/blob/main/wiki/groundwork/records/2026-11-10-guest-agent-environment.md), which covers the session in full. Results are as that record gives them.

## Before the skills: what the guest session couldn't do

The session was started from the [kickoff](2026-11-07-origin.md#the-kickoff-for-the-first-session-2026-11-10). Its first, read-only step stopped and reported what it couldn't do under the owner's rules: herdr's socket, the harnesses' skill folders, the notes folder, claude.ai's connectors, its starting folder and a missing branch among them. Each was fixed in Workbench or left on purpose, in wiki-nest#58 and #59, before the work resumed. One item was answered for this repository: herdr's `LICENSE` at tag `v0.9.5` is Apache-2.0 with no `NOTICE` file, so a copy of `herdr --skill` may go here with the licence and attribution beside it.

## What the session wrote

On branch `skills/first`, from a herdr pane in the guest's clone:

- **`herdr`:** copied unchanged from `herdr --skill` of herdr 0.9.5, with `UPSTREAM.md` recording the version, the command, the SHA-256, the upstream path and commit, the licence and the attribution;
- **`wb-herdr`:** how agents manage herdr workspaces and worktrees in the guest. herdr's socket commands are refused in the guest's sandbox by design, so the skill has the agent print each one for the owner to run, and take every ID from the reply;
- **`wb-guest-rules`:** the house rules for any agent in the guest;
- the README, the repository's Apache-2.0 `LICENSE` (the owner's choice, when asked) and `scripts/check.sh`, which validated each skill's front matter with `python3` and the `herdr` copy against its SHA-256.

`wb-review` and `wb-remediate`, also in the kickoff, were not written in this session. They belong with `wb-flow`, in Workbench's step F1 ([program](../program.md#p3-the-review-and-remediation-skills-f1)).

## Review, the licence and the merge

As Groundwork's record gives them:

- The owner promoted the branch with `wb promote` and reviewed it on the Mac. The review's five findings were fixed in the guest and promoted again.
- On the Mac the owner added herdr's `LICENSE` (SHA-256 `c71d239d…0ab4`, checked), pushed, and squash-merged. The merge commit is `dac4d36`; the PR's description reads, word for word: "From the guest's skills/first, promoted with wb promote; herdr's LICENSE added on the Mac."
- Inside the sandbox, `git status` listed Claude Code's `/dev/null` placeholders over protected paths. They aren't files, and staging explicit paths keeps them out.
- The guest session never ran a socket command, push or install.

`skills/herdr/UPSTREAM.md` records the full licence digest: `c71d239df91726fc519c6eb72d318ec65820627232b2f796219e87dcf35d0ab4` (the Apache-2.0 text without its leading blank line), from tag v0.9.5.
