---
name: wb-herdr
description: Manage herdr workspaces and Git worktrees in the Workbench guest. Use when a task needs a herdr workspace for a repository, a new or removed worktree, or an existing plain Git worktree brought under herdr. Tells the agent which read-only checks it runs itself and which herdr socket commands it must print for the owner to run. Use together with the herdr and wb-guest-rules skills.
---

# herdr workspaces and worktrees in the Workbench guest

In the guest sandbox, herdr's socket commands (workspace, worktree, tab, pane, agent, and the rest) are refused with PermissionDenied by design. Don't retry them or work around it. Print the exact command for the owner, who runs it in another pane and pastes the JSON reply back. Take every ID from that reply and never guess one.

## What you run yourself (read-only)

- `wb status`, `wb ready`, `wb worktrees` (lists Git worktrees, not herdr workspaces), `wb notes`
- `git worktree list`, `git status -sb`
- `herdr --version`, `herdr --help`, `herdr --skill`, `herdr <group> --help` (e.g. `herdr worktree open --help`)

## What you hand to the owner

Print each command in a code block, with the values filled in. Say which fields to read from the reply.

1. **One workspace per repository.** To find it, hand over:
   `herdr workspace list`
   Look in the reply for a workspace whose cwd is `~/Workspaces/<repo>` and take its ID. Only if there isn't one, hand over:
   `herdr workspace create --cwd ~/Workspaces/<repo> --label <repo> --no-focus`
   Take the repo's workspace ID from that reply.
2. **New worktree** (only through herdr, never plain `git worktree add`):
   `herdr worktree create --workspace <repo workspace ID> --branch <branch> --base main --no-focus`
   herdr checks it out at `~/.workers/worktrees/<repo>/<branch with / made ->` and opens it as a workspace of its own. Take that new workspace ID and the path from the reply, and check `worktree.repo_root` is the repository.
3. **Adopting an existing plain Git worktree** is always the owner's job, because `git worktree move` writes the main clone's `.git` and `~/.workers/worktrees`, which the sandbox refuses. Hand over both commands, in order:
   `git -C ~/Workspaces/<repo> worktree move <old path> ~/.workers/worktrees/<repo>/<branch with / made ->`
   `herdr worktree open --workspace <repo workspace ID> --path ~/.workers/worktrees/<repo>/<branch with / made -> --no-focus`
   In herdr 0.9.5 the options of `worktree open` are `[--workspace ID | --cwd PATH] (--path PATH | --branch NAME) [--label TEXT] [--focus] [--no-focus]`. Never add `--trust-repository`. Take the worktree's workspace ID from the reply.
4. **Agents**: the owner starts them, in a pane whose folder is the repository or the worktree, never the home folder.

## Cleanup

1. Check the worktree is clean (`git -C <worktree path> status -sb`) and its work has been promoted or is no longer wanted.
2. Owner runs: `herdr worktree remove --workspace <the worktree's own workspace ID>` (not the repo's ID). If it refuses because the checkout is dirty, stop and report. That refusal is the point.
3. herdr keeps the branch, so delete it with `git -C ~/Workspaces/<repo> branch -d <branch>`. Run this yourself only if your session was started in the main clone. From a session in a worktree it's refused like any write to the main clone's `.git`, so hand it to the owner. If `-d` refuses, report it. Use `-D` only on the owner's word.

## Committing from a worktree

A session started in a herdr worktree may find `git commit` refused, because the worktree's objects live in the main clone's `.git`, outside its folder. If that happens, stop and report it. Don't work around it (no other object store, no copying the repository, no committing from another folder). This is still an open question.

## Never

- `--force` on `worktree remove`
- `git branch -D` without the owner's word
- `--trust-repository` as a retry or routine flag
- send keys to, prompt, start or wait on an agent
- answer a trust or permission dialog
- edit herdr's config (`wb setup` owns it)
- create worktrees with plain `git worktree add`, or run `git worktree move` yourself
- guess or reuse an ID that isn't in the latest reply
