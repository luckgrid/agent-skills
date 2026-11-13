---
id: AS-PROGRAM
kind: roadmap
title: Roadmap
summary: "The refactor to fully custom skill modules (owner, 2026-11-12): M0 removes the linked upstream skills and sets the module layout; then workbench, council, multiplex, wiki, grill, design-system, a site-system project skill in that repository, frugal and triage, each written in Luckgrid's own words from a reference list of reviewed skills. The earlier items P1 to P3 are folded into the modules."
status: active
created: 2026-11-12
updated: 2026-11-13  # fourth round: M1 workbench moves to Workstation; the rename done; before that, agents monorepo: the owner's decisions after the independent review, items AG1 to AG3 after M2, M0 unchanged; before that, third round (owner): the open questions answered, the order, triage; before that, second round (owner): council, multiplex, design-system and site-system; before that, the custom-modules refactor (owner, 2026-11-12); before that, P1 to P3 from the wiki's first version
related: [AS-ADR-0001, AS-ARCH-AGENTS-WORKSPACE, AS-STATE, AS-RES-SKILL-REFERENCES, AS-REC-2026-11-12-SKILL-MODULES, GW-ADR-0014, GW-ARCH-WORKBENCH-AGENT-WORKFLOWS, AS-ARCH-SKILL-SOURCES, AS-ARCH-GUEST-INSTALL]
---

# Roadmap

Where things stand is in [STATE](records/STATE.md); this page doesn't restate it. Nothing here reaches the guest until Workbench's step F1 pins a commit of this repository ([guest install](architecture/guest-install.md)). The research and the owner's choices behind this plan are in the [skill modules record](records/2026-11-12-skill-modules.md); the skills each module learns from are listed in [skill references](resources/skill-references.md).

## Agents monorepo (owner, 2026-11-12)

The owner's decisions are in [AS-ADR-0001](records/decisions/0001-agents-monorepo.md): an agents monorepo renamed `luckgrid/agents`, skills as a package, public config defaults here with a private overlay, Rust after M2, and Claude Code and Codex for the first shared-config proof. The proposed layout and proof gates are in the [workspace design](architecture/agents-workspace.md); the [knowledge lineage](resources/agents-knowledge-lineage.md) records the older sources. None of it changes the module IDs, the order below or M0: skills stay at `skills/`.

The agents items come after the modules they would otherwise delay:

- **Rename:** done 2026-11-13 by the owner; Workstation's references follow in its own PR ([step 2](architecture/agents-workspace.md#steps-and-proof-gates)).
- **AG1, after M2:** a Rust validator replaces `check.sh`, with Moon and its pins and the admission note that extends GW-ADR-0016 here. It can run alongside M3 to M9.
- **AG2, after AG1:** shared user-level instructions for Claude Code and Codex, proved in the guest.
- **AG3, after AG2:** settings and a sandbox baseline with the agent-config overlay, the stricter value winning for policy keys; needs GW-ADR-0011's stage C amendment and gate A2 in Workstation.

## The direction (owner, 2026-11-12)

The owner's words: "I prefer having fully custom skill modules instead of maintaining an upstream. Instead there should be a list of useful skills to reference in the wiki and a record/doc that mentions/lists skills used to build on or integrate into these modules."

The owner's choices the same day, when asked:

- **Text:** every module is written in Luckgrid's own words. No upstream text is copied; each module credits the skills it learned from, at pinned commits.
- **Upstream:** the linked upstream skills, their submodules and `upstream.toml` are removed in the first refactor PR (M0). The six skills stay listed as references.
- **The review module's name:** `peer-review` at first; renamed `council` in the second round (below).
- **Tools:** `frugal` ships as instructions first and uses rtk or qmd only where they are already installed. Admitting either tool to the guest is a separate item in Workbench's package catalog.

### Second round (owner, 2026-11-12)

The owner's feedback, word for word, is in the [record](records/2026-11-12-skill-modules.md#second-round-the-owners-feedback-2026-11-12). It changed three things:

- **`council`, not `peer-review`:** review and remediation by several models, each with a different lens, in rounds. The owner chose `council` over `audit` (which reads as a one-off inspection), `crosscheck` and `peer-review`.
- **`multiplex`, not `herdr`:** a name of Luckgrid's own that doesn't clash with herdr's `herdr` skill, for multiplexers and session managers of any kind, with herdr as the default because Workbench uses it.
- **Two new modules:** `design-system` and `site-system`, focused on those repositories' decisions and architecture, so work on them stays on its rails. `site-system` is a **project skill in the site-system repository** (owner's choice), since that repository is private; `design-system` is public and goes here.

