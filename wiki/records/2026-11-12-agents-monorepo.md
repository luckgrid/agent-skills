---
id: AS-REC-2026-11-12-AGENTS-MONOREPO
kind: session
title: Agents monorepo research and direction
summary: "The owner's request, research sources and dispositions behind expanding agent-skills, with Workstation's newer profile direction taking precedence over historical WfOS mechanisms."
status: active
created: 2026-11-12
updated: 2026-11-13  # merged and renamed
related: [AS-ADR-0001, AS-ARCH-AGENTS-WORKSPACE, AS-RES-AGENTS-LINEAGE, AS-PROGRAM, AS-STATE, WS-REC-2026-11-12-AGENTS-MONOREPO]
---

# Agents monorepo research and direction

## Owner's initial request, word for word

> I have a repo for agent-skills: [https://github.com/luckgrid/agent-skills](https://github.com/luckgrid/agent-skills)
> I think it may be better to expand this into a monorepo (rust moonrepo like the other monorepo workspaces on github) to contain universal agent configs, skills, tools, etc
> skills will become a package (it can use skills.sh cli and/or be a rust create... whatever makes most sense based on community standards)
>
> I've mentioned and shared and discuissed concepts for a universal agents dir which can be adapted into this (i.e. tools, providers, etc)

## First research response and its disposition

The session's initial recommendation was a portable toolkit with skills, configs, provider descriptions, adapters and a small optional Rust CLI, with Moon for checks. It identified the Workstreams `.agents/` pattern, a distinction between skill metadata and bodies, and separate harness/model/session/tool provider roles. It recommended standard content formats and installer compatibility checks before moving paths.

Those were recommendations, not a shipped structure or an accepted profile schema. The initial response gave the older Workstreams profile pattern too much weight and described WfOS/Workflow Factory coordination too categorically. The owner then supplied the precedence and independence constraints below. The design now follows Workstation's newer component-owned configuration model, and neither WfOS nor Workflow Factory is a required runtime.

## Owner's follow-up, word for word

> look into workstation repo, the wiki has more recent directions related to profiles which also applies to agents, providers, etc - these concepts were initially founded through wfos wikis/docs in lg-workstreams and carried over in other places as well. This should also be a consolidation of knowledge in a sense as well, using workstation wiki as the latest knowledge source
>
> Please record the decision and reasons for converting to an agents monorepo in agent-skills wiki and add additional records/docs/etc to workstation wiki as needed by opening PRs from this session's research/discovery
>
> workflow-factory is still a work-in-progress that I think should remain its own workspace, wfos may/may not be resumed later after workstation has been open-sourced after current dev and testing completes
>
> wiki-nest is a slimmer replacement for lg-workstreams which contains wikis for workspaces that dont exist yet - it's a more practical version of lg-workstreams in a sense. This is just for context, dont need to worry about migrations, your main focus is the expanded agents monorepo workspace and what you can record there from older repo records, knowledge sources, and session history available here from chat and projects

## Discovery

The inspected baselines were agent-skills `6b02f370bbdd62b12aaddeb81fc7629689f6cd0e` and Workstation `8a02fdfb3ed65d9ae3369a89dca303d69343695d`. The [source register](../resources/agents-knowledge-lineage.md) pins WfOS and Workstreams evidence and describes each source's authority and limits.

1. Workstation's WS-ADR-0004 retains distinct configuration interpreters while proposing public defaults, locked private Git sources, fixed precedence and secret references. Its status remains proposed, with W4's actual proof still required.
2. Workstation's implemented configuration is deliberately smaller: observation selections, portable references and local bindings. Native harnesses own model settings, skills and authentication. Neither old Ontarch permissions nor a broad profile lifecycle should be added back to `ws`.
3. WfOS and its Workstreams consumer distinguish pattern seeds, working navigation records, generated registry data and installed skill bodies. WfOS's agent-configs page also distinguishes machine rendering from agent operating profiles and documents incomplete bridges between them. These are useful lessons, not evidence of universal cross-agent behavior.
4. The archived terminal-augmentation foundation separates profile dimensions and permits bounded native projections while keeping product/profile concerns outside WfOS. Its broad provider workspace is historical research, not a mandate to import forks or build a platform.
5. Workflow Factory's docs supply provider-neutral workflow and capability boundaries, but contain their own draft contracts and lifecycle. This session preserves its independent work rather than absorbing it.
6. agent-skills already has a newer owner decision for custom modules, including removal of linked upstream skills in M0. This expansion preserves that direction, module identities and private project placement.
7. Earlier chat context described global/repository `.ai/` sources and native views. It is recorded as session lineage only; the repository evidence above supplies the concrete contracts. No chat recollection is used to invent a settled schema or path.

## Recorded outcome

- [AS-ADR-0001](decisions/0001-agents-monorepo.md) records the owner-directed scope and rationale (first written as `records/2026-11-12-agents-monorepo-decision.md`; moved and split into the owner's decisions and the session's proposals after the [review](#the-review-and-the-owners-choices-2026-11-12)).
- [Agents workspace](../architecture/agents-workspace.md) separates the proposed package structure and proof gates from that decision.
- [Knowledge lineage](../resources/agents-knowledge-lineage.md) consolidates source concepts and their present dispositions.
- Workstation receives a corresponding architecture note and session record about typed profiles, native authority and the external agents workspace. Its implementation, W4 acceptance, tool pins and roadmap phase order do not change.

This is documentation work. No repository rename, skill move, package scaffold, native configuration rendering, dependency admission, guest install, publication or migration is performed here. The existing open M7 records work is left separate. Review and delivery evidence for these documentation changes is recorded below when available.

## Author verification (2026-11-12)

- rumdl 0.3.2 formatting and lint were run against the README/wiki Markdown snapshots. For Workstation, filesystem-dependent MD057 is checked against its pinned Git tree instead, since this read-only research snapshot contains Markdown rather than executable payloads.
- YAML/frontmatter checks, duplicate IDs across both wiki snapshots, and relative links, anchors and related/derived IDs on the 19 changed pages passed. The tree-backed check reported:

```text
Checked 116 wiki IDs, 92 relationships and 247 local links/anchors across changed pages against pinned Git trees.
```

- Source code, skills, installation manifests and configuration schemas are outside the changed-file set; Rust/build, skill-install and host/guest runtime suites were not run for this documentation change. No runtime compatibility proof is claimed.
- These are author checks. A fresh independent acceptance review remains separate.

## PR delivery (2026-11-12)

- [agent-skills #7](https://github.com/luckgrid/agent-skills/pull/7): the agents monorepo decision, proposed workspace and knowledge consolidation.
- [Workstation #30](https://github.com/luckgrid/workstation/pull/30): the matching profile ownership note and session record. Workstation is private and in development; this link requires collaborator access.

Both documentation branches are `docs/agents-monorepo-knowledge`, targeting their own repository's `main`. The session opened one PR per repository and performed no merge.

## The review and the owner's choices (2026-11-12)

The owner asked for a critical review of both PRs at agent-skills `3f65f1da6b456f74fcb90ba6fd0f8fc332e8cecb` and Workstation `09107865212e2ea1b98df492516153208b717b37`. It ran in a separate session from the one that wrote them; it is not the owner's acceptance. Its author checks reproduced the ones above (rumdl clean; 116 IDs, no duplicates, no missing related ID on a changed page).

| Finding | Severity | Disposition |
| --- | --- | --- |
| H1: agent configuration already has a planned owner, Groundwork's private agent-config repository (GW-ADR-0011 stage C; GW-ADR-0014 decision 1), and its harness settings hold sandbox and deny rules checked by gate A2 | High | Owner decision: public defaults here, private overlay there; A2 on the combined result ([AS-ADR-0001](decisions/0001-agents-monorepo.md), decisions 5 and 6). Workstation's note and authority map name the relationship |
| H2: AS-ADR-0001 was `accepted` but mixed the owner's decisions with the session's design and reasons | High | Split into the owner's decisions, the session's proposals and the session's reasons; moved to `records/decisions/` |
| M1: moving skills to `packages/skills/` departs from where the skills CLI looks first and creates migration work | Medium | Skills stay at `skills/`; the installer re-proof step is gone |
| M2: M0 had grown (Moon, installer proof) and disagreed with its "Done when"; Moon is admitted for Workstation only | Medium | M0 restored; Rust and Moon are AG1, after M2 (owner decision 7) |
| M3: separate providers, adapters and tools packages duplicate Workstation's catalog, Workbench's session-backend contract and `multiplex` | Medium | Layout trimmed to `skills/`, `configs/<harness>/`, `crates/`, `wiki/` |
| M4: WS-ADR-0004's six-layer precedence was restated without reconciling each harness's own precedence; "profile" was overloaded | Medium | Two pinned layers at composition, user scope only, stricter wins for policy keys; WS-ADR-0004 linked, not restated; "config defaults" |
| M5: lg-workstreams links weren't labelled private | Medium | Labelled in the lineage |
| M6: the lineage pins lg-workstreams `c1c9ef09…`, while Workstation records it as read-only at `1927adfe…` | Medium | Not verified here (private); noted in the lineage as open |
| L1: Workstation's record cites the unmerged commit `942e6d2` | Low | Kept; to be re-pointed to the merge commit after this PR merges |
| L2: the decision sat in `records/` rather than `records/decisions/` | Low | Moved; ID unchanged |
| L3: "optional scripts/assets" in skill modules didn't match the module shape | Low | Removed; the module shape is unchanged |
| L4: Workstation's records index listed the record outside its dated list | Low | Fixed in Workstation's PR |

The owner then wrote: "help me with open decisions please". The session recommended an option for each open decision and asked; the owner chose:

| Question | Options offered | Chosen |
| --- | --- | --- |
| Where agent configuration lives | Keep agent-config separate (recommended); public defaults + private overlay; merge into the agents monorepo | "Public defaults + private overlay" |
| When Rust and Moon come in | After M2, validator first (recommended); in M0; only when a tool needs it | "After M2, validator first (Recommended)" |
| The first shared-config proof | Claude Code + Codex (recommended); Pi + Claude Code; Claude Code + Cursor Agent | "Claude Code + Codex (Recommended)" |
| A rename | Keep the name for now (recommended); rename now; rename at Workstation's public release | "Rename now" |

The session then suggested `luckgrid/agents` as the name, and a rule for the overlay: for sandbox and deny settings, the stricter value wins, deny lists combine, and loosening one needs a recorded exception. The owner's answer, word for word:

> lets go with luckgrid/agents for the name and also with you about overlay rules to replace defaults in sandbox

The session read "with you about overlay rules" as agreeing to that rule, and recorded it as AS-ADR-0001 decision 6; ordinary keys in the overlay replace the default.

## Merged and renamed (2026-11-13)

> **Note (2026-11-13):** this PR merged as `b644bb50cc34f3b636625ca3abef35cdd6714bb3`, and Workstation's as `62b65b7a8370ce2f8e199dbaf5e4dda7546e6242`; both had `main` merged into them first, with the changes above intact. The owner then renamed the repository `luckgrid/agents`; GitHub redirects the old links, so the links above are kept as written. Review finding M6 is settled in the [lineage](../resources/agents-knowledge-lineage.md).
