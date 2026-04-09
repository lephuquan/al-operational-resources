# Design Feature Architecture (index)

## TL;DR (VI)

- Thư mục này giúp bạn **thiết kế feature trước khi code** theo thứ tự rõ ràng.
- Bắt đầu từ `SKILL.md`, kiểm bằng `checklist.md`, tham chiếu/copy từ `examples.md`.
- Đầu ra cuối cùng là design note (và ADR nếu cần) để chuyển sang implement an toàn.

## This folder contains what

| File | Purpose |
|------|---------|
| `SKILL.md` | Main playbook: what to do, in which order, and what output is required |
| `checklist.md` | Quality gate before coding starts |
| `examples.md` | Reusable examples and a paste-ready design note template |
| `README.md` | This index: how to use the folder end-to-end |

## When to use this skill

Use this folder when:

- You are starting a **new feature** or major extension
- The change affects **API + data + transactions + integrations**
- You need explicit trade-offs and risk handling before implementation

Avoid overusing for tiny CRUD-only changes with no architectural impact.

## Recommended order

1. Read `SKILL.md` and draft design decisions.
2. Fill design note in active task file (`docs/current-task/*.md`) using structure from `examples.md`.
3. Run through `checklist.md` and mark unresolved items.
4. If decisions are significant/long-lived, create ADR via `docs/decisions/TEMPLATE.md`.
5. Hand off to implementation with a clear "Ready" or "Blocked" status.

## Expected output package

At minimum:

- Scope and non-goals
- Layer boundaries and API behavior
- Data impact (migration/index/constraints)
- Top risks + mitigations

Optional (when needed):

- ADR file + updated index in `docs/decisions/README.md`

## Upstream references (read-first docs)

- `docs/architecture/01-README.md`
- `docs/architecture/02-system-overview.md`
- `docs/architecture/04-folder-structure.md`
- `docs/architecture/06-backend-layers-and-dependencies.md`
- `docs/architecture/08-transactions-and-consistency.md`
- `docs/architecture/09-security-architecture-backend.md`

## Handoff note

If this folder produces a clear design note and no critical checklist blockers, proceed to implementation skill:

- `skills/workflow/implement-feature/SKILL.md`