### Third round (owner, 2026-11-12)

The owner answered the open questions ([record](records/2026-11-12-skill-modules.md#third-round-the-open-questions-answered-2026-11-12)):

- **The wiki template in public:** `wiki` carries the template's rules in its own words; wiki-nest's `wiki-structure.md` stays the authority it points to.
- **The order:** the `site-system` project skill first, with `design-system`'s rules for consuming releases folded in, then the rest ([order](#order)).
- **`systematic-debugging`:** the owner's words: "how about a broader triage skill module with debug being a part of it, alongside other triage/debug skills". That is M9, `triage`.

### Fourth round (owner, 2026-11-13)

`workbench` moves to Workstation ([record](records/2026-11-12-skill-modules.md#fourth-round-workbench-moves-to-workstation-2026-11-13)). In the owner's words, the module "would/should contain workbench skills inside a single dir", and "it might be better to just migrate workbench skill into workstation repo like how site-system was handled since its very specific to that workspace". Because agents in every repository in the guest need it, the owner chose to ship it with Workbench: installed guest-wide by U16 from Workstation's guest files, not as a project skill that loads only in Workstation's checkout. Workstation's proposed role skills (WC13) become its modes.

## Order

Module numbers are IDs and don't change; the build order is:

1. **M7 `site-system`**, now. It is a project skill in the site-system repository, so agents there get it once it merges, without waiting for Workbench's install step, and it helps the site prototypes due this month. Until M6 exists, it carries `design-system`'s rules for consuming a release.
2. **M0**, the module foundation.
3. **M2 `council`**: with Workbench's own `workbench` skill ([M1](#m1-workbench), now in Workstation), what Workbench's F1 needs. **AG1** follows M2 and can run alongside what comes next ([agents items](#agents-monorepo-owner-2026-11-12)).
4. **M3 `multiplex`**, **M4 `wiki`**, **M5 `grill`**.
5. **M6 `design-system`**; M7 then points to it instead of carrying its rules.
6. **M8 `frugal`**, **M9 `triage`**.

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

**Moved to Workstation (owner, 2026-11-13; [fourth round](#fourth-round-owner-2026-11-13)).** Workbench's own skill, one folder at `packages/workbench/guest/skills/workbench/` in luckgrid/workstation, hashed in `guest.sha256` and installed guest-wide by U16 with `wb setup`. Besides the content below, it takes WC13's role routines (plan, orchestrate, code, write, hand-off) as modes. Once it is installed, `wb-guest-rules` and `wb-herdr` leave this repository. The plan as first written here, kept for the Workstation session:

Replaces `wb-guest-rules` and `wb-herdr`. The guest's house rules, always loaded in the guest, plus references for:

- herdr in the guest: socket commands are refused in the sandbox, so the agent prints each for the owner and takes every ID from the reply (today's `wb-herdr`);
- hand-off: committing only on local branches, `wb promote` and `wb pr` as the owner's steps, the notes folder `~/.workers`;
- what never runs in the guest: installs, headless runs, credential paths, clipboard writes.

**Learns from:** today's two skills (Luckgrid's own); Workbench's agent workflows and GW-ADR-0014. **Follow-up in Workstation:** pages that name `wb-guest-rules` or `wb-herdr`.

## M2: `council`

One module for the whole review loop, replacing the planned `wb-review` and `wb-remediate` and the linked review skills. It is what Workbench's F1 needs, with Workbench's own `workbench` skill, so it comes right after M0. F1's first run uses one reviewer (Codex) and one author (Claude Code); the council's other lenses and models are added as F4's parallel reviewers allow.

**Lenses.** Each reviewer takes one lens (a "hat") and reviews the whole change through it; no reviewer gets a slice of the diff:

| Lens | Asks |
| --- | --- |
| spec | Does it do what the issue, plan or decision asked, and nothing it didn't? |
| standards | Does it follow the repository's README rules, wiki decisions and conventions? |
| correctness | Logic, edge cases, error paths, what breaks for callers |
| security | Trust boundaries, credentials, injection, what the change exposes; scaled to the change's risk, with history and blast radius |
| tests | Does each risky path have a check, and does the gate prove what it claims? |
| lean | Is every line needed: the smallest complete change (`frugal`'s code rules) |
| operability | Does it hold under real load, failure and recovery, and can the owner run it? |

The request mode picks the lenses for a change: every review gets spec, standards and correctness; the rest by risk. Lenses are spread across models where more than one harness is available, so a different model sees each change at least once.

**Modes,** each a reference:

- **request:** pin the fixed point; build one briefing (the diff summary, the spec, the standards) that every reviewer gets word for word, never the author's session; choose the lenses and the models;
- **review:** read-only, on the diff between two named commits, reading the connected code and not only the diff, through one lens; every finding verified before it is reported; severities blocker, major, minor and nit; at most ten findings; one JSON object between markers the skill defines (F1's contract), with the lens named;
- **synthesize:** merge findings that point at the same place and problem; drop speculation without evidence; sort into consensus (several reviewers), single-reviewer and contested;
- **cross-review:** optional: each reviewer sees the synthesis without attribution and agrees, disagrees or adds nuance, with evidence; contested findings settle or stay marked;
- **remediate:** verify each finding against the code before changing anything; push back with evidence where it is wrong; fix blockers and majors, minors where small; one commit per round with the finding IDs; never push and never edit the findings file; print the new head;
- **recheck:** re-review the changed lines and each disposition; stop after the agreed rounds or when no blocker or major is left;
- **verify:** run the check and read its output before claiming anything is done;
- **record:** the reviews word for word, then a remediation section per finding (fixed with its commit, not fixed and why, or an owner question), as Luckgrid's review records do.

Fixed prompts only: text an agent wrote moves to another agent through files, never typed into its prompt (GW-ADR-0014 decision 5), and only the owner answers a harness's dialogs. Driving several harnesses is `multiplex`'s and `wb-flow`'s job; `council` says what each reviewer does.

**Learns from:** microsoft/vscode-team-kit `council-review` (model-pinned reviewers, consensus, anonymized cross-review); dotnet/fsharp `review-council` (a briefing pack, dimensions × models); Mozilla.ai's Star Chamber (consensus across providers, debate rounds); laststance/skills `x-agents-cross-review` (every agent reviews the full scope through its own perspective); obra/superpowers (requesting, receiving, verification); mattpocock/skills `code-review`; DietrichGebert/ponytail `ponytail-review`; getsentry/skills `code-review` and `security-review`; trailofbits/skills `differential-review` (ideas only, CC-BY-SA-4.0); Anthropic's code-review plugin (ideas only, proprietary terms); and Luckgrid's own review prompts and records.

## M3: `multiplex`

Replaces the copied `herdr` skill. Terminal multiplexers and session managers through one set of workflows, with a reference per backend. The backends are Workbench's [session backends](https://github.com/luckgrid/workstation/blob/main/wiki/workbench/session-backends.md): herdr the default, tmux the fallback, TUIOS under evaluation; herdr-core's `hc` later, if a Core trial starts. Rex is a terminal app, not a backend.

- **Core (`SKILL.md`):** find which backend the agent runs in (`HERDR_ENV=1` for herdr; `TMUX` for tmux; each backend's own marker), read that backend's reference, and stop if there is none; the installed binary's own help or skill is the authority for syntax; never install, update or upgrade a backend; in the guest, `workbench`'s rules decide what may run.
- **Workflows (`references/`),** each written once and mapped to every backend that can do it: dispatch and wait (start a named agent, the status vocabulary, prompt and wait, read the result); worktrees (create through the backend so its events fire, the removal order, never force); status labels for active, blocked, hand-off and done; sidecars for long-running observable work; orchestration (fan work out to workers and audit their results before closing a pane, with `council` for review); handing the orchestrator role between harnesses.
- **Backends (`references/<backend>.md`):** herdr first, from the owner's 2026-11-11 decisions: a thin layer that checks `HERDR_ENV=1` and a version floor and defers to `herdr --skill`, with third-party facts only once `herdr <group> --help` confirms them (H1, H3). tmux's covers what it can do (panes, send-keys, capture) and says what it can't (agent status). TUIOS's waits for its evaluation, and keeps off what that evaluation keeps off (Inbox approvals, agent mail, plugins, remote and web).

**Learns from:** herdrdev/herdr's own skill; shunk031/skills, gregbarbosa/skills (no licence, facts only), whamp/skills, dmmulroy/skills, davidondrej/skills, callstack/agent-device `dogfood` (the thin shape), yangyang0507/herdr-skill (no licence; TUI and Core), devarfeen/agent-skills-kit; tmux's manual; TUIOS's documentation; Workbench's session backends page.

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

**The template in public** (owner, 2026-11-12): the module carries the rules of Luckgrid's wiki template in its own words, and points to wiki-nest's `wiki-structure.md` as their authority. Where they disagree, `wiki-structure.md` decides and the module is corrected.

**Learns from:** Karpathy's LLM wiki pattern (raw sources kept unchanged, a wiki the agent maintains, a schema it follows); kfchou/wiki-skills (lint, audit, merge); vanillaflava/llm-wiki-skills (crystallize, integrate); tobi/qmd's search-then-retrieve loop; Luckgrid's wiki template.

## M5: `grill`

Replaces `grill-me` and `grilling`, and adds what `grill-with-docs` does. Modes:

- **grill:** rounds over a design tree; each round asks the whole frontier of questions whose prerequisites are settled, numbered, each with a recommended answer worded so that "yes" accepts it; the agent finds facts itself and the owner makes the decisions; done when the frontier is empty and the owner confirms;
- **with docs:** read the wiki first (`wiki`'s orient), challenge terms against its glossary and decisions, check claims against the code, and write each settled decision down as `wiki` records it: the owner's words, then the rule;
- **choices:** where the harness has a multiple-choice question tool, use it, recommended option first.

**Learns from:** mattpocock/skills `grilling`, `grill-me`, `grill-with-docs` and `domain-modeling`; obra/superpowers `brainstorming`. It comes after `wiki`, since its docs mode writes through `wiki`'s conventions.

## M6: `design-system`

Work on, or with, luckgrid/design-system (public), so changes stay on its rails. Its repository and documentation decide; this module points the agent at them in the right order and carries the rails that are easiest to break:

- consume released artifacts, never repository paths; every surface is `public-preview`, none `public-stable`;
- the cascade layers and what each owns (`ds.tokens`, `ds.base`, `ds.layouts`, `ds.primitives`), with consumer styles in a consumer layer over zero-specificity defaults;
- semantic token roles are public, internal reference values are not; themes remap roles;
- the one public hook vocabulary (the layout and primitive classes and `data-ds-scheme`), every other `data-*` name reserved; no `@scope`; no breakpoints or visual reordering in layouts; page shells stay the consumer's;
- semantic, classless HTML first; native HTML and CSS before shared JavaScript;
- Rust is the contributor and validation substrate only: consuming the CSS never needs Rust; `ds-check` and the browser tests are the gate; every tracked file is classified;
- the published browser-support statement: what is verified and what isn't.

**Modes:** orient (README, `docs/architecture/` in its reading order, the classification files); change (which file and check own a change); consume (how a site takes a release); review lens (the rails as a `council` lens).

**Learns from:** the design-system repository's README and `docs/` (MIT, read at `09199f7`); the Design Tokens Community Group's stable format 2025.10; WCAG 2.2; MDN on cascade layers; vercel-labs/agent-skills `web-design-guidelines` (MIT by its README; it fetches live guidelines, so ideas only); community design-system skills.

## M7: `site-system` (a project skill in site-system)

Built first (owner, 2026-11-12). Lives in the private site-system repository, not here (owner's choice): in `.agents/skills/site-system/` (read by Codex and Cursor), with `.claude/skills/site-system` linking to it for Claude Code. It loads when an agent works in that repository and changes with the code it describes. This repository lists it, and its `CREDITS.md` follows the same rules.

- **Rails:** site-system's README rules (no secrets; no build output in Git; pins only; agents build candidates, only the owner seals, approves, uploads and changes DNS; Zola wrapped, not replaced, with Tera 2 templates; builds write only inside `.build/`; the gate before review; records by the wiki template), BI-ADR-0024's platform decision, and the owner's numbered decisions in its step records.
- **Until M6:** a reference with `design-system`'s rules for consuming a release (the pin, release archives not repository paths, the layers and the public hooks), replaced by a pointer to `design-system` once M6 exists.
- **Modes:** orient (README, wiki STATE, the step records); build and check (`scripts/check.sh`, `site-kit` and its stages); templates (Tera 2 rules); design system (takes `design-system`'s consume mode and the pin); release (what an agent may and may not do).
- **Because it is a project skill:** an agent can edit it in its own working tree, so a session uses the committed version, and changes to it go through review like code.

**Learns from:** site-system's README, wiki and records, and wiki-nest's backend-infrastructure decisions and guides (private); Zola 0.23 and Tera 2 documentation; Cloudflare Pages documentation; spillwavesolutions/creating-zola-static-sites-plugin (MIT).

## M8: `frugal`

Saving tokens without losing substance. Instructions first; tools only when installed. References:

- **output:** answer first, no ceremony, every fact kept, and code, commands, paths and errors exact; never in commits, PRs, docs or records, which stay full prose;
- **code:** the smallest complete change: does it need to exist, is it already in the codebase, the standard library, an installed dependency, one line, then the minimum; never cut validation at trust boundaries, error handling that prevents data loss, security or accessibility; a known shortcut gets a comment saying its limit;
- **tool output:** quiet flags, `--stat`, bounded `head` and `tail`, full output saved to a file on failure so it isn't rerun; rtk's filtered commands when rtk is installed;
- **context:** search before reading, read ranges, not whole files; qmd when installed.

**Learns from:** JuliusBrussee/caveman (output), DietrichGebert/ponytail (code), rtk-ai/rtk (tool output), tobi/qmd (search), mksglu/context-mode (ideas only, Elastic 2.0). Independent measurements found the headline savings smaller than claimed, so the module makes no savings claim of its own ([record](records/2026-11-12-skill-modules.md#what-the-measurements-say)).

**Tools, later and elsewhere:** admitting rtk (a binary with agent hooks; its telemetry is off by default) and qmd (an npm package that downloads local models) to the guest are separate items for Workbench's package catalog, each with its own review. Neither CLI of caveman or ponytail is installed: they are not needed for the instructions, and caveman's CLI sends usage stats by default.

## M9: `triage`

The owner's idea (2026-11-12): a broader triage module, with debugging part of it, alongside other triage and debugging skills. It takes over `systematic-debugging`'s job when M0 removes it. Modes:

- **intake:** what came in (an issue, a PR, an alert, a failing check, a report); its impact; whether it reproduces; duplicates and links; who decides. Nothing is labelled, closed or commented on without the owner's word.
- **debug:** build a feedback loop that fails first; reproduce and minimise; one hypothesis at a time, each tested; instrument; the root cause before any fix; the fix once, in the shared code, after reading every caller; a regression check; the instrumentation removed. After a set number of failed hypotheses, stop and report what was ruled out.
- **isolate:** bisect commits; find which test pollutes another; timing and flaky failures, waited on by condition, not by sleeping.
- **queue:** go through open issues, PRs and dependency bumps: categories, duplicates, stale items, linked PRs, risk. Present the plan, and apply it only on the owner's word.
- **incident:** stop and keep the evidence word for word, contain, then record; never retry automatically.
- **hand-off:** a brief another agent can act on, or the fix sent to `council`.

**Learns from:** obra/superpowers `systematic-debugging` (with its root-cause tracing, condition-based waiting and polluter-finding helpers, read as ideas); mattpocock/skills `diagnosing-bugs` and `triage`; getsentry/skills `find-bugs` and `triage-frontend-issues` (plan, then apply on approval); rtk-ai/rtk's `issue-triage` and `pr-triage`; DietrichGebert/ponytail `ponytail-debt` (tracking deliberate shortcuts); Luckgrid's stop-on-surprise rule and incident records.

## Each module's done-when

- `SKILL.md`, its references and `CREDITS.md`; `check.sh` passes;
- the owner sees it listed in Claude Code and Codex in the guest, once U16 installs it;
- an independent review by a different model, with each finding dispositioned;
- a record of the module, its review rounds and the owner's decisions.

`site-system`'s are the same, in the site-system repository, with its own gate (`scripts/check.sh` there) and its records in its wiki.

## Open questions for the owner

None open: the three from the first rounds were answered on 2026-11-12 ([third round](#third-round-owner-2026-11-12)).

## After the modules

- More modules as they are needed, the same way: a reference list entry first, then a module in Luckgrid's words.
- Keeping references current: an upstream that changes is re-read at a new commit, and the module is changed only if what it learned has changed.

## Earlier items (until 2026-11-12)

Kept so that the records' links still resolve. Each is now part of a module.

### P1: a thin herdr skill

The owner's decision 1 of 2026-11-11. Now part of [M3](#m3-multiplex).

### P1b: confirmed facts in `wb-herdr`

The owner's decision 3 of 2026-11-11. Now part of [M3](#m3-multiplex): third-party facts go into its herdr reference once `--help` confirms them.

### P2: WB-06, helpers the linked skills name

Gone with the linked skills in [M0](#m0-the-module-foundation): `council` is self-contained, so it names no helper it doesn't provide.

### P3: the review and remediation skills (F1)

`wb-review` and `wb-remediate` become modes of [M2](#m2-council), keeping F1's contract.

### Later

The earlier "later" items: Workbench's own security and thinking skills are [M2](#m2-council)'s security lens and [M5](#m5-grill); Cursor joins review loops after its herdr hand-off gate (F4), unchanged; keeping linked skills current is replaced by keeping references current.
