---
id: AS-RES-AGENTS-LINEAGE
kind: resources
title: Agents knowledge lineage
summary: "Pinned sources and a disposition crosswalk for profiles, providers, skills, tools and native projections, consolidated from Workstation, WfOS and lg-workstreams."
status: active
created: 2026-11-12
updated: 2026-11-13  # lg-workstreams revision settled; before that, after the independent review: lg-workstreams labelled private; the lg-workstreams revision question recorded
related: [AS-ADR-0001, AS-ARCH-AGENTS-WORKSPACE, AS-REC-2026-11-12-AGENTS-MONOREPO, AS-RESOURCES, WS-ADR-0004]
---

# Agents knowledge lineage

This is a curated consolidation of concepts and their dispositions, not a migration of source repositories or an endorsement of every historical mechanism. Workstation's current wiki is the latest source for the shared profile direction and component boundaries. The agents workspace owns its new agent-specific decisions. [STATE](../records/STATE.md) holds delivery status.

## Source order and pinned evidence

All sources below were read on 2026-11-12. Workstation, wiki-nest and lg-workstreams are private; those links require collaborator access. WfOS is public. Their design principles are summarized here without machine inventory, credentials or personal configuration.

| Source | Revision read | Contribution and limits |
| --- | --- | --- |
| [Workstation profiles and secret references](https://github.com/luckgrid/workstation/blob/8a02fdfb3ed65d9ae3369a89dca303d69343695d/wiki/records/decisions/0004-profiles-private-sources-and-secret-references.md) | `8a02fdfb3ed65d9ae3369a89dca303d69343695d` | Latest shared-source direction: proposed public defaults, private Git pins, precedence, secret references, replaceable backend and component-owned interpretation |
| [Workstation configuration](https://github.com/luckgrid/workstation/blob/8a02fdfb3ed65d9ae3369a89dca303d69343695d/config/README.md), [contracts](https://github.com/luckgrid/workstation/blob/8a02fdfb3ed65d9ae3369a89dca303d69343695d/wiki/architecture/contracts.md) and [authority map](https://github.com/luckgrid/workstation/blob/8a02fdfb3ed65d9ae3369a89dca303d69343695d/wiki/architecture/authority-map.md) | Same Workstation revision | Implemented small observation profiles; native model/skills/auth settings; authored/local/observed/generated separation; no generic registry or adapter framework in `ws` |
| [Workstation roadmap](https://github.com/luckgrid/workstation/blob/8a02fdfb3ed65d9ae3369a89dca303d69343695d/wiki/program.md), [repository strategy](https://github.com/luckgrid/workstation/blob/8a02fdfb3ed65d9ae3369a89dca303d69343695d/wiki/records/2026-11-06-repository-strategy.md) and [architecture precedence](https://github.com/luckgrid/workstation/blob/8a02fdfb3ed65d9ae3369a89dca303d69343695d/wiki/records/2026-09-28-architecture-precedence.md) | Same Workstation revision | W4 proof gate and rationale; separates authority transfer from source location; rejects a mandatory Definition/Profile/Plan/Instance lifecycle |
| [WfOS agent configs](https://github.com/luckgrid/wfos/blob/d121990a58bc887f55121055ebd82fb7e8395957/docs/agent-configs.md), [skills](https://github.com/luckgrid/wfos/blob/d121990a58bc887f55121055ebd82fb7e8395957/docs/agent-skills.md) and [agents pattern](https://github.com/luckgrid/wfos/blob/d121990a58bc887f55121055ebd82fb7e8395957/packages/ontarch/patterns/agents/README.md) | `d121990a58bc887f55121055ebd82fb7e8395957` | Shared intent and native app projections; seed vs working copy; metadata vs bodies; progressive loading. Ontarch policy/schema/scan behavior stays with that historical implementation |
| [Workstreams agents navigation](https://github.com/luckgrid/lg-workstreams/blob/c1c9ef09c56cbbda2ed2ca381561c082dd27a49e/.agents/README.md), [profiles](https://github.com/luckgrid/lg-workstreams/blob/c1c9ef09c56cbbda2ed2ca381561c082dd27a49e/.agents/profiles/README.md), [skills](https://github.com/luckgrid/lg-workstreams/blob/c1c9ef09c56cbbda2ed2ca381561c082dd27a49e/.agents/skills/README.md) and [tools](https://github.com/luckgrid/lg-workstreams/blob/c1c9ef09c56cbbda2ed2ca381561c082dd27a49e/.agents/tools/README.md) | `c1c9ef09c56cbbda2ed2ca381561c082dd27a49e` | Concrete consumer of the WfOS pattern; records and generated tool inventory are distinct from installed skill bodies and native tool authority |
| [Terminal augmentation foundation, sections 7 and 13](https://github.com/luckgrid/lg-workstreams/blob/c1c9ef09c56cbbda2ed2ca381561c082dd27a49e/Plan/bin/archives/workbench/terminal-augmentation/lg_terminal_augmentation_system_foundation.md) | Same Workstreams revision | Archived broader dimensions: system, authority, environment, workflow, interface and provider; bounded projections preserve native ownership. A reasoning aid, not a required schema or product scope |
| [Workflow Factory standards](https://github.com/luckgrid/lg-workstreams/blob/c1c9ef09c56cbbda2ed2ca381561c082dd27a49e/Build/bin/workflow-factory/foundation/workflow-pattern-standards.md) and [provider architecture](https://github.com/luckgrid/lg-workstreams/blob/c1c9ef09c56cbbda2ed2ca381561c082dd27a49e/Build/bin/workflow-factory/architecture/provider-capability-model.md) | Same Workstreams revision | Provider-neutral workflow intent; native manifests; separate workspace, execution, presentation and harness roles. Remains independent WIP; its workflow rules are not adopted wholesale |
| [Wiki structure](https://github.com/luckgrid/wiki-nest/blob/main/wiki-structure.md) | Read 2026-11-12; live writing authority | Slim wiki structure, stable IDs, evidence retention, decisions and state. wiki-nest incubates wikis for workspaces without a home; no migration planned here |

**Settled (review M6, 2026-11-13):** lg-workstreams' `main` is `c1c9ef09c56cbbda2ed2ca381561c082dd27a49e`, one commit after `1927adfe32324dfac4166cfab20bceeffb446f2a`, the read-only pin Workstation records (WS-REC-LG-WORKSTREAMS-FREEZE, now with a note). That commit changes only operational documents outside the planning and build areas; `Plan/bin/workflow-factory` and `Build/bin/workflow-factory` are identical in both, so the rows above read the same content at either commit. Workstation cites the `Plan/` copy and this page the `Build/` one; they are separate folders, both unchanged.

Pinned links identify what this session read. They do not freeze future knowledge: a later change re-reads the current owning contract and records its new revision before updating the consolidation.

## Concept disposition

| Earlier concept | Retained principle | Current disposition |
| --- | --- | --- |
| One shared operating profile for many apps | Author shared intent once | Keep typed consumers; do not merge Workstation observation, provisioning, agent behavior and workflow authorization |
| Global and repository `.ai/` discussions | Reusable defaults plus local context and native views | Historical session idea; directory name and universal merge behavior were not settled contracts. Propose `.agents/` compatibility only where actually supported |
| Ontarch profile/policy graph | Intent, selections and enforcement must be distinguishable | No policy engine or enforcement claim transferred; native credentials, sandbox and provider mechanisms remain decisive |
| `skills/*.toml` registry | Metadata references are different from executable resources | A catalog can point at `SKILL.md` bodies; use separate locations to avoid colliding with standard skill discovery |
| Generated local toolkit and graph | Mutable facts are queried; derived views are disposable | Do not commit a host inventory or build a second provider state database |
| Machine and agent profile layers | Host target selection differs from agent operating intent | Keep each interpreter and its allowed fields explicit |
| System/authority/environment/workflow/interface/provider dimensions | Profiles can describe different concerns | Vocabulary for decomposition; no requirement for six packages, schemas or runtime layers |
| Workflow templates, commands and hooks | A common contract can have native projections | Reuse the applicable pattern; Workflow Factory retains its own contracts, runtime and backlog |
| Universal provider capability list | Providers can be replaced behind bounded native interfaces | Record only capabilities needed by a demonstrated adapter; no universal ontology or copied API state |
| Custom skill modules | Own prose, focused references and credits | Preserve the existing module decision and priority; earlier linked sources become research references through M0 |

## Community interfaces

- [Agent Skills specification](https://agentskills.io/specification): the portable content format, with `SKILL.md` and optional resources.
- [Vercel skills CLI](https://github.com/vercel-labs/skills): use the existing installer; Workbench's recorded 1.7.6 tests remain the compatibility baseline until its pin changes through review.
- [Cargo workspaces](https://doc.rust-lang.org/cargo/reference/workspaces.html): Rust packages, dependencies and lockfile remain native; content packages do not need Cargo manifests.
- [Moon Rust handbook](https://moonrepo.dev/docs/guides/rust/handbook): Moon orchestrates Cargo tasks rather than replacing Cargo.

These upstream interfaces were researched in this session. They do not prove that any proposed agents layout or adapter works. See the [workspace proof gates](../architecture/agents-workspace.md#steps-and-proof-gates).
