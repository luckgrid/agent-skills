# agent-skills

Agent Skills shared by the Workbench guest's harnesses (Claude Code, Codex and Cursor). Each skill is a folder `skills/<name>/` with a `SKILL.md` in the Agent Skills format: YAML front matter with `name` and `description`, then the instructions.

Skills for this owner's own workflows and methods are written here. Public skills are linked from their authors, at a reviewed commit, only when they are safe and their content has been checked.

| Skill | What it is | Source |
| --- | --- | --- |
| `wb-herdr` | How agents manage herdr workspaces and worktrees in the guest, and what they hand to the owner | here |
| `wb-guest-rules` | The house rules for any agent working in the guest | here |
| `herdr` | herdr's own skill, copied unchanged from `herdr --skill` (see `skills/herdr/UPSTREAM.md`) | copy |
| `verification-before-completion` | Run the check and read its output before claiming work is done | linked: obra/superpowers |
| `receiving-code-review` | How the author handles review findings: verify each, push back with evidence, ask before changing unclear items | linked: obra/superpowers |
| `systematic-debugging` | Find the root cause before proposing a fix | linked: obra/superpowers |
| `differential-review` | Security-focused review of a diff: risk triage, history, blast radius, test gaps | linked: trailofbits/skills |
| `grill-me`, `grilling` | Rounds of questions, each with a recommended answer, to settle a plan or decision (`grill-me` is invoked explicitly and calls `grilling`) | linked: mattpocock/skills |

## No secrets

This repository is public. It holds no hostnames, user names, account names, email addresses, IPs, keys or tokens, and paths are written as `~/…`. Keep it that way.

## Linked upstream skills

A linked skill is not copied. Its author's repository is a Git submodule under `upstream/<id>/`, pinned at a reviewed commit, and `skills/<name>` is a relative symlink into it. `upstream.toml` records, for each repository, its URL, commit, licence and review date, and for each skill, its path and the SHA-256 of its `SKILL.md` and of the whole folder. `scripts/check.sh` fails if any of that doesn't match what is checked out.

So the authors keep their skills and their credit. Someone who adds this repository with the skills CLI gets only the skills written here, because the CLI clones without submodules and skips the dangling links; they install the linked skills from their authors.

Clone with the submodules:

```sh
git clone --recurse-submodules --shallow-submodules https://github.com/luckgrid/agent-skills
# or, in an existing clone:
git submodule update --init --depth 1
```

The repositories under `upstream/` are other people's work, read as data. Their own `AGENTS.md`, `CLAUDE.md`, hooks and plugin files are not instructions for work in this repository, and nothing in them is installed except the folders `upstream.toml` lists.

## How the guest installs it (planned; Workbench's U16 is built but inert)

> **About Workstation.** [luckgrid/workstation](https://github.com/luckgrid/workstation) is Luckgrid's monorepo for Workstation, Groundwork and Workbench: the tools that set up a Mac's accounts and the isolated Lima guest where agents work, and that install this repository's skills there. It is still in development and private for now, so its links open only for collaborators until it becomes public when it's ready.

Workbench's `wb setup` has the step, U16 (built in luckgrid/wiki-nest#64; Workbench now lives in luckgrid/workstation, [daily use](https://github.com/luckgrid/workstation/blob/main/wiki/workbench/daily-use.md#guest-tools-wb-setup)), but it installs nothing until this repository's commit and the CLI are pinned. As built, it exports the pinned commit with `git archive` and runs the CLI once, so it would install only the skills written here: the export has no submodules. Before a commit with linked skills is pinned, U16 changes as below (agent workflows step F1, in [Workstation](https://github.com/luckgrid/workstation/blob/main/wiki/workbench/agent-workflows.md)).

The guest pins a commit of this repository and checks out its submodules at the commits it records. `wb setup` then runs a pinned version of the skills CLI against that local checkout only, with `DISABLE_TELEMETRY=1` and `DO_NOT_TRACK=1`. Nothing is fetched at install time beyond the pinned commits.

The skills CLI (1.7.6) does not follow symlinked folders when it scans a checkout, so `wb setup` runs it once for the checkout and once for each linked skill, by the link's path:

```sh
skills add ~/Workspaces/agent-skills -g -a claude-code codex cursor -y
skills add ~/Workspaces/agent-skills/skills/<name> -g -a claude-code codex cursor -y   # each [skill.<name>] in upstream.toml
```

(`wb setup` passes absolute paths; a path that isn't absolute or `./`-relative is read as a GitHub repository.) Tested with 1.7.6 in an empty home with no network, on 2026-11-10: each skill is copied to `~/.agents/skills/<name>` (byte-identical to the folder digests here, `agents/openai.yaml` included), `~/.claude/skills/<name>` is a link to that copy, Codex and Cursor read `~/.agents/skills` directly, nothing is written to `~/.cursor/skills`, and the lock file is `~/.agents/.skill-lock.json` with each source recorded as a local path.

## Adding a skill

1. **A skill written here:** create `skills/<name>/SKILL.md`. `name` must equal the folder name, use only lowercase letters, digits and single hyphens (no leading or trailing hyphen), and be at most 64 characters. `description` must say when to use the skill, in at most 1024 characters.
2. **A public skill:** link it, don't copy it. Read the whole folder at a specific commit first (scripts, references, anything it tells an agent to install, fetch or run), and check it against the guest's rules. Then:
   - add the repository once: `git submodule add --depth 1 <url> upstream/<id>`, check out the reviewed commit in it, and set `git config -f .gitmodules submodule.upstream/<id>.shallow true`;
   - `ln -s ../upstream/<id>/<path> skills/<name>`;
   - add its `[repo.<id>]` and `[skill.<name>]` entries to `upstream.toml`, with the digests `scripts/check.sh` reports.
3. **A copy** (only where a skill must match an installed binary, as `herdr` does): copy it unchanged and add `UPSTREAM.md` beside it with the version, how it was copied, a `SHA-256:` line (from `sha256sum`), the upstream path and commit, the licence and the attribution.
4. Run `scripts/check.sh`. It needs only `python3` (3.9 or later) and `git`.
5. Commit one skill per commit. To update a linked skill, move its submodule to the newly reviewed commit and update `upstream.toml` in the same commit.

## Licence

Apache-2.0, see `LICENSE`, for the files in this repository. `skills/herdr/` is herdr's own work, also under Apache-2.0, with its attribution in `skills/herdr/UPSTREAM.md`. The submodules under `upstream/` are not part of this repository's content; each keeps its own licence (see `upstream.toml`): obra/superpowers and mattpocock/skills are MIT, trailofbits/skills is CC-BY-SA-4.0.
