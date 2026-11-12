---
id: AS-PROGRAM
kind: roadmap
title: Roadmap
summary: "The refactor to fully custom skill modules (owner, 2026-11-12): M0 removes the linked upstream skills and sets the module layout; then workbench, peer-review, herdr, wiki, grill and frugal, each written in Luckgrid's own words from a reference list of reviewed skills. The earlier items P1 to P3 are folded into the modules."
status: active
created: 2026-11-12
updated: 2026-11-12  # the custom-modules refactor (owner, 2026-11-12); before that, P1 to P3 from the wiki's first version
related: [AS-STATE, AS-RES-SKILL-REFERENCES, AS-REC-2026-11-12-SKILL-MODULES, GW-ADR-0014, GW-ARCH-WORKBENCH-AGENT-WORKFLOWS, AS-ARCH-SKILL-SOURCES, AS-ARCH-GUEST-INSTALL]
---

# Roadmap

Where things stand is in [STATE](records/STATE.md); this page doesn't restate it. Nothing here reaches the guest until Workbench's step F1 pins a commit of this repository ([guest install](architecture/guest-install.md)). The research and the owner's choices behind this plan are in the [skill modules record](records/2026-11-12-skill-modules.md); the skills each module learns from are listed in [skill references](resources/skill-references.md).

## The direction (owner, 2026-11-12)

The owner's words: "I prefer having fully custom skill modules instead of maintaining an upstream. Instead there should be a list of useful skills to reference in the wiki and a record/doc that mentions/lists skills used to build on or integrate into these modules."

The owner's choices the same day, when asked:

- **Text:** every module is written in Luckgrid's own words. No upstream text is copied; each module credits the skills it learned from, at pinned commits.
- **Upstream:** the linked upstream skills, their submodules and `upstream.toml` are removed in the first refactor PR (M0). The six skills stay listed as references.
- **The review module's name:** `peer-review`, which doesn't collide with Claude Code's and Codex's built-in `/review`.
- **Tools:** `frugal` ships as instructions first and uses rtk or qmd only where they are already installed. Admitting either tool to the guest is a separate item in Workbench's package catalog.

## The module shape

