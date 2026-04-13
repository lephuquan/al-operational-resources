# Architecture documentation (personal workspace)

## TL;DR (VI)

- Đây là **khung kiến trúc BE** (ưu tiên Spring Boot) để AI hiểu layer, package, DB, tích hợp — **không** thay `docs/api/` (contract HTTP).
- Đánh số `01`…`09` = thứ tự đọc ổn định; nội dung là **mẫu tiêu chuẩn**, điền theo dự án thật khi có.

## What this folder is for

- **Backend-oriented** system shape: runtime, layers, code layout, persistence, cross-cutting concerns.
- **Reusable baseline** you can copy to another repo; replace placeholders (`<package>`, DB name, queue names) with project facts.
- **Not** the place for HTTP contract details — use `docs/api/` for that.

## Recommended reading order

1. `01-README.md` (this file)
2. `02-system-overview.md` — context diagram, style, NFR, integration summary
3. `03-tech-stack.md` — languages, frameworks, tooling
4. `04-folder-structure.md` — repository and Java package layout
5. `05-database-design.md` — persistence model template
6. `06-backend-layers-and-dependencies.md` — layer rules and allowed dependencies
7. `07-integrations.md` — external systems (template)
8. `08-transactions-and-consistency.md` — transactions, idempotency at service layer
9. `09-security-architecture-backend.md` — security in code (complements `docs/api/04-authentication.md`)

## Relationship to other docs

| Location | Focus |
|----------|--------|
| `docs/api/` | HTTP contract, envelopes, versioning |
| `docs/specs/README.md` | Feature behavior and acceptance (`feature-*.md`, copy from `TEMPLATE.md`) |
| `docs/decisions/` | ADRs: `README.md` (index), `TEMPLATE.md`, `NNN-topic.md` |
| `docs/setup/01-README.md` | How to run locally (numbered `01`…`05`) |
| `skills/backend/*` | How to implement tasks step-by-step |
| `skills/architecture/README.md` | When to design a feature vs review repo architecture (playbooks) |

## How to reuse in a new project

1. Copy the whole `docs/architecture/` folder.
2. Fill `03-tech-stack.md` and `04-folder-structure.md` first — AI needs these to place code correctly.
3. Update `05-database-design.md` when schema exists.
4. Keep `07-integrations.md` short; link to team vault/wiki for secrets and exact URLs.

**Last updated:** 2026-04-08
