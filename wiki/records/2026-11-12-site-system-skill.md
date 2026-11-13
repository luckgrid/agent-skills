---
id: AS-REC-2026-11-12-SITE-SYSTEM-SKILL
kind: session
title: M7, the site-system project skill (2026-11-12)
summary: "A cloud session wrote M7, the site-system project skill, in the private site-system repository (site-system#9, draft), built first by the owner's choice. It read the sources at pinned commits, asked the owner four questions (each answered with the recommended option), and wrote a router SKILL.md, seven references and CREDITS.md. This repository lists the skill and its public sources; its content and full record stay in site-system."
status: active
created: 2026-11-12
updated: 2026-11-13  # the independent review; a private detail removed (its finding)
related: [AS-PROGRAM, AS-STATE, AS-RES-SKILL-REFERENCES, AS-REC-2026-11-12-SKILL-MODULES, GW-ADR-0014]
---

# M7, the site-system project skill (2026-11-12)

The roadmap's [M7](../program.md#m7-site-system-a-project-skill-in-site-system) is a project skill in site-system, which is private, so the skill and its full record are there: luckgrid/site-system#9 (draft, private), with the record of its sources, contradictions and checks. This record keeps what can be public. Where M7 stands is in [STATE](STATE.md).

## What was done

- **Phase 0, research:** the sources read at pinned commits or dated versions; the public ones are in [skill references](../resources/skill-references.md#site-system-m7-a-project-skill-in-site-system). The private ones (site-system's README, wiki and code; wiki-nest's platform decision and guides; Workstation's Workbench and Groundwork pages) are named there without their commits.
- **The owner's questions:** four, asked as multiple-choice questions with a recommended option; the owner chose the recommended option each time. They settled how site-system's STATE records a step that had merged without a STATE line, how the skill states a template rule whose stated reason the pinned Zola doesn't bear out (the rule stands, with its why), how it treats the theme's reads of design-system tokens that design-system classes as internal (no new ones; the existing ones listed), and that the outline was right. A fifth, asked the same evening with the follow-ups, was whether Workstation should record a rule for skills inside a repository; the owner chose "Yes, allowed where reviewed (Recommended)": allowed only in the owner's repositories where every change to the skill goes through a reviewed PR, and data in anyone else's. A later Workstation change records it.
- **Phase 1, the skill:** in site-system's `.agents/skills/site-system/` (read by Codex and Cursor), with `.claude/skills/site-system` a relative link to it for Claude Code, as the roadmap says. `SKILL.md` is a router of 71 lines: the repository's README as authority, its rules in brief, what only the owner does, that the committed version holds, a table of which reference to read for which task, and when to stop and ask. The seven references: orient, build and check, templates (Tera 2 on Zola 0.23.6), design system (consuming the pinned release, until M6), release, records, and a review lens. `CREDITS.md` names each source and the ideas taken; no text was copied.

## What was found that bears on other modules

- **Claude Code and Codex both follow a linked skill folder,** by their documentation (read 2026-11-12): Claude Code a project skill entry that is a symlink, Codex a symlinked skill folder. Workbench's cell S1 still checks link-following in the guest.
- **Most Zola skills online teach Tera 1** (macros, shortcodes, `import`), which Zola 0.23 removed. M7 takes nothing from them but shape. The same will hold for any module that touches Zola.
- **For M6:** design-system's consumer rules as M7 carries them are in M7's `design-system` reference, from design-system at `09199f7`. When M6 exists, that reference becomes a pointer to it.

## Checks

- **site-system's gate** passed at the skill's commit in the cloud session on Rust 1.97.0, not the pinned 1.99.1, which the session couldn't fetch; the owner's `wb check` then passed it on the pin.
- **The skill's own checks:** the front matter meets the specification's limits (a 502-character description), every relative link and anchor resolves one level deep, and the `.claude` link resolves.
- **A release built from a plain clone** at the skill's commit had the same digests as before the skill.
- **An independent review** (2026-11-12, a different model) found no blocker or major and four minor issues; all were fixed, one of them by removing a private configuration detail from this record. The review and its dispositions are in site-system's records.

## Next

Done the same evening, owner-reported: `wb check` passed on the pinned toolchain, and a fresh Claude Code pane and a fresh Codex pane in the guest both list `site-system`, so Claude Code follows the linked skill folder. The independent review followed (see Checks). Next: a recheck of its fixes, then the merge on the owner's word.
