---
id: AS-ADR-0001
kind: decision
title: Expand agent-skills into an agents monorepo
summary: "Expand this workspace to hold reusable agent configurations, skills and tools; consolidate their knowledge here using Workstation's wiki as the latest source, while preserving component ownership and independent workspaces."
status: accepted
created: 2026-11-12
updated: 2026-11-12
related: [AS-REC-2026-11-12-AGENTS-MONOREPO, AS-ARCH-AGENTS-WORKSPACE, AS-RES-AGENTS-LINEAGE, AS-PROGRAM, WS-ADR-0004]
---

# Expand agent-skills into an agents monorepo

## Owner's direction

Owner, 2026-11-12:
> I think it may be better to expand this into a monorepo (rust moonrepo like the other monorepo workspaces on github) to contain universal agent configs, skills, tools, etc
> skills will become a package (it can use skills.sh cli and/or be a rust create... whatever makes most sense based on community standards)

The follow-up explicitly requested recording the decision and opening PRs:
> Please record the decision and reasons for converting to an agents monorepo in agent-skills wiki and add additional records/docs/etc to workstation wiki as needed by opening PRs from this session's research/discovery

The complete owner messages and the research dispositions are in the [session record](2026-11-12-agents-monorepo.md).

## Decision

1. **Expand this workspace into an agents monorepo.** It holds reusable agent configurations, skills, tools and the documentation that explains them. Skills become a content package within that workspace. Rust and Moon follow the existing Luckgrid workspace direction; native formats remain authoritative beneath them.
2. **Consolidate knowledge with provenance.** Use Workstation's current wiki as the latest knowledge source for profiles, providers and authority boundaries. Earlier WfOS and lg-workstreams material supplies lineage and reusable ideas, not automatically inherited contracts. New agents-specific decisions belong in this wiki.
3. **Keep configuration interpretation with its owner.** Shared sources and projections do not turn Workstation's observation profiles, Groundwork's environment profiles, Workbench settings and agent configurations into one schema or enforcement system. Workstation's proposed WS-ADR-0004 is a design reference, not evidence that its layering or secret backend has shipped.
4. **Keep adjacent workspaces independent.** Workflow Factory remains its own work-in-progress workspace. WfOS may or may not resume after Workstation's development, testing and open-source publication; the agents workspace must work without that resumption. wiki-nest remains the slimmer wiki incubator for workspaces that do not yet exist. No migration of those systems is part of this decision.
5. **Preserve the custom-module decisions.** The modules, original wording, credits, removal of linked upstream skills, and project-local placement of the private site-system skill remain as recorded in the [module roadmap](../program.md). Broader scope does not move private project skills or operational data into this public repository, or authorize importing upstream implementations.
6. **Separate direction from implementation approval.** This decision records the expansion and its reasons. The package paths, crate/binary names, profile schemas, adapter behavior, repository rename and installation changes remain proposals to prove in subsequent work. This documentation change moves no skill, changes no pin and installs nothing.

## Reasons

- Skills already depend on operating context: selected tools, harness capabilities, instructions, prompts and handoffs. Housing their reusable definitions together makes those relationships reviewable.
- One maintained knowledge collection reduces repeated discovery across the WfOS, Workstreams and Workstation histories while retaining links to their actual authorities.
- Shared intent can be authored once and projected into native agent formats without maintaining conflicting copies of the same instructions.
- A content package preserves the open Agent Skills format and existing installers. A Rust contributor tool is justified by concrete validation or projection work, rather than making skill consumption require compilation.
- Moon can check both content and Rust in one workspace while Cargo continues to own Rust builds. Repository co-location does not combine release privileges or runtime trust.
- Workstation's newer, narrower contracts keep this consolidation practical: portable references, local bindings, native facts and rebuildable views instead of a new universal registry or runtime.

## Consequences and tradeoffs

The agents workspace will need explicit package interfaces and compatibility evidence. A shared profile can still diverge when a harness lacks a setting; unsupported behavior must be reported rather than silently weakened. Private source accessibility and secret resolution remain environment decisions. Additional abstraction earns its place through a working use case.

The broader scope increases maintenance responsibility, so packages remain independently usable and new directories are created only when they contain actual work. The [workspace design](../architecture/agents-workspace.md) records the proposed structure and proof gates. Workstation records its own relationship separately; this decision does not accept or amend its proposed decisions.
