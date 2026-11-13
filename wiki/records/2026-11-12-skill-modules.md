---
id: AS-REC-2026-11-12-SKILL-MODULES
kind: research
title: Planning the custom skill modules (2026-11-12)
summary: "The owner asked to replace linked upstream skills with fully custom modules (workbench, grill, frugal, peer-review, herdr, wiki) and a reference list. A cloud session rechecked the skills in records and chat history, read 21 candidate repositories at pinned commits and the online evaluations, and asked four questions; the owner chose own words only, removing upstream in the first PR, the name peer-review, and frugal as instructions first. In a second round the same day the owner renamed peer-review to council and herdr to multiplex, and added design-system and a site-system project skill; in a third round the owner answered the open questions and added triage."
status: done
created: 2026-11-12
updated: 2026-11-13  # fourth round: workbench moves to Workstation, with the role routines as modes; before that, third round: the open questions answered; before that, second round: the owner's feedback and choices
related: [AS-PROGRAM, AS-RES-SKILL-REFERENCES, AS-STATE, AS-REC-2026-11-10-LINKED-UPSTREAM-SKILLS, GW-REC-2026-11-11-HERDR-CORE, GW-ADR-0014]
---

# Planning the custom skill modules (2026-11-12)

The plan itself is the [roadmap](../program.md); the list of sources is [skill references](../resources/skill-references.md). This record keeps the ask, the owner's choices, and what the research found.

## The ask (owner, 2026-11-12)

Word for word, in a text block so its formatting is kept:

```text
I want to plan out some updates (program) to the skills. I think I prefer having fully custom skill modules instead of maintaining an upstream. Instead there should be a list of useful skills to reference in the wiki and a record/doc that mentions/lists skills used to build on or integrate into these modules.

What I'm thinking:

* wb-* skills just become workbench and combines them into a single module
* all the grill skills (grill-with-docs should be included) are combined into a custom grill skill that combines the best features, content, etc from many skills (the ones with docs would be useful for reading wikis and absorbing context)
* using skills like ponytail, rtk, qmd, etc to save token costs should be consensed into a single module (frugal?)
* all review skills should become a single skill module as well - taking the best parts of all the different skills to capture a precise review workflow using methods, techniques, tools, etc
* herdr skill can expand to capture custom herdr workflows on top of the herdr api skill and other useful herdr skills references in records and discovered online

recheck skills shared in records and session history as well as skills that are evaluated positively online to plan the refactor, having a wiki skill module would be very useful as well
```

## The owner's choices (2026-11-12)

Asked as four multiple-choice questions, each with a recommended option; the owner chose the recommended one each time:

| Question | Owner's choice |
| --- | --- |
| The review module's name, given the built-in `/review` in Claude Code and Codex | `peer-review` |
| How modules reuse other people's skills | Own words, credit ideas: no upstream text copied; each module lists what it learned from where, at pinned commits |
| When the linked upstream skills go | In the first refactor PR |
| How `frugal` treats rtk and qmd | Rules first, tools later: instructions only, using rtk or qmd only when already installed; admitting them to the guest goes through Workbench's package catalog separately |

## What the records and session history hold

