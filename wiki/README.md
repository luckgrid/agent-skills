# agent-skills wiki

Start with the repository's root `README.md`: it is the entry point and holds the rules. This wiki holds the details: how the repository works and why, where it stands, what comes next, and the records behind it.

It follows Luckgrid's shared wiki template, the wiki structure kept in luckgrid/wiki-nest (`wiki-structure.md`, private), with IDs prefixed `AS-`. The decisions that bind how the Workbench guest installs these skills are not made here: they are Groundwork's [GW-ADR-0014](https://github.com/luckgrid/workstation/blob/main/wiki/groundwork/records/decisions/0014-shared-skills-and-agent-workflows.md) (proposed) and Workbench's [agent workflows](https://github.com/luckgrid/workstation/blob/main/wiki/workbench/agent-workflows.md), both in luckgrid/workstation, which is still in development and private for now (see the root README's note).

## Reading order

1. [records/STATE.md](records/STATE.md): where the repository stands, what is open, and the decisions in force.
2. [architecture/skill-sources.md](architecture/skill-sources.md): the three kinds of skill (written here, copied, linked), `upstream.toml`, and what `scripts/check.sh` proves.
3. [architecture/guest-install.md](architecture/guest-install.md): how the Workbench guest is to install these skills, what the skills CLI was tested to do, and what has to change before linked skills are pinned.
4. [program.md](program.md): the roadmap.
5. [records/README.md](records/README.md): the dated history, one record per episode.
6. [resources.md](resources.md): the sources behind it.

## Which page decides what

| Question | Page |
| --- | --- |
| The rules for working in this repository (no secrets, how to add a skill, licences) | the root `README.md` |
| Whether and how the Workbench guest installs skills, and with which CLI | Groundwork's GW-ADR-0014 (Workstation) |
| The review-and-remediate workflow these skills serve (step F1 onwards) | Workbench's agent workflows (Workstation) |
| How a linked, copied or own skill is recorded and checked here | [architecture/skill-sources.md](architecture/skill-sources.md) |
| What the guest's install step needs from this repository | [architecture/guest-install.md](architecture/guest-install.md) |
| What is open and what is next | [records/STATE.md](records/STATE.md), then [program.md](program.md) |

## Writing standard

- Non-README pages carry `id`, `kind`, `title`, `summary`, `status`, `created`, `updated` and `related` (IDs, never slugs or paths). IDs here use the `AS-` prefix: `AS-ARCH-…`, `AS-REC-…`, `AS-PROGRAM`, `AS-STATE`, `AS-RESOURCES`. An ID never changes when a page moves.
- **Status lives in one place:** [STATE](records/STATE.md). Other pages link to it instead of restating it.
- **Records keep their history.** A dated record is named for the date its first content happened and keeps its wording; corrections go in a later record or a dated note. Evidence (check output, hashes, the owner's words) is quoted word for word.
- **Label evidence.** Tell apart the owner's decisions, results the owner reported, results a session ran, upstream claims and proposals. A proposal is not acceptance.
- **This repository is public.** The root README's no-secrets rule holds for the wiki too: no hostnames, user or account names, email addresses, IPs, keys or tokens, and paths written as `~/…`. Links to Luckgrid's private repositories are allowed, as the owner decided on 2026-11-12 ([record](records/2026-11-12-workstation-links.md)), and say that they are private.

Checks: `scripts/check.sh` checks the skills, not the wiki. The wiki's Markdown is checked with [rumdl](https://github.com/rvben/rumdl) 0.3.2, the version Luckgrid's other wikis pin, as `rumdl check wiki/`, using the root `.rumdl.toml` (the same settings as site-system's and Workstation's, with `upstream/` excluded, since it is other people's work).
