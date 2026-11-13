---
id: AS-ADR-0001
kind: decision
title: Expand agent-skills into an agents monorepo
summary: "The owner's decisions (2026-11-12): expand this repository into an agents monorepo, renamed luckgrid/agents; skills become a package; Workstation's wiki is the latest knowledge source; public config defaults here with a private overlay in Groundwork's agent-config repository, the stricter value winning for sandbox settings; Rust after M2, starting with the validator; Claude Code and Codex for the first shared-config proof. The session's own proposals are kept apart."
status: accepted
created: 2026-11-12
updated: 2026-11-12  # after the independent review: owner's decisions separated from the session's proposals; the owner's choices on configuration, overlay rule, Rust timing, proof harnesses and the name; moved from records/ to records/decisions/
related: [AS-REC-2026-11-12-AGENTS-MONOREPO, AS-ARCH-AGENTS-WORKSPACE, AS-RES-AGENTS-LINEAGE, AS-PROGRAM, WS-ADR-0004, GW-ADR-0011, GW-ADR-0014]
---

# Expand agent-skills into an agents monorepo

**Status:** accepted for the owner's decisions below (owner, 2026-11-12). The [session's proposals](#the-sessions-proposals-not-accepted) and the [workspace design](../../architecture/agents-workspace.md) are proposed, not accepted.

## The owner's words

Owner, 2026-11-12, first:

> I think it may be better to expand this into a monorepo (rust moonrepo like the other monorepo workspaces on github) to contain universal agent configs, skills, tools, etc
> skills will become a package (it can use skills.sh cli and/or be a rust create... whatever makes most sense based on community standards)

Then:

> Please record the decision and reasons for converting to an agents monorepo in agent-skills wiki and add additional records/docs/etc to workstation wiki as needed by opening PRs from this session's research/discovery

After the independent review, the owner chose between options a review session offered (the chosen option's label is quoted), then wrote:

> lets go with luckgrid/agents for the name and also with you about overlay rules to replace defaults in sandbox

The complete messages, the options offered and the research are in the [session record](../2026-11-12-agents-monorepo.md).

## The owner's decisions

1. **An agents monorepo.** This repository expands into a monorepo for agent configurations, skills and tools, with Rust and Moon as in Luckgrid's other monorepo workspaces.
2. **Skills become a package.** The owner left the format and installer to "whatever makes most sense based on community standards"; the session's answer is proposal P1 below.
3. **Workstation's wiki is the latest knowledge source.** Knowledge is consolidated here "using workstation wiki as the latest knowledge source"; WfOS and lg-workstreams material is lineage.
4. **Adjacent workspaces stay independent.** Workflow Factory "should remain its own workspace"; WfOS "may/may not be resumed later"; wiki-nest is context only, with no migrations.
5. **Public defaults, private overlay** (chosen: "Public defaults + private overlay"). Public agent configuration defaults live here, and may include generic harness settings with a sandbox baseline. Groundwork's agent-config repository ([GW-ADR-0011](https://github.com/luckgrid/workstation/blob/main/wiki/groundwork/records/decisions/0011-agent-harnesses-and-subscription-logins.md), private) holds the private overlay. Gate A2 checks the combined result.
6. **Stricter wins in the sandbox.** The owner agreed to the review session's suggested rule: for sandbox, deny and permission settings, the overlay may make a default stricter but not looser; deny lists combine; loosening one needs a recorded exception. Other settings in the overlay replace the default.
7. **Rust after M2, validator first** (chosen: "After M2, validator first (Recommended)"). `scripts/check.sh` stays Python through M0 to M2, so Workbench's F1 isn't delayed; then the first Rust crate replaces it, and Moon's guest admission is extended to this repository.
8. **Claude Code and Codex for the first shared-config proof** (chosen: "Claude Code + Codex (Recommended)").
9. **Rename to `luckgrid/agents`** (chosen: "Rename now"; the name in the owner's words above). The owner renames the repository after this decision's PR merges; Workstation's references follow in a separate PR. Wiki IDs keep the `AS-` prefix, since an ID never changes.

The earlier owner decisions on custom skill modules (the modules, own words, credits, removing the linked skills in M0, and the private `site-system` skill in its own repository) are unchanged ([module roadmap](../../program.md)).

## The session's proposals (not accepted)

- **P1, the skills package:** the open Agent Skills format at the repository root, `skills/<name>/SKILL.md`, installed with the existing skills CLI. The root `skills/` folder is where the CLI looks first, so the package needs no path move, no installer re-proof and no change on Workstation's side.
- **P2, each consumer interprets its own configuration:** `ws` observation profiles, Groundwork's environment profiles, Workbench settings and agent configuration stay separate schemas. WS-ADR-0004 (proposed) is a design reference, not evidence that its layering or a secret backend exists.
- **P3, directories only for real work:** the package map in the [workspace design](../../architecture/agents-workspace.md) is created one directory at a time, when each has content.
- **P4, implementation stays proposed:** crate and binary names, configuration fields, the composition of defaults and overlay, and install changes are proved in later work. This decision's PR moves no skill, changes no pin and installs nothing.

## The session's reasons

These are the session's rationale for the owner's direction, not the owner's words.

- Skills depend on operating context: tools, harness capabilities, instructions and hand-offs. Keeping their reusable definitions together makes those relationships reviewable.
- One maintained knowledge collection reduces repeated discovery across the WfOS, Workstreams and Workstation histories, while linking to their actual authorities.
- Instructions written once and placed into each harness's own files avoid conflicting copies.
- A content package keeps the open format and the existing installer; skill users need no Rust.
- Public defaults with a private overlay follow WS-ADR-0004's model (public defaults, private Git sources) and keep private configuration out of a public repository.

## Consequences

- Harness settings that enforce something (sandbox modes, deny rules) can now live in a public repository. They hold no secrets ([GW-ADR-0006](https://github.com/luckgrid/workstation/blob/main/wiki/groundwork/records/decisions/0006-guest-credentials-and-host-promotion.md)), but a change to them changes the guest's protection: gate A2 runs again on the combined result before it reaches `fedora-dev`.
- GW-ADR-0011's stage C installs one pinned agent-config repository today. Combining two pinned sources needs a proposed amendment in Workstation; this decision doesn't make it.
- The rename touches GW-ADR-0014 decision 1, Workbench's `workbench-tools.toml` pin, the guest's clone path (`~/Workspaces/agent-skills`) and the links in both wikis. GitHub redirects the old URLs. Nothing is installed in the guest yet, so no installed skill or lock file has to move.
- The broader scope adds maintenance; each package must stay usable on its own. Workstation records its side separately; this decision doesn't accept or amend its proposed decisions.
