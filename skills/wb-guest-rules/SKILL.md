---
name: wb-guest-rules
description: House rules for any coding agent (Claude Code, Codex, Cursor) working inside the Workbench guest. Use at the start of every task in the guest, and whenever about to edit files, commit, install, fetch, touch credentials, or run herdr commands. Covers edit scope, commit identity, public-repository hygiene, credential paths, what may not be installed or run, handing herdr socket commands to the owner, and stopping on surprises.
---

# Workbench guest rules

These hold for the whole session, whatever the task says, unless the owner explicitly says otherwise.

## Scope

- Edit only the checkout you were started in (a clone under `~/Workspaces/<repo>` or a worktree under `~/.workers/worktrees/<repo>/`). You may also write notes in `~/.workers/notes/` and scratch files in `~/Resources/scratch/`.
- Don't edit herdr's config (`wb setup` owns `~/.config/herdr/config.toml`). Don't edit any harness or skill folder: `~/.claude`, `~/.codex`, `~/.cursor`, `~/.agents`.
- `~/Workspaces` holds only clones. Don't create anything else there.

## Git

- Commit only on the branch you were given. Set the identity on each commit, without changing any config:
  `git -c user.name='Workbench guest' -c user.email='guest@workbench.invalid' commit …`
- Stage explicit paths. Don't use `git add -A` or `git add .`, because the sandbox can show placeholder files that aren't part of the repository.
- In a session started in a herdr worktree, `git commit` may be refused, because the worktree's objects live in the main clone's `.git`, outside its folder. If it is, stop and report it. Don't work around it.
- There's no push credential, so don't look for one. Work leaves the guest only when the owner runs `wb promote <repo> <branch>` on the Mac and pushes from there.

## Public repositories

Assume anything you commit is public. Leave out hostnames, user names, account names, real email addresses, IPs, keys and tokens. Write paths as `~/…`, never `/home/<user>/…`.

## Credentials

Never print, open or search these, or anything named like a token, key or credential:
`~/.ssh`, `~/.config/gh`, `~/.config/cursor`, `~/.codex`, `~/.claude/.credentials.json`, `~/.claude.json`, `~/.pi`.

## Nothing installed, fetched or run headless

- Install nothing: no `npm`, `npx`, `dnf`, `pip`, `herdr update`, `herdr plugin`, `herdr integration install`.
- Don't fetch anything from the network.
- Don't start headless agent runs: no `claude -p`, `codex exec`, `cursor-agent -p`.

## herdr

- You may run `herdr --version`, `--help`, `--skill` and `herdr <group> --help`.
- Socket commands are refused with PermissionDenied by design. Don't retry them or work around it. Print the exact command for the owner, who runs it and pastes the JSON reply back. See the wb-herdr skill.
- Never start, prompt, send keys to or wait on an agent. Never answer a trust or permission dialog.

## Read-only checks you may always run

`wb status`, `wb ready`, `wb worktrees`, `wb notes`, `git worktree list`, `git status -sb`.

## When something goes wrong

On any failure or surprise, stop and explain what you saw. Don't retry automatically and don't look for a workaround.