- **This repository:** the six linked skills (agent-skills#2), the copied `herdr`, and Luckgrid's own `wb-herdr` and `wb-guest-rules`; the planned `wb-review` and `wb-remediate` with their F1 contract; WB-06.
- **Groundwork's herdr-core record (2026-11-11):** the herdr skills reviewed for the owner's decisions H1 to H3: shunk031/skills, callstack/agent-device `dogfood`, gregbarbosa/skills, whamp/skills, yangyang0507/herdr-skill.
- **Groundwork's agent package catalog:** pi-config's skills (`analyze-sessions`, `pdf-reader`, `youtube-transcript`) and extensions, all **later**; none bears on these modules.
- **Workstation's guest home layout record:** Kilo's `.kilo/` named as a reference for agent configuration in a repository.
- **The owner's project notes:** the kickoffs that specified `wb-guest-rules`, `herdr`, `wb-review` and `wb-remediate`, and the review prompts whose method (severities, finding IDs, verbatim records, rechecks) `peer-review` takes up.
- **Not readable from this session:** the set of skills the owner uploaded for agent-skills#2's review, and its shortlist (`claude/agent-skills-shortlist.md`), are in the Workbench project. Anything in them beyond what agent-skills#2 records is not in this plan, and should be added to the reference list when that project is next open.

## What was read

20 repositories, cloned shallow into an empty folder, read and not run; their commits are in [skill references](../resources/skill-references.md). Licences were read from each licence file:

- **MIT or Apache-2.0:** mattpocock/skills, obra/superpowers, DietrichGebert/ponytail, JuliusBrussee/caveman, rtk-ai/rtk, tobi/qmd, getsentry/skills, herdrdev/herdr, shunk031/skills, whamp/skills, dmmulroy/skills, davidondrej/skills, callstack/agent-device, kfchou/wiki-skills, vanillaflava/llm-wiki-skills.
- **Share-alike:** trailofbits/skills (CC-BY-SA-4.0).
- **Source-available, not open source:** mksglu/context-mode (Elastic License 2.0).
- **Proprietary:** anthropics/claude-code ("All rights reserved", under Anthropic's commercial terms). Its code-review plugin, rated the best review skill online, is not in that repository's tree at `927b6649`.
- **No licence file:** gregbarbosa/skills, yangyang0507/herdr-skill.

Under the owner's choice none of these licences limits the plan, since no text is copied.

Notable from the reads:

- mattpocock's `grill-me` and `grill-with-docs` are each a few lines that call `grilling` (and, for docs, `domain-modeling`), so one `grill` module with modes matches how they already work.
- The Agent Skills specification recommends a `SKILL.md` under 500 lines, references one level deep, and files under `references/` loaded only when needed. The module shape follows it.
- caveman and ponytail both ship hooks and a CLI beside the skill. caveman's CLI sends usage stats by default (commands run, token counts, an install ID, OS and IP, by its README). Neither CLI is needed for the instructions.
- rtk's telemetry is off by default, by its README. qmd runs local GGUF models through node-llama-cpp, so admitting it means admitting model downloads too.

## What the measurements say

The token-saving tools' own numbers and independent tests differ, so `frugal` makes no savings claim of its own:

- **Ponytail:** its README reports 54% fewer lines, 22% fewer tokens and 20% lower cost against the same agent with no skill, the author's own measurements. JetBrains ran 80 paired SkillsBench tasks through Claude Code to test the claim. One writer found the overhead can outweigh the savings on small models, with smaller and sometimes negative savings on Haiku.
- **caveman:** its headline is a 65% cut in output tokens only, and the skill adds about 1 to 1.5k input tokens per turn. JetBrains benchmarked it across 86 real coding tasks and found the savings short of the 65% advertised; one week-long test found real cost savings of 15 to 25%.
- **rtk:** it reports 60 to 90% less token use on common commands, estimated on medium-sized TypeScript and Rust projects.
- **A sceptical view:** one writer argues that token-saving plugins rest on claims without evidence.

Sources: [Ponytail guide (Skillselion)](https://skillselion.com/guides/ponytail-skill-claude-code-guide), [Capital & Compute on JetBrains' test](https://capitalandcompute.net/blog/does-ponytail-cut-claude-code-costs/), [Chase AI](https://chaseai.io/blog/ponytail-skill-claude-code-cheaper-faster), [The New Stack on caveman](https://thenewstack.io/caveman-mode-token-savings/), [Pasquale Pillitteri on caveman](https://pasqualepillitteri.it/en/news/846/claude-code-caveman-mode-token-saving), [caveman docs index](https://docsearch.algolia.com/mcp/docs/repo/juliusbrussee/caveman), [rtk](https://github.com/rtk-ai/rtk), [GoPenAI](https://blog.gopenai.com/token-saving-plugins-are-mostly-stupid-idea-on-tura-4e7186971d90).

## How online evaluations were used

Listings and rankings (skills.sh, Skillselion, Claude Market, Tessl) were used to find candidates, not to rank them: install counts and star counts are popularity, and several listings copy each other. What decided an entry was reading it at a commit. Online ratings named:

- Anthropic's code-review plugin as the top review skill;
- obra/superpowers for review built into the development loop;
- mattpocock's `grill-with-docs` among the most installed skills, over a million installs by two listings;
- several LLM-wiki skills built on Karpathy's pattern, with Tessl scores ranging from well-rated (kvokov/oh-my-ai's `llm-wiki`) to "do not use without reviewing" (one Hermes Agent copy).

## Effect on what was open

- **H1 and H3 (owner, 2026-11-11):** unchanged, and now part of `herdr` (M3).
- **WB-06:** gone with the linked skills in M0.
- **F1's U16 changes for linked skills:** not needed after M0. Workstation's Workbench pages that describe them need a follow-up PR there.
- **`wb-review` and `wb-remediate`:** modes of `peer-review` (M2), with F1's contract kept.
- **The decision of agent-skills#2 to link, not copy:** superseded once M0 merges.

## Second round: the owner's feedback (2026-11-12)

Word for word, after reading agent-skills#5:

```text
some feedback:

* what do you think about using audit instead of peer-review? if that implies something else, let's find a more applicable namespace for review and remediation involving multiple agent models with different lenses/hats to review from diff angles/perspectives (iterate?)
* herdr clashes with existing herdr skill so maybe this can be multiplex instead so it can work with multiplexers and session manager tools of various types, using herdr as a default based on workbench skill and tools
* I want to include a design-system and site-system skill module based on records, knowledge sources, etc from multiple repos, internet, etc to help with site-system and design-system development (these can be focused on decisions, architecture, etc from these 2 repos to help align / stay on rails)
```

### The owner's choices

Asked as two multiple-choice questions; the owner chose the recommended option each time:

| Question | Owner's choice |
| --- | --- |
| The review module's name, offered with the advice that `audit` usually means a one-off inspection (a security or compliance audit, or a full-repo sweep such as ponytail's `ponytail-audit`) rather than review, fix and recheck in rounds | `council`, the name most multi-model review skills use, over `crosscheck`, `audit` and keeping `peer-review` |
| Where the `site-system` module lives, since site-system is private and this repository is public | A project skill in the site-system repository (`.agents/skills/`, with a link in `.claude/skills/` for Claude Code), listed here; `design-system` is public and goes here |

`multiplex` was taken as the owner proposed it.

### What this round read

- **Multi-model review skills:** microsoft/vscode-team-kit's `council-review` (MIT, `60a489a9`); dotnet/fsharp's `review-council`, ktaletsk/council, mikeng-io's `deep-council` and laststance's `x-agents-cross-review` (by their listings; the dotnet and laststance skills were not at the paths listed, and ktaletsk and mikeng-io have no licence file); Mozilla.ai's post on its Star Chamber. They share one pattern: one briefing for every reviewer, model-pinned reviewers in parallel, a synthesis into consensus, single and contested findings, and an optional cross-review. `council` takes that pattern and adds lenses.
- **Session backends:** Workbench's page (herdr default, tmux fallback, TUIOS evaluating; Rex not a backend), which `multiplex` follows.
- **design-system:** its README and `docs/architecture/` at `09199f7` (public, MIT, `0.1.0-preview.1`); the Design Tokens Community Group's first stable format, 2025.10; vercel-labs' `web-design-guidelines` (MIT by its README, no licence file; it fetches guidelines live) and community design-system skills, by their listings.
- **site-system:** its README's rules 1 to 8 and its wiki; BI-ADR-0024 in wiki-nest; spillwavesolutions' Zola skill (MIT, `d8ec459d`).

### Effect

- M2 is `council`, M3 is `multiplex`; the owner's herdr decisions H1 and H3 hold for `multiplex`'s herdr reference.
- New: M6 `design-system` here, and M7 `site-system` in the site-system repository. `frugal` becomes M8.
- An open question for the owner: whether `design-system` and `site-system` come right after M0, since the site prototypes are due this month.

## Third round: the open questions answered (2026-11-12)

The owner asked to be walked through the open questions, and they were put as three multiple-choice questions, each with its context and a recommended option:

| Question | Owner's answer |
| --- | --- |
| Should `wiki`, in this public repository, carry the rules of the wiki template, which live only in private wiki-nest? | "Publish the rules (Recommended)": the module carries them in its own words, and `wiki-structure.md` stays the authority |
| Which modules first, given the site prototypes due this month, that the `site-system` project skill reaches agents without Workbench's install step, and that F1 needs `workbench` and `council`? | "site-system skill first (Recommended)": the project skill now, with `design-system`'s rules for consuming releases folded in, then M0, `workbench`, `council` and the rest |
| `systematic-debugging` leaves in M0 and no module takes it: plan a `debug` module, fold it into `council`, or drop it? | Typed, word for word: "how about a broader triage skill module with debug being a part of it, alongside other triage/debug skills" |

### What the triage answer drew on

Read at the commits already listed: obra/superpowers' `systematic-debugging` and its helper notes; mattpocock's `diagnosing-bugs` and `triage`; getsentry's `find-bugs` and `triage-frontend-issues`; rtk's `issue-triage` and `pr-triage`; ponytail's `ponytail-debt`. They split into debugging a failure (a loop that fails first, the root cause before a fix) and triaging a queue (classify, find duplicates, plan, apply on approval). `triage` holds both, with intake, isolate, incident and hand-off modes around them.

### Effect

- The roadmap has an [order](../program.md#order): M7 first, then M0, M1, M2, M3, M4, M5, M6, M8, M9.
- M9 `triage` is new; `systematic-debugging` goes to it.
- No owner question is left open in the roadmap.

## Fourth round: `workbench` moves to Workstation (2026-11-13)

Workstation's proposed agent roles (WC13, 2026-11-13) listed `wb-plan`, `wb-orchestrate`, `wb-code` and `wb-write` as new skills in this repository, while this roadmap folds `wb-*` skills into modules. Asked which way, the owner wrote, word for word:

> to answer your question and clarify:
> the skill module would/should contain workbench skills inside a single dir, the different uses/commands/assets/resources/etc can be defined inside that workbench skill folder. Thinking about it, it might be better to just migrate workbench skill into workstation repo like how site-system was handled since its very specific to that workspace

The session pointed out that, unlike `site-system`, the `workbench` skill is needed by agents in every repository in the guest, and a project skill in Workstation loads only inside that checkout. It offered three ways; the owner chose "Ship it with Workbench (Recommended)": the skill's source is in Workstation's `packages/workbench/guest/skills/workbench/`, hashed in `guest.sha256` and installed guest-wide by U16 with `wb setup`, versioned with `wb` and with no extra pin. The other options were a Workstation project skill only, and keeping M1 here.

### Effect

- M1 `workbench` leaves this repository's build order; it is written in a Workstation session. One folder holds the guest's house rules, the herdr hand-offs and the role routines (plan, orchestrate, code, write, hand-off) as its modes and references.
- M2 `council` follows M0 directly and stays here; F1 needs both `workbench` (in Workstation) and `council`.
- `wb-guest-rules` and `wb-herdr` leave this repository once Workbench's skill is installed in the guest, so the guest never has both.
- GW-ADR-0014's "one skills repository" becomes two sources; that change is Workstation's.
