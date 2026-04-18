# Skill: [Short name]

## TL;DR (VI)

- Đây là **mẫu** cho mọi `SKILL.md`: Goal → Preconditions → Steps → Output → References.
- Nội dung chính **English** để AI đọc ổn định; có thể thêm ví dụ ngắn bằng VI trong Steps nếu cần.
- Copy file này vào `skills/<category>/<topic-slug>/SKILL.md`, xóa mục không dùng, thêm vào `skills/README.md`.

**Instructions:** Replace all `[brackets]`. Keep steps **actionable** and link to numbered docs under `docs/` (e.g. `docs/api/03-response-format.md`).

---

## Goal

[One paragraph: what outcome this playbook produces.]

## Preconditions

- [What must already exist: Java 17, Spring Boot 3, feature spec, …]
- [Or: **None** — if the skill applies broadly.]

## Steps

1. [Concrete action]
2. […]
3. […]

## Output

- [Artifacts: classes, config files, tests — list types, not secrets.]

## References

- Rules: `rules/…` (if any)
- Docs: `docs/architecture/01-README.md`, `docs/api/01-README.md`, `docs/specs/README.md` as relevant
- Related skills: `skills/…/SKILL.md`

## Optional: when to add `checklist.md`

Add `checklist.md` for PR-style verification when the skill is **high-risk** or **repeated often** (e.g. new REST endpoint, production incident).

## Optional: when to add `examples.md`

Use for **non-secret** snippets (command samples, DTO shape, log line format). Never paste real tokens or production URLs with credentials.

---

**Last updated (template):** 2026-04-08
