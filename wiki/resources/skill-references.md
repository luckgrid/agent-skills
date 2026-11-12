---
id: AS-RES-SKILL-REFERENCES
kind: resources
title: Skill references
summary: "The skills and tools each custom module learns from, with the repository, the commit read, the licence, what it contributes, and how it may be used: ideas only, since every module is written in Luckgrid's own words (owner, 2026-11-12)."
status: active
created: 2026-11-12
updated: 2026-11-12  # third round: triage; before that, second round: council, multiplex, design-system, site-system
related: [AS-PROGRAM, AS-REC-2026-11-12-SKILL-MODULES, AS-RESOURCES]
---

# Skill references

The list the owner asked for on 2026-11-12: useful skills to learn from, and which module each feeds. Nothing here is installed or copied. Every module is written in Luckgrid's own words, and its `CREDITS.md` names the entries it learned from ([roadmap](../program.md#the-direction-owner-2026-11-12)).

**Commit** is the commit read on 2026-11-12 (a shallow clone, read and not run), unless the entry says otherwise. **Licence** is the repository's licence file. A source with no licence, a share-alike licence, a source-available licence or proprietary terms is marked; under the owner's choice every source is used for ideas only, so the marks matter only if that choice changes.

Re-read an entry at a new commit before a module learns anything new from it.

## `workbench` (M1)

| Source | Licence | Commit | What it contributes |
| --- | --- | --- | --- |
| this repository's `wb-guest-rules`, `wb-herdr` | Apache-2.0 (Luckgrid's) | `9ff8b6c` | The guest's house rules, and herdr socket commands handed to the owner |
| Workbench's agent workflows and GW-ADR-0014 (luckgrid/workstation, private for now) | Luckgrid's | `30b10df` | The rules for agents in the guest, F1 and the hand-off |

## `council` (M2)

