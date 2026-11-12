---
id: AS-ARCH-SKILL-SOURCES
kind: architecture
title: Skill sources
summary: "The three kinds of skill this repository holds (written here, copied, linked), how each is recorded, what scripts/check.sh proves about them, and the licences, with the reasons for each choice."
status: active
created: 2026-11-12
updated: 2026-11-12
related: [GW-ADR-0014, AS-REC-2026-11-10-FIRST-SKILLS, AS-REC-2026-11-10-LINKED-UPSTREAM-SKILLS, AS-ARCH-GUEST-INSTALL, AS-STATE]
derived_from: GW-ADR-0014
---

# Skill sources

> **Planned change (owner, 2026-11-12):** the repository moves to fully custom skill modules written in Luckgrid's own words, and the linked upstream skills are removed in the first refactor PR (M0). Until M0 merges, this page describes the repository as it is. See the [roadmap](../program.md#the-direction-owner-2026-11-12).

The repository holds Agent Skills shared by the Workbench guest's harnesses: Claude Code, Codex and Cursor. Each skill is a folder `skills/<name>/` with a `SKILL.md` in the [Agent Skills format](https://agentskills.io/specification): YAML front matter with `name` and `description`, then the instructions. That it is one repository, public, and installed at a pinned commit comes from Groundwork's GW-ADR-0014 decision 1 (proposed; the owner chose "public" on 2026-11-07). The rules for adding a skill are in the root README; this page says how the pieces fit and why.

## Three kinds of skill

| Kind | Where it lives | Recorded in | Today |
| --- | --- | --- | --- |
| **Written here** | `skills/<name>/`, real files | the skill itself | `wb-herdr`, `wb-guest-rules` |
| **Copied** | `skills/<name>/`, real files copied unchanged | `UPSTREAM.md` beside it: version, how it was copied, `SHA-256:` line, upstream path and commit, licence, attribution | `herdr` (from `herdr --skill`, herdr 0.9.5) |
| **Linked** | `skills/<name>` is a relative symlink into a submodule under `upstream/<id>/` | `upstream.toml`: `[repo.<id>]` and `[skill.<name>]` | six skills from obra/superpowers, trailofbits/skills and mattpocock/skills |

**Why own skills are written here.** They hold the owner's own workflows and the guest's house rules, which nobody else publishes. They name no host, account or person, because the repository is public.

**Why a copy, and only for `herdr`.** herdr's skill describes the CLI of one installed version, so it must match the binary in the guest, not herdr's latest. It was copied from that binary's `herdr --skill` output, unchanged, with herdr's Apache-2.0 licence and attribution beside it ([first skills](../records/2026-11-10-first-skills.md)). The owner has since decided to replace the copy with a thin skill of Luckgrid's own that defers to `herdr --skill` ([program](../program.md#p1-a-thin-herdr-skill)); when that lands, copies are no longer used at all.

**Why public skills are linked, not copied** ([linked upstream skills](../records/2026-11-10-linked-upstream-skills.md)):

- The authors keep their skills and their credit. Someone who adds this repository with the skills CLI gets only the skills written here, because the CLI clones without submodules and skips dangling links; they install the linked skills from their authors.
- No file under another licence is committed here, so the share-alike terms of trailofbits/skills (CC-BY-SA-4.0) never apply to this repository's content.
- A pinned commit plus digests means a reviewed skill can't change underneath the guest: an update is a new review, a submodule move and new digests in one commit.

## `upstream.toml`

A restricted TOML subset: `[repo.<id>]` and `[skill.<name>]` tables, `key = "string"` lines and comments, nothing else, so `scripts/check.sh` parses it without a TOML library.

- `[repo.<id>]`: `url`, `commit` (full 40-character SHA), `licence`, `licence_file`, `reviewed` (date), and optionally `tag`. The submodule is `upstream/<id>`, shallow.
- `[skill.<name>]`: `repo`, `path` inside that repository, `skill_sha256` (of its `SKILL.md`) and `tree_sha256` (of the sorted `path NUL sha256` lines of every file in the folder).

## What `scripts/check.sh` proves

It needs only `python3` (3.9 or later, so macOS's own works) and `git`, and changes nothing.

1. **Every skill's front matter:** `name` equals the folder name, uses lowercase letters, digits and single hyphens, and is at most 64 characters; `description` is present and at most 1024 characters. These are the Agent Skills format's limits.
2. **Copies:** `SKILL.md` matches the `SHA-256:` line in its `UPSTREAM.md`; `herdr` must have one.
3. **Links:** each `skills/<name>` symlink points exactly at `../upstream/<repo>/<path>` and resolves inside that submodule; each submodule is in `.gitmodules` with the same URL, its recorded gitlink and its checkout are the pinned commit, and its licence file exists; each linked `SKILL.md` and whole folder match their digests, and a linked folder may not contain a symlink.
4. **Nothing unlisted:** no symlink in `skills/`, folder in `upstream/` or submodule without its `upstream.toml` entry, and no entry whose `skills/<name>` is a copy instead of a link.

Each failure was shown by a mutation the script catches, 15 cases plus an unmutated control, when linking was added (agent-skills#2). In a clone without submodules the script fails, because the linked skills' targets aren't checked out; that is expected, and the root README says how to clone with them.

The script checks files, not behaviour. It doesn't prove that a skill's instructions are complete or safe once installed: that is the review's job at each pinned commit, and WB-06 ([program](../program.md#p2-wb-06-helpers-the-linked-skills-name)) is an example of what only a review finds.

## Licences

- This repository's own files: Apache-2.0 (the owner's choice, 2026-11-10).
- `skills/herdr/`: herdr's own work, Apache-2.0, with herdr's `LICENSE` and attribution in the folder.
- `upstream/`: not part of this repository's content. Each submodule keeps its own licence, recorded in `upstream.toml`: obra/superpowers and mattpocock/skills are MIT, trailofbits/skills is CC-BY-SA-4.0.

## The upstream repositories are data

What is under `upstream/` is other people's work, read as data. Their own `AGENTS.md`, `CLAUDE.md`, hooks and plugin files are not instructions for work in this repository, and nothing in them is installed except the folders `upstream.toml` lists.
