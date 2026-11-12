---
id: AS-REC-2026-11-12-WORKSTATION-LINKS
kind: session
title: README links point at Workstation, with a note (agent-skills#3, 2026-11-12)
summary: "Workbench moved from wiki-nest into luckgrid/workstation and Groundwork was archived, so the README's install section was relinked; the consolidation review asked whether a public repository may link to private Workstation (CR-08); the owner said yes, since Workstation is to become public when ready, and a note was added; merged as cfa2c6a."
status: done
created: 2026-11-12
updated: 2026-11-12
related: [WS-REC-2026-11-11-CONSOLIDATION-CUTOVER, WS-REC-2026-11-12-CONSOLIDATION-REVIEW, AS-ARCH-GUEST-INSTALL, AS-STATE]
---

# README links point at Workstation (agent-skills#3)

Written on 2026-11-12 from [agent-skills#3](https://github.com/luckgrid/agent-skills/pull/3) and Workstation's [consolidation review](https://github.com/luckgrid/workstation/blob/main/wiki/records/2026-11-12-consolidation-review.md).

## Why

Groundwork and Workbench were consolidated into luckgrid/workstation on 2026-11-11, and luckgrid/groundwork was archived (WS-REC-2026-11-11-CONSOLIDATION-CUTOVER). The README's install section still pointed at wiki-nest for Workbench's U16.

The PR changed only the README:

- the heading says Workbench's U16, not wiki-nest's;
- it links the U16 description in Workstation's daily-use page;
- it still mentions luckgrid/wiki-nest#64, where U16 was built;
- agent workflows step F1 points at Workstation's agent-workflows page.

`scripts/check.sh` doesn't read the README. In a clone without submodules it fails the same way it does on `main`, because the linked skills' targets aren't checked out.

## CR-08 and the owner's answer

Workstation's consolidation review raised CR-08, a minor finding and owner question: this public README links to private Workstation pages, which public readers can't open. The review left the choice to the owner, between accepting private internal references and publishing a public-safe description.

**Owner, 2026-11-12:** linking to Workstation is fine, since it is planned to become public when it's ready. The README gained a short note, "About Workstation", saying what Workstation is, and that it is still in development and private for now, so its links open only for collaborators until it becomes public.

The PR was merged as `cfa2c6a`. Workstation's STATE and the review record's CR-08 row record the same answer.

## What it means for this wiki

The same rule holds here: pages may link to Luckgrid's private repositories, and say that they are private ([writing standard](../README.md#writing-standard)).