| Source | Licence | Commit | What it contributes |
| --- | --- | --- | --- |
| [microsoft/vscode-team-kit](https://github.com/microsoft/vscode-team-kit) `model-council/skills/council-review` | MIT | `60a489a9` | Model-pinned reviewers in parallel, a change summary instead of raw diffs, consensus synthesis, an anonymized cross-review, saving findings to a file |
| dotnet/fsharp `review-council` | MIT (the repository's) | listing only; not in the tree at `59c74772` | A briefing pack every reviewer gets word for word; dimensions × models; dedupe and false-positive filtering; speculation marked low confidence |
| [Mozilla.ai's Star Chamber](https://blog.mozilla.ai/the-star-chamber-multi-llm-consensus-for-code-quality/) (claude-pragma) | not read (the repository wasn't reachable) | the blog post | Consensus across providers: where models agree, disagree and raise unique points; a debate mode in rounds |
| [laststance/skills](https://github.com/laststance/skills) `x-agents-cross-review` | MIT | listing only; not in the repository at `a6cfb827` | Every agent reviews the full scope, no splitting, each through its own perspective; one unified report |
| ktaletsk/council | **no licence** | `bf3c7954` | The same review prompt across Claude Code, Codex, OpenCode and Cursor, then one synthesized report |
| mikeng-io/agent-skills `deep-council` | **no licence** | `f3460300` | Bridges to several model families; scope resolved once, up front |
| [obra/superpowers](https://github.com/obra/superpowers) `requesting-code-review` | MIT | `22f0b463` (v7.0.2) | The reviewer gets a crafted context, never the author's session; review early and often |
| obra/superpowers `receiving-code-review` | MIT | `22f0b463` | Read, restate, verify against the code, evaluate, then respond or push back; one item at a time |
| obra/superpowers `verification-before-completion` | MIT | `22f0b463` | Run the check and read its output before claiming done |
| [mattpocock/skills](https://github.com/mattpocock/skills) `engineering/code-review` | MIT | `4ae2317d` | Two axes, standards and spec, from a pinned fixed point, in parallel fresh-context sub-agents |
| [DietrichGebert/ponytail](https://github.com/DietrichGebert/ponytail) `ponytail-review` | MIT | `96608e07` | Order of importance (correct, safe, holds under load, tested, fast, lean); read the connected code; check before reporting |
| [getsentry/skills](https://github.com/getsentry/skills) `code-review`, `security-review`, `find-bugs` | Apache-2.0 | `e94f2221` | A review checklist (problems, design, tests, long-term impact) and feedback tone |
| [trailofbits/skills](https://github.com/trailofbits/skills) `differential-review` | **CC-BY-SA-4.0** (share-alike) | `e4dd0bb5` | Risk triage scaled to the change, history, blast radius, test gaps |
| Anthropic's code-review plugin for Claude Code | **proprietary** (anthropics/claude-code's terms); not in that repository at `927b6649` | — | Rated the top review skill online: multiple reviewers and filtering false positives before reporting |
| Luckgrid's review prompts and review records (project notes; site-system's and Workstation's records) | Luckgrid's | — | Severities, finding IDs, at most ten findings, dispositions, verbatim review records, rechecks |

## `multiplex` (M3)

| Source | Licence | Commit | What it contributes |
| --- | --- | --- | --- |
| Workbench's session backends page (luckgrid/workstation, private for now) | Luckgrid's | `30b10df` | The backends (herdr default, tmux fallback, TUIOS evaluating), what a backend must do (R1 to R8), and what a TUIOS trial keeps off |
| tmux's manual | ISC | Fedora's package | Panes, `send-keys`, `capture-pane`; no agent status |
| [TUIOS](https://tuios.dev/) documentation | MIT | 0.12.0, read 2026-11-04 (Workbench) | `send-keys`, `capture-pane`, `wait-for`, a JSON protocol on its socket; agent integrations |
| [herdrdev/herdr](https://github.com/herdrdev/herdr) `skills/herdr` (also `herdr --skill`) | Apache-2.0 | `ee5bfb50` (v0.9.5 is `2ecf19a`) | The authority for command syntax; the `HERDR_ENV=1` guard |
| [callstack/agent-device](https://github.com/callstack/agent-device) `skills/dogfood` | MIT | `2deb909e` (H1 read `5a836c05`) | The thin-skill shape: check the environment, then defer to the tool's own help |
| [whamp/skills](https://github.com/whamp/skills) `engineering/herdr` | MIT | `b43491ae` (H1 read `c91b3414`) | Sidecars for persistent, observable work; the maintenance block |
| [gregbarbosa/skills](https://github.com/gregbarbosa/skills) `herdr`, `field-agent`, `field-audit`, `field-handler` | **no licence** | `e79c1a60` | Status vocabulary, the three handles, dispatch and wait idioms, removal order; dispatching with a reporting contract, auditing results before closing panes. Facts only, once `--help` confirms them (H3) |
| [shunk031/skills](https://github.com/shunk031/skills) `herdr/*` | MIT | `42c99d27` (H1 read `469e484b`) | Orchestrating workers in worktree tabs and validating their reports; tab status labels; handing the orchestrator role between Claude Code and Codex; the empty-input guard behind `wb-flow`'s H2 |
| [dmmulroy/skills](https://github.com/dmmulroy/skills) `herdr` | MIT | `86033808` | Background processes such as dev servers; the installed binary as the authority |
| [davidondrej/skills](https://github.com/davidondrej/skills) `herdr` | MIT | `a9d4ad81` | herdr is terminal orchestration, not shared memory: say so when an agent isn't inside herdr |
| [yangyang0507/herdr-skill](https://github.com/yangyang0507/herdr-skill) | **no licence** | `87fef405` | Branching between the herdr TUI and Core, for when a Core trial starts |
| devarfeen/agent-skills-kit `orchestrate-herdr` | not read | listing only | Fanning a spec into worker tabs with test-backed completion |

## `wiki` (M4)

| Source | Licence | Commit | What it contributes |
| --- | --- | --- | --- |
| [Karpathy's LLM wiki gist](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f) | — | the gist | Raw sources kept unchanged, a wiki the agent maintains, a schema it follows; knowledge compiled once, not rediscovered per question |
| [kfchou/wiki-skills](https://github.com/kfchou/wiki-skills) | MIT | `98126172` | init, ingest, query, lint, update; `wiki-audit` (each claim against its cited source) and `wiki-merge` |
| [vanillaflava/llm-wiki-skills](https://github.com/vanillaflava/llm-wiki-skills) | MIT | `ff6f7be1` | `wiki-crystallize` (a session into a page), `wiki-integrate` (index and backlinks), a dated lint report |
| [tobi/qmd](https://github.com/tobi/qmd) `skills/qmd` | MIT | `86d2365d` | Search, then retrieve the full page, then answer from it, citing it; snippets are only leads |
| Luckgrid's wiki template (`wiki-structure.md` in luckgrid/wiki-nest, private) | Luckgrid's | — | The folders, records, frontmatter, checks and decisions every Luckgrid wiki follows |

## `grill` (M5)

| Source | Licence | Commit | What it contributes |
| --- | --- | --- | --- |
| mattpocock/skills `productivity/grilling` | MIT | `4ae2317d` | Rounds over a design tree; the frontier; numbered questions with a recommended answer that "yes" accepts; facts are the agent's job, decisions the user's |
| mattpocock/skills `productivity/grill-me`, `engineering/grill-with-docs` | MIT | `4ae2317d` | Entry points that call `grilling`, and `grilling` with `domain-modeling` |
| mattpocock/skills `engineering/domain-modeling` | MIT | `4ae2317d` | Challenge terms against the glossary, sharpen fuzzy language, test with scenarios, check against code, record decisions as they settle |
| obra/superpowers `brainstorming` | MIT | `22f0b463` | Settling a design before building |

## `design-system` (M6)

| Source | Licence | Commit | What it contributes |
| --- | --- | --- | --- |
| [luckgrid/design-system](https://github.com/luckgrid/design-system) README, `docs/architecture/`, `docs/browser-support.md`, the classification files | MIT | `09199f7` | The rails: release archives, the cascade layers, tokens and themes, the hook vocabulary, classless base, `ds-check`, browser support |
| [Design Tokens Format Module 2025.10](https://www.designtokens.org/tr/2025.10/) (DTCG) | W3C Community Final Specification Agreement | 2025.10, the first stable version | The vendor-neutral token format, if the design system exchanges tokens with tools |
| WCAG 2.2 (W3C) | W3C | 2.2 | Contrast, focus, target sizes for the base and primitives |
| MDN on CSS cascade layers | CC-BY-SA-2.5 (MDN's prose) | — | How layer order and unlayered styles interact |
| [vercel-labs/agent-skills](https://github.com/vercel-labs/agent-skills) `web-design-guidelines` | MIT by its README; no licence file | `1a2c79d4` | A UI review against published interface guidelines, reported as `file:line`. It fetches the guidelines live at each run, so ideas only |
| community `design-system` skills (caidanw/skills, community-access/accessibility-agents, supercent-io/skills-template) | various | listings only | Token layering, accessibility baselines; to be read at a commit before anything is taken |

## `site-system` (M7, a project skill in site-system)

| Source | Licence | Commit | What it contributes |
| --- | --- | --- | --- |
| site-system's README, wiki, STATE and step records (private) | Luckgrid's | `main` when M7 starts | The rails (README rules 1 to 8) and the owner's numbered decisions |
| wiki-nest's BI-ADR-0024 and backend-infrastructure guides 02, 06 and the Pages fallback (private) | Luckgrid's | `main` when M7 starts | The platform decision, the builder, release verification and the launch path |
| Zola 0.23 and Tera 2 documentation | MIT (both projects) | the versions site-system pins | Templates, content, configuration |
| Cloudflare Pages documentation | Cloudflare's | read when M7 starts | Headers, redirects and limits for the launch path |
| [spillwavesolutions/creating-zola-static-sites-plugin](https://github.com/spillwavesolutions/creating-zola-static-sites-plugin) | MIT | `d8ec459d` | A Zola skill's shape: quick start, references per topic. Not Tera 2–specific, so its template advice is checked against site-system's rule 5 |

## `frugal` (M8)

| Source | Licence | Commit | What it contributes |
| --- | --- | --- | --- |
| [JuliusBrussee/caveman](https://github.com/JuliusBrussee/caveman) `caveman` | Apache-2.0 | `3dc497a7` | Answer first, kill ceremony, keep every technical fact; code, commands and errors exact; normal prose for commits, PRs and docs. Its CLI sends usage stats by default and is not installed |
| DietrichGebert/ponytail `ponytail` | MIT | `96608e07` | The smallest complete change, as a ladder; what is never cut; shortcut comments. Its hooks and CLI are not installed |
| [rtk-ai/rtk](https://github.com/rtk-ai/rtk) | Apache-2.0 | `2a786dca` | Filtered command output, and the full output saved to a file on failure. A binary with agent hooks; telemetry off by default. A tool for Workbench's catalog, not a skill |
| tobi/qmd | MIT | `86d2365d` | Local search over Markdown before reading files. An npm package that downloads local models; a tool for Workbench's catalog |
| [mksglu/context-mode](https://github.com/mksglu/context-mode) | **Elastic 2.0** (source-available) | `890a3f6b` | Tool output kept out of context and searched on demand |

## `triage` (M9)

| Source | Licence | Commit | What it contributes |
| --- | --- | --- | --- |
| obra/superpowers `systematic-debugging` (with `root-cause-tracing.md`, `condition-based-waiting.md`, `defense-in-depth.md`, `find-polluter.sh`) | MIT | `22f0b463` | The root cause before any fix, in four phases; tracing back to the source; waiting on conditions, not sleeps; finding the test that pollutes another; stopping when fixes keep failing |
| mattpocock/skills `engineering/diagnosing-bugs` | MIT | `4ae2317d` | A feedback loop that fails first, then reproduce and minimise, hypothesise, instrument, fix with a regression test, clean up; redact before sharing |
| mattpocock/skills `engineering/triage` | MIT | `4ae2317d` | Issues and PRs through triage states; a needs-info template; an agent-ready brief |
| getsentry/skills `find-bugs`, `triage-frontend-issues` | Apache-2.0 | `e94f2221` | Gather every input, map the attack surface, verify, audit before concluding; a triage plan applied only on approval, with a recovery path |
| rtk-ai/rtk `.claude/skills/issue-triage`, `pr-triage` (in French) | Apache-2.0 | `2a786dca` | Open issues and PRs audited by category, duplicates, staleness, linked PRs and risk, then a deeper look at the chosen ones |
| DietrichGebert/ponytail `ponytail-debt` | MIT | `96608e07` | Tracking deliberate shortcuts so they come back up |

## Removed in M0: the linked skills

Kept here so nothing about them is lost. Their review is in the [linked upstream skills record](../records/2026-11-10-linked-upstream-skills.md).

| Skill | Upstream | Commit | Feeds |
| --- | --- | --- | --- |
| `verification-before-completion`, `receiving-code-review`, `systematic-debugging` | obra/superpowers | `22f0b463` (v7.0.2) | `council` (the first two); `triage` takes `systematic-debugging` |
| `differential-review` | trailofbits/skills | `e4dd0bb5` | `council` |
| `grilling`, `grill-me` | mattpocock/skills | `4ae2317d` | `grill` |
