---
name: wb-herdr
description: Manage herdr workspaces and Git worktrees in the Workbench guest. Use when a task needs a herdr workspace for a repository, a new or removed worktree, or an existing plain Git worktree brought under herdr. Tells the agent which read-only checks it runs itself and which herdr socket commands it must print for the owner to run. Use together with the herdr and wb-guest-rules skills.
---

# herdr workspaces and worktrees in the Workbench guest

In the guest sandbox, herdr's socket commands (workspace, worktree, tab, pane, agent, and the rest) are refused with PermissionDenied by design. Don't retry them or work around it. Print the exact command for the owner, who runs it in another pane and pastes the JSON reply back. Take every ID from that reply and never guess one.

## What you run yourself (read-only)

- `wb status`, `wb ready`, `wb worktrees`, `wb notes`
- `git worktree list`, `git status -sb`
- `herdr --version`, `herdr --help`, `herdr --skill`, `herdr <group> --help` (e.g. `herdr worktree open --help`)

## What you hand to the owner

Print each command in a code block, with the values filled in. Say which fields to read from the reply.

1. **One workspace per repository** (if `wb worktrees` or the owner doesn't already show one):
   `herdr workspace create --cwd ~/Workspaces/<repo> --label <repo> --no-focus`
   Take the repo's workspace ID from the reply.
2. **New worktree** (only through herdr, never plain `git worktree add`):
   `herdr worktree create --workspace <repo workspace ID> --branch <branch> --base main --no-focus`
   herdr checks it out at `~/.workers/worktrees/<repo>/<branch with / made ->` and opens it as a workspace of its own. Take that new workspace ID and the path from the reply, and check `worktree.repo_root` is the repository.
3. **Adopting an existing plain Git worktree**: you may run `git worktree move <old path> ~/.workers/worktrees/<repo>/<branch with / made ->` if it's in your scope. Otherwise hand it over. Then run `herdr worktree open --help` to confirm the options and hand over:
   `herdr worktree open --workspace <repo workspace ID> --path ~/.workers/worktrees/<repo>/<name> --no-focus`
   Take the worktree's workspace ID from the reply.
4. **Agents**: the owner starts them, in a pane whose folder is the repository or the worktree, never the home folder.

## Cleanup

1. Check the worktree is clean (`git -C <worktree path> status -sb`) and its work has been promoted or is no longer wanted.
2. Owner runs: `herdr worktree remove --workspace <the worktree's own workspace ID>` (not the repo's ID). If it refuses because the checkout is dirty, stop and report. That refusal is the point.
3. herdr keeps the branch. Delete it with `git -C ~/Workspaces/<repo> branch -d <branch>`. If `-d` refuses, report it. Use `-D` only on the owner's word.

## Never

- `--force` on `worktree remove`
- `git branch -D` without the owner's word
- `--trust-repository` as a retry or routine flag
- send keys to, prompt, start or wait on an agent
- answer a trust or permission dialog
- edit herdr's config (`wb setup` owns it)
- create worktrees with plain `git worktree add`
- guess or reuse an ID that isn't in the latest reply