Every module follows the [Agent Skills format](https://agentskills.io/specification) and its progressive disclosure: the name and description load at startup, the whole `SKILL.md` loads when the skill is activated, and files under `references/` load only when a task needs them. The specification says to keep `SKILL.md` under 500 lines and file references one level deep.

```text
skills/<module>/
├── SKILL.md        when to use it, its modes, its hard rules, and which reference to read for each mode
├── references/     one focused file per mode or workflow, loaded on demand
└── CREDITS.md      what the module learned from where: repository, commit, licence, ideas taken
```

- `SKILL.md` is a router: short, always correct, and enough on its own for the module's hard rules.
- `CREDITS.md` names ideas, never copied text. Sources with no licence, a share-alike licence (CC-BY-SA-4.0), a source-available licence (Elastic 2.0) or proprietary terms are read for ideas only, as every source is under the owner's choice.
- A module that needs a tool says so in `compatibility`, checks that the tool is installed, and never installs it.
- The public repository's rules still hold: no hostnames, account names, emails, IPs, keys or tokens.

## M0: the module foundation

One PR, before any module:

- **Remove the linked skills:** the three submodules under `upstream/`, the six links in `skills/`, `upstream.toml`, and the README's linked-skills sections. Their repositories, commits and licences move to [skill references](resources/skill-references.md).
- **`scripts/check.sh` for modules:** front matter as the specification sets it (name rules including no consecutive hyphens, description at most 1024 characters, `compatibility` at most 500); no symlinks anywhere under `skills/`; every module has `CREDITS.md`; every relative link from `SKILL.md` resolves, one level deep; a warning above 500 lines of `SKILL.md`. The link and submodule checks go.
- **The README:** the rules for writing a module, in place of "Adding a skill".
- **The wiki:** [skill sources](architecture/skill-sources.md) rewritten for modules; [guest install](architecture/guest-install.md) loses the F1 submodule changes, since U16's single `skills add` on a `git archive` export works again.
- `wb-herdr`, `wb-guest-rules` and the copied `herdr` stay until their modules replace them.

**Done when:** `check.sh` passes in a clone without submodules, with no `upstream/` left; the reference list has every removed skill.

**Effect on open items:** WB-06 (helpers the linked skills name) is gone with the linked skills; F1 no longer needs the submodule export or one `skills add` per linked skill. Workstation's Workbench pages that describe those F1 changes get a follow-up PR there.

## M1: `workbench`

Replaces `wb-guest-rules` and `wb-herdr`. The guest's house rules, always loaded in the guest, plus references for:

- herdr in the guest: socket commands are refused in the sandbox, so the agent prints each for the owner and takes every ID from the reply (today's `wb-herdr`);
- hand-off: committing only on local branches, `wb promote` and `wb pr` as the owner's steps, the notes folder `~/.workers`;
- what never runs in the guest: installs, headless runs, credential paths, clipboard writes.

**Learns from:** today's two skills (Luckgrid's own); Workbench's agent workflows and GW-ADR-0014. **Follow-up in Workstation:** pages that name `wb-guest-rules` or `wb-herdr`.

## M2: `peer-review`

One module for the whole review loop, replacing the planned `wb-review` and `wb-remediate` and the linked review skills. It is what Workbench's F1 needs, so it comes right after `workbench`. Modes, each a reference:

- **request:** pin the fixed point; hand the reviewer a crafted context (the diff, the spec, the repository's standards), never the author's session;
- **review:** read-only, on the diff between two named commits, reading the connected code and not only the diff; two axes, the spec and the repository's standards; checked in order of importance, correct, safe, holds under load, tested, fast, lean; a security pass scaled to the change's risk (history, blast radius, test gaps); every finding verified before it is reported, to keep false positives out; severities blocker, major, minor and nit; at most ten findings; one JSON object between markers the skill defines (F1's contract);
- **remediate:** verify each finding against the code before changing anything; push back with evidence where it is wrong; fix blockers and majors, minors where small; one commit per round with the finding IDs; never push and never edit the findings file; print the new head;
- **recheck:** re-review the changed lines and each disposition; stop after the agreed rounds or when no blocker or major is left;
- **verify:** run the check and read its output before claiming anything is done;
- **record:** the review word for word, then a remediation section per finding (fixed with its commit, not fixed and why, or an owner question), as Luckgrid's review records do.

**Learns from:** obra/superpowers (requesting, receiving, verification), mattpocock/skills `code-review`, DietrichGebert/ponytail `ponytail-review`, getsentry/skills `code-review` and `security-review`, trailofbits/skills `differential-review` (ideas only, CC-BY-SA-4.0), Anthropic's code-review plugin (ideas only, proprietary terms), and Luckgrid's own review prompts and records.

## M3: `herdr`

Replaces the copied `herdr` skill. The owner's 2026-11-11 decisions still hold: the core is a thin skill of Luckgrid's own that stops unless `HERDR_ENV=1`, checks a version floor, defers to the installed binary's `herdr --skill` and never upgrades herdr; it covers the herdr TUI, not herdr-core's `hc`; facts from third-party herdr skills go in only once `herdr <group> --help` confirms them. In the guest, `workbench`'s rules decide what may run. On top of the core, workflow references:

- dispatch and wait: starting a named agent, the status vocabulary, the handles, prompt-and-wait, reading the result;
- worktrees: creating through herdr so its events fire, the removal order, never `--force`;
- tab status labels for active, blocked, hand-off and done;
- sidecars: long-running work kept observable in its own pane;
- orchestration: fanning work out to workers and auditing their results before closing a pane, with `peer-review` for the review step;
- hand-off of the orchestrator role between harnesses.

**Learns from:** herdrdev/herdr's own skill; shunk031/skills, gregbarbosa/skills (no licence, facts only), whamp/skills, dmmulroy/skills, davidondrej/skills, callstack/agent-device `dogfood` (the thin shape), yangyang0507/herdr-skill (no licence), devarfeen/agent-skills-kit.

## M4: `wiki`

Working in Luckgrid's wikis, which follow one shared template. Modes:

- **orient:** the root README, then the wiki's README, STATE and the pages it names, before touching anything;
- **write:** the frontmatter profile, IDs and where each kind of page goes;
- **record:** dated records, the owner's words and evidence word for word, nothing private;
- **decide:** a decision record that gives the owner's words, then the rule recorded from them; immutable once accepted;
- **state:** STATE as the only register of where things stand;
- **crystallize:** a session or chat turned into a record, with nothing from it left unrecorded;
- **lint:** relative links, anchors, `related:` IDs, duplicate IDs, rumdl;
- **query:** answer from the wiki's pages, citing them; qmd when it is installed, else `rg`.

**Learns from:** Karpathy's LLM wiki pattern (raw sources kept unchanged, a wiki the agent maintains, a schema it follows); kfchou/wiki-skills (lint, audit, merge); vanillaflava/llm-wiki-skills (crystallize, integrate); tobi/qmd's search-then-retrieve loop; Luckgrid's wiki template.

## M5: `grill`

Replaces `grill-me` and `grilling`, and adds what `grill-with-docs` does. Modes:

- **grill:** rounds over a design tree; each round asks the whole frontier of questions whose prerequisites are settled, numbered, each with a recommended answer worded so that "yes" accepts it; the agent finds facts itself and the owner makes the decisions; done when the frontier is empty and the owner confirms;
- **with docs:** read the wiki first (`wiki`'s orient), challenge terms against its glossary and decisions, check claims against the code, and write each settled decision down as `wiki` records it: the owner's words, then the rule;
- **choices:** where the harness has a multiple-choice question tool, use it, recommended option first.

**Learns from:** mattpocock/skills `grilling`, `grill-me`, `grill-with-docs` and `domain-modeling`; obra/superpowers `brainstorming`. It comes after `wiki`, since its docs mode writes through `wiki`'s conventions.

## M6: `frugal`

Saving tokens without losing substance. Instructions first; tools only when installed. References:

- **output:** answer first, no ceremony, every fact kept, and code, commands, paths and errors exact; never in commits, PRs, docs or records, which stay full prose;
- **code:** the smallest complete change: does it need to exist, is it already in the codebase, the standard library, an installed dependency, one line, then the minimum; never cut validation at trust boundaries, error handling that prevents data loss, security or accessibility; a known shortcut gets a comment saying its limit;
- **tool output:** quiet flags, `--stat`, bounded `head` and `tail`, full output saved to a file on failure so it isn't rerun; rtk's filtered commands when rtk is installed;
- **context:** search before reading, read ranges, not whole files; qmd when installed.

**Learns from:** JuliusBrussee/caveman (output), DietrichGebert/ponytail (code), rtk-ai/rtk (tool output), tobi/qmd (search), mksglu/context-mode (ideas only, Elastic 2.0). Independent measurements found the headline savings smaller than claimed, so the module makes no savings claim of its own ([record](records/2026-11-12-skill-modules.md#what-the-measurements-say)).

**Tools, later and elsewhere:** admitting rtk (a binary with agent hooks; its telemetry is off by default) and qmd (an npm package that downloads local models) to the guest are separate items for Workbench's package catalog, each with its own review. Neither CLI of caveman or ponytail is installed: they are not needed for the instructions, and caveman's CLI sends usage stats by default.

## Each module's done-when

- `SKILL.md`, its references and `CREDITS.md`; `check.sh` passes;
- the owner sees it listed in Claude Code and Codex in the guest, once U16 installs it;
- an independent review by a different model, with each finding dispositioned;
- a record of the module, its review rounds and the owner's decisions.

## Open questions for the owner

- **The wiki template in public:** `wiki` carries the rules of Luckgrid's wiki template, which is kept in private wiki-nest. Publishing them in this public repository is recommended (they hold nothing private), but it is the owner's call.
- **The order of M4 to M6:** as written, `wiki` before `grill`, since `grill` writes through it, and `frugal` last. `frugal` could go first if token costs are pressing.
- **`systematic-debugging`:** it leaves with M0 and no module takes it. It could become a `debug` module later, or a mode of `peer-review`.

## After the modules

- More modules as they are needed, the same way: a reference list entry first, then a module in Luckgrid's words.
- Keeping references current: an upstream that changes is re-read at a new commit, and the module is changed only if what it learned has changed.

## Earlier items (until 2026-11-12)

Kept so that the records' links still resolve. Each is now part of a module.

### P1: a thin herdr skill

The owner's decision 1 of 2026-11-11. Now part of [M3](#m3-herdr).

### P1b: confirmed facts in `wb-herdr`

The owner's decision 3 of 2026-11-11. Now part of [M3](#m3-herdr): third-party facts go into `herdr`'s references once `--help` confirms them.

### P2: WB-06, helpers the linked skills name

Gone with the linked skills in [M0](#m0-the-module-foundation): `peer-review` is self-contained, so it names no helper it doesn't provide.

### P3: the review and remediation skills (F1)

`wb-review` and `wb-remediate` become modes of [M2](#m2-peer-review), keeping F1's contract.

### Later

The earlier "later" items: Workbench's own security and thinking skills are [M2](#m2-peer-review)'s security pass and [M5](#m5-grill); Cursor joins review loops after its herdr hand-off gate (F4), unchanged; keeping linked skills current is replaced by keeping references current.
