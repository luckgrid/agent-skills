---
id: AS-ARCH-AGENTS-WORKSPACE
kind: architecture
title: Agents workspace and profile boundaries
summary: "The proposed agents monorepo: independently usable content and tools, component-owned profile interpretation, native projections, and a bounded implementation path."
status: proposed
created: 2026-11-12
updated: 2026-11-12
derived_from: AS-ADR-0001
related: [AS-ADR-0001, AS-RES-AGENTS-LINEAGE, AS-PROGRAM, AS-ARCH-GUEST-INSTALL, WS-ADR-0004, WS-ARCH-CONTRACTS]
---

# Agents workspace and profile boundaries

The [decision](../records/2026-11-12-agents-monorepo-decision.md) establishes the expanded scope. This page proposes its implementation; [STATE](../records/STATE.md) holds delivery status. Existing skill paths and installation behavior remain documented in [skill sources](skill-sources.md) and [guest install](guest-install.md).

## Package responsibilities

| Proposed location | Owns | Boundary |
| --- | --- | --- |
| `packages/skills/` | Standard skill modules with `SKILL.md`, references, optional scripts/assets and credits | Content package; consuming instructions does not require Cargo |
| `packages/configs/` | Reusable instructions, agent profile defaults, prompts, command/hook templates and references | No credentials, machine inventory or universal authorization schema |
| `packages/providers/` | Curated descriptions of relevant provider requirements, native settings and supported capabilities | Descriptions are versioned claims; actual availability and native state are queried |
| `packages/adapters/` | Concrete mappings and templates from selected shared intent to supported native configuration | No orchestration framework; implement only a demonstrated mapping |
| `packages/tools/` | Portable agent utilities when an actual reusable tool exists | Existing native tools remain independent; cataloguing one does not install it |
| `crates/agent-kit/` | Candidate Rust contributor CLI for validation, rendering and inspection | Name provisional; start with one crate when functionality warrants it |
| `wiki/` | Agents-specific knowledge, decisions, compatibility evidence and source lineage | Current owning contracts outrank historical descriptions |
| `.moon/` | Task graph and repository checks | Cargo and native manifests keep their own responsibilities |

This is a responsibility map, not a requirement to create empty packages. A content package needs neither `Cargo.toml` nor `package.json`. Introduce a Cargo workspace when actual Rust code exists, using ordinary Cargo conventions and the chosen toolchain's supported resolver. Do not turn a Markdown skill into a Rust crate solely for uniformity.

## Profile sources and consumers

Workstation's [WS-ADR-0004](https://github.com/luckgrid/workstation/blob/main/wiki/records/decisions/0004-profiles-private-sources-and-secret-references.md) is the latest design reference (Workstation is still private and in development). It remains proposed. Its source model is useful here: public defaults versioned with a release; private Git sources referenced by URL/ref and locked to a commit; local bindings; secret references; and attributable resolution.

| Configuration concern | Interpreter and authority |
| --- | --- |
| Tools and harnesses selected for observation | `ws`, using its existing small profile contract |
| Environment provisioning and admitted tool sets | Groundwork and Workbench's owning setup procedures |
| Guest session backend and daily-use settings | Workbench, under its reviewed interfaces |
| Reusable agent instructions and defaults | Agents workspace, projected into an explicitly supported harness |
| Effective model settings, session behavior and authentication | Native harness/provider |
| Access, secret scopes and permissions | OS, sandbox/VM, credentials and native provider policy |
| Workflow execution, queues and continuity | The independently selected runtime or Workflow Factory if adopted |

For configuration values a future consumer supports, WS-ADR-0004 proposes precedence from highest to lowest: flags, environment variables, machine-local bindings, private profile sources, public profiles, built-in defaults. Adoption here must define the supported fields, list/merge behavior, provenance and errors explicitly. Precedence does not authorize widening an environment's enforced access, passing a secret into a guest, or overriding a stricter owning policy.

Profiles hold references to secrets, never literal credentials. Secret backend selection, trust, reachability and allowed scopes remain environment-owned. fnox is Workstation's first evaluation candidate, not an agents dependency or an implemented backend. An unavailable required value must be reported without printing its secret. Rendered configurations and observations are local, rebuildable views; they are not another source of native session state.

## Portable directory and native views

Distinguish the authoring repository, user-level selections, project-local selections and each harness's actual discovery paths. `~/.agents/` and project `.agents/` are useful candidate navigation/install surfaces, not a claim that every harness reads the same directory or merges it the same way.

- Keep actual skill bodies under `skills/<name>/SKILL.md` within a selected content/install root. The final package nesting is proved with the installer before any path moves.
- Keep metadata records under a separately named `catalog/` or `registry/` if needed. Historical Workstreams `.agents/skills/*.toml` records are not installable Agent Skills.
- A project-owned skill stays with its project when it depends on private or tightly coupled project knowledge. The site-system module remains in its own repository.
- Native instruction precedence and project trust still apply. Global defaults must not silently replace repository rules or overwrite user-edited native config.
- A projection needs a staged diff, explicit conflict handling and an identifiable source revision. Unsupported fields are reported; never translate an instruction into a false enforcement claim.

## Provider roles

| Role | What remains native |
| --- | --- |
| Agent harness, such as Pi, Claude Code, Codex or Cursor | Session/process lifecycle, supported settings and permission behavior |
| Model/API provider, such as OpenAI, Anthropic, OpenRouter or Ollama | Endpoint capabilities, available models and authentication |
| Session/workspace provider, such as herdr or tmux | Worktree/session topology and its supported control surface |
| Tool/context provider, such as a CLI, MCP server or search service | Tool execution, data retrieval and service-specific state |

A product can fill several roles. A capability description must name the role and evidence; a binary on PATH establishes presence only. Prefer native structured interfaces, and report unavailable capabilities. A template for a provider does not make it admitted to the Workbench guest or selected in `ws`.

## Skills installer and Rust tooling

Use the open Agent Skills format and the existing skills CLI first. Workbench currently documents tests against CLI 1.7.6; current upstream features cannot substitute for evidence against its pin. Before changing `skills/` to a package path, prove discovery and installation from the exact proposed local export, including references and resources, with no network and an empty destination home. Verify every selected harness's installed files and discovery. Keep telemetry disabled as required by the owning install procedure.

Use Rust for a concrete contributor need: schema validation, deterministic rendering, provenance inspection or a configuration diff. Cargo owns Rust builds and dependencies; Moon runs the checks across packages. Skill users should not need Moon or Rust to read or install plain content. Any host binary, new dependency, install command or pin change follows the owning environment's admission procedure.

## Implementation sequence and proof gates

1. Record the decision, lineage and boundaries in this wiki, with Workstation's matching reference. This is the documentation scope of this session.
2. Extend M0's module foundation with the smallest package layout and Moon tasks, preserving the existing module identities and the site-system priority. Remove upstream links as already decided; retain their research credits.
3. Prove the proposed skills package path with Workbench's pinned installer and export procedure. Update installation docs and Workstation's consumer in a coordinated change before pinning that revision. Do not create compatibility symlinks that contradict M0's no-symlinks rule.
4. Demonstrate one non-secret shared agent configuration through two native harness mappings. Check determinism, precedence, conflicts, unsupported fields and file ownership. Add a Rust CLI only if that proof needs one.
5. Extend private-source and secret-reference support only through explicit contracts and environment tests, coordinated with Workstation's W4 gate. Do not claim W4 passed from a docs merge.

Workflow Factory stays independent and in progress. WfOS resumption remains optional; no Ontarch/Panoply/Takogami package, policy engine, universal graph, hosted registry or continuity store is required by these steps.
