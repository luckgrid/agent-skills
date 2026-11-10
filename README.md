# agent-skills

Agent Skills shared by the Workbench guest's harnesses (Claude Code, Codex and Cursor). Each skill is a folder `skills/<name>/` with a `SKILL.md` in the Agent Skills format: YAML front matter with `name` and `description`, then the instructions.

| Skill | What it is |
| --- | --- |
| `herdr` | herdr's own skill, copied unchanged from `herdr --skill` (see `skills/herdr/UPSTREAM.md`) |
| `wb-herdr` | How agents manage herdr workspaces and worktrees in the guest, and what they hand to the owner |
| `wb-guest-rules` | The house rules for any agent working in the guest |

## No secrets

This repository is public. It holds no hostnames, user names, account names, email addresses, IPs, keys or tokens, and paths are written as `~/…`. Keep it that way.

## How the guest installs it (planned, not yet built)

The guest pins a commit of this repository. `wb setup` then runs a pinned version of the skills CLI against the local checkout at that commit only, with telemetry off, and installs the skills into each harness. Nothing is fetched at install time beyond the pinned commit.

## Adding a skill

1. Create `skills/<name>/SKILL.md`. `name` must equal the folder name, use only lowercase letters, digits and single hyphens (no leading or trailing hyphen), and be at most 64 characters. `description` must say when to use the skill, in at most 1024 characters.
2. If the skill is copied from upstream, copy it unchanged and add `UPSTREAM.md` beside it with the version, how it was copied, a `SHA-256:` line (from `sha256sum`), the upstream path and commit, the licence and the attribution.
3. Run `scripts/check.sh`. It needs only `python3`.
4. Commit one skill per commit.

## Licence

Apache-2.0, see `LICENSE`. `skills/herdr/` is herdr's own work, also under Apache-2.0, with its attribution in `skills/herdr/UPSTREAM.md`.
