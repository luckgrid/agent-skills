#!/usr/bin/env bash
# Check the front matter of every skills/*/SKILL.md, upstream copies against the
# SHA-256 in their UPSTREAM.md, and linked upstream skills against upstream.toml.
# Needs only python3 (3.9 or later) and git.
set -euo pipefail
root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
exec python3 -I - "$root" <<'PY'
import hashlib, os, pathlib, re, subprocess, sys

root = pathlib.Path(sys.argv[1])
NAME_RE = re.compile(r"^[a-z0-9]+(-[a-z0-9]+)*$")
SHA_RE = re.compile(r"SHA-256:\s*`?([0-9a-f]{64})`?")
HEX40 = re.compile(r"^[0-9a-f]{40}$")
HEX64 = re.compile(r"^[0-9a-f]{64}$")
REQUIRE_UPSTREAM = {"herdr"}
REPO_KEYS = {"url", "commit", "licence", "licence_file", "reviewed"}
REPO_OPTIONAL = {"tag"}
SKILL_KEYS = {"repo", "path", "skill_sha256", "tree_sha256"}
errors = []


def front_matter(path):
    lines = path.read_text(encoding="utf-8").splitlines()
    if not lines or lines[0].strip() != "---":
        return None
    fields = {}
    for line in lines[1:]:
        if line.strip() == "---":
            return fields
        m = re.match(r"^([A-Za-z0-9_-]+):\s*(.*)$", line)
        if m:
            value = m.group(2).strip()
            if len(value) >= 2 and value[0] == value[-1] and value[0] in "\"'":
                value = value[1:-1]
            fields[m.group(1)] = value
    return None


def check_skill(skill):
    folder = skill.parent.name
    where = skill.relative_to(root) if not skill.parent.is_symlink() else pathlib.Path("skills", folder, "SKILL.md")
    fm = front_matter(skill)
    if fm is None:
        errors.append(f"{where}: no front matter between --- lines")
        return
    name = fm.get("name", "")
    if name != folder:
        errors.append(f"{where}: name {name!r} does not match folder {folder!r}")
    if not NAME_RE.match(name) or len(name) > 64:
        errors.append(f"{where}: name {name!r} must be lowercase letters, digits and single hyphens, at most 64 characters")
    desc = fm.get("description", "")
    if not desc:
        errors.append(f"{where}: description missing")
    elif len(desc) > 1024:
        errors.append(f"{where}: description is {len(desc)} characters (max 1024)")


def read_manifest(path):
    """Parse upstream.toml's restricted format: [kind.id] tables, key = "string"."""
    tables, current = {}, None
    for n, raw in enumerate(path.read_text(encoding="utf-8").splitlines(), 1):
        line = raw.strip()
        if not line or line.startswith("#"):
            continue
        m = re.match(r'^\[(repo|skill)\.([a-z0-9]+(?:-[a-z0-9]+)*)\]$', line)
        if m:
            current = (m.group(1), m.group(2))
            if current in tables:
                errors.append(f"upstream.toml:{n}: duplicate table [{current[0]}.{current[1]}]")
            tables[current] = {}
            continue
        m = re.match(r'^([a-z_0-9]+)\s*=\s*"([^"\\]*)"$', line)
        if m and current is not None:
            if m.group(1) in tables[current]:
                errors.append(f"upstream.toml:{n}: duplicate key {m.group(1)}")
            tables[current][m.group(1)] = m.group(2)
            continue
        errors.append(f"upstream.toml:{n}: not a [repo.<id>] or [skill.<name>] table or a key = \"string\" line")
    return tables


def git(*args):
    r = subprocess.run(["git", "-C", str(root)] + list(args), capture_output=True, text=True)
    return r.stdout.strip() if r.returncode == 0 else None


def tree_digest(folder):
    lines = []
    for p in sorted(folder.rglob("*")):
        if p.is_symlink():
            return None, f"contains a symlink: {p.relative_to(folder).as_posix()}"
        if p.is_file():
            lines.append(f"{p.relative_to(folder).as_posix()}\0{hashlib.sha256(p.read_bytes()).hexdigest()}\n")
    return hashlib.sha256("".join(lines).encode()).hexdigest(), None


# 1. Front matter of every skill folder (copies, own skills, and links that resolve).
skills = sorted(root.glob("skills/*/SKILL.md"))
if not skills:
    errors.append("no skills/*/SKILL.md found")
for skill in skills:
    check_skill(skill)
    if skill.parent.is_symlink():
        continue
    upstream = skill.parent / "UPSTREAM.md"
    folder = skill.parent.name
    if upstream.exists():
        m = SHA_RE.search(upstream.read_text(encoding="utf-8"))
        if not m:
            errors.append(f"{upstream.relative_to(root)}: no SHA-256: line")
        else:
            actual = hashlib.sha256(skill.read_bytes()).hexdigest()
            if actual != m.group(1):
                errors.append(f"skills/{folder}/SKILL.md: SHA-256 {actual} does not match UPSTREAM.md {m.group(1)}")
    elif folder in REQUIRE_UPSTREAM:
        errors.append(f"skills/{folder}/SKILL.md: upstream copy needs an UPSTREAM.md")

# 2. Linked upstream skills.
manifest_path = root / "upstream.toml"
tables = read_manifest(manifest_path) if manifest_path.exists() else {}
repos = {k[1]: v for k, v in tables.items() if k[0] == "repo"}
linked = {k[1]: v for k, v in tables.items() if k[0] == "skill"}

