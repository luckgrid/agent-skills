#!/usr/bin/env bash
# Check the front matter of every skills/*/SKILL.md, and upstream copies against
# the SHA-256 in their UPSTREAM.md. Needs only python3.
set -euo pipefail
root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
exec python3 -I - "$root" <<'PY'
import hashlib, pathlib, re, sys

root = pathlib.Path(sys.argv[1])
NAME_RE = re.compile(r"^[a-z0-9]+(-[a-z0-9]+)*$")
SHA_RE = re.compile(r"SHA-256:\s*`?([0-9a-f]{64})`?")
REQUIRE_UPSTREAM = {"herdr"}
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


skills = sorted(root.glob("skills/*/SKILL.md"))
if not skills:
    errors.append("no skills/*/SKILL.md found")

for skill in skills:
    folder = skill.parent.name
    where = skill.relative_to(root)
    fm = front_matter(skill)
    if fm is None:
        errors.append(f"{where}: no front matter between --- lines")
        continue
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

    upstream = skill.parent / "UPSTREAM.md"
    if upstream.exists():
        m = SHA_RE.search(upstream.read_text(encoding="utf-8"))
        if not m:
            errors.append(f"{upstream.relative_to(root)}: no SHA-256: line")
        else:
            actual = hashlib.sha256(skill.read_bytes()).hexdigest()
            if actual != m.group(1):
                errors.append(f"{where}: SHA-256 {actual} does not match UPSTREAM.md {m.group(1)}")
    elif folder in REQUIRE_UPSTREAM:
        errors.append(f"{where}: upstream copy needs an UPSTREAM.md")

for e in errors:
    print(f"FAIL {e}")
if errors:
    sys.exit(1)
print(f"ok: {len(skills)} skills checked")
PY
