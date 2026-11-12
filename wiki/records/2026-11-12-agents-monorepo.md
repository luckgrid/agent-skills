---
id: AS-REC-2026-11-12-AGENTS-MONOREPO
kind: session
title: Agents monorepo research and direction
summary: "The owner's request, research sources and dispositions behind expanding agent-skills, with Workstation's newer profile direction taking precedence over historical WfOS mechanisms."
status: active
created: 2026-11-12
updated: 2026-11-12
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

- [AS-ADR-0001](2026-11-12-agents-monorepo-decision.md) records the owner-directed scope and rationale.
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