if git("rev-parse", "--is-inside-work-tree") != "true":
    errors.append("not a Git work tree: linked skills can't be checked")
    repos, linked = {}, {}

gitmodules = {}
if (root / ".gitmodules").exists():
    out = git("config", "-f", ".gitmodules", "--get-regexp", r"^submodule\..*\.(path|url)$") or ""
    for line in out.splitlines():
        key, value = line.split(" ", 1)
        name, field = key[len("submodule."):].rsplit(".", 1)
        gitmodules.setdefault(name, {})[field] = value

for name in sorted(set(gitmodules) - {f"upstream/{r}" for r in repos}):
    errors.append(f".gitmodules: submodule {name!r} has no [repo.*] entry in upstream.toml")
if (root / "upstream").is_dir():
    for d in sorted((root / "upstream").iterdir()):
        if d.name not in repos:
            errors.append(f"upstream/{d.name}: not listed in upstream.toml")

for rid, repo in sorted(repos.items()):
    where = f"upstream.toml [repo.{rid}]"
    missing = REPO_KEYS - set(repo)
    extra = set(repo) - REPO_KEYS - REPO_OPTIONAL
    if missing:
        errors.append(f"{where}: missing {', '.join(sorted(missing))}")
    if extra:
        errors.append(f"{where}: unknown key(s) {', '.join(sorted(extra))}")
    commit = repo.get("commit", "")
    if not HEX40.match(commit):
        errors.append(f"{where}: commit must be a full 40-character SHA")
    sub = gitmodules.get(f"upstream/{rid}")
    if sub is None:
        errors.append(f"{where}: no submodule at upstream/{rid} in .gitmodules")
        continue
    if sub.get("path") != f"upstream/{rid}" or sub.get("url") != repo.get("url"):
        errors.append(f"{where}: .gitmodules path/url {sub.get('path')!r} {sub.get('url')!r} do not match")
    staged = (git("ls-files", "-s", "--", f"upstream/{rid}") or "").split()
    if len(staged) < 2 or staged[0] != "160000" or staged[1] != commit:
        errors.append(f"{where}: recorded gitlink {staged[1] if len(staged) > 1 else 'none'} is not {commit}")
    sub_root = root / "upstream" / rid
    head = subprocess.run(["git", "-C", str(sub_root), "rev-parse", "HEAD"], capture_output=True, text=True)
    if not (sub_root / ".git").exists() or head.returncode != 0:
        errors.append(f"{where}: submodule not checked out (run: git submodule update --init --depth 1)")
        continue
    if head.stdout.strip() != commit:
        errors.append(f"{where}: upstream/{rid} is checked out at {head.stdout.strip()}, not {commit}")
    if not (sub_root / repo.get("licence_file", "LICENSE")).is_file():
        errors.append(f"{where}: licence file {repo.get('licence_file')!r} missing")

for name, entry in sorted(linked.items()):
    where = f"upstream.toml [skill.{name}]"
    missing = SKILL_KEYS - set(entry)
    if missing or set(entry) - SKILL_KEYS:
        errors.append(f"{where}: keys must be exactly {', '.join(sorted(SKILL_KEYS))}")
        continue
    if entry["repo"] not in repos:
        errors.append(f"{where}: repo {entry['repo']!r} is not a [repo.*] entry")
        continue
    path = entry["path"]
    if path.startswith("/") or ".." in path.split("/"):
        errors.append(f"{where}: path must be relative and stay inside the repository")
        continue
    link = root / "skills" / name
    expected = f"../upstream/{entry['repo']}/{path}"
    if not link.is_symlink():
        errors.append(f"skills/{name}: must be a symlink to {expected}")
        continue
    if os.readlink(link) != expected:
        errors.append(f"skills/{name}: links to {os.readlink(link)!r}, not {expected!r}")
        continue
    target = link.resolve()
    if not target.is_dir() or not (target / "SKILL.md").is_file():
        errors.append(f"skills/{name}: target has no SKILL.md (is upstream/{entry['repo']} checked out?)")
        continue
    sub_real = (root / "upstream" / entry["repo"]).resolve()
    if sub_real not in target.parents:
        errors.append(f"skills/{name}: resolves outside upstream/{entry['repo']}")
        continue
    for key, pattern in (("skill_sha256", HEX64), ("tree_sha256", HEX64)):
        if not pattern.match(entry[key]):
            errors.append(f"{where}: {key} must be 64 hex characters")
    actual = hashlib.sha256((target / "SKILL.md").read_bytes()).hexdigest()
    if actual != entry["skill_sha256"]:
        errors.append(f"skills/{name}/SKILL.md: SHA-256 {actual} does not match upstream.toml {entry['skill_sha256']}")
    digest, problem = tree_digest(target)
    if problem:
        errors.append(f"skills/{name}: {problem}")
    elif digest != entry["tree_sha256"]:
        errors.append(f"skills/{name}: folder digest {digest} does not match upstream.toml {entry['tree_sha256']}")

for link in sorted((root / "skills").iterdir()):
    if link.is_symlink() and link.name not in linked:
        errors.append(f"skills/{link.name}: symlink with no [skill.{link.name}] entry in upstream.toml")
    if not link.is_symlink() and link.name in linked:
        errors.append(f"skills/{link.name}: listed in upstream.toml but is not a symlink")

for e in errors:
    print(f"FAIL {e}")
if errors:
    sys.exit(1)
print(f"ok: {len(skills)} skills checked ({len(linked)} linked from {len(repos)} upstream repositories)")
PY
