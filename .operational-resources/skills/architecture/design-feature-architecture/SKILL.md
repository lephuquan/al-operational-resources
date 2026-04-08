# Skill: Design Feature Architecture

## TL;DR (VI)

- Thiết kế feature **trước khi code**: ranh giới layer, contract API, dữ liệu, lỗi, NFR; ghi ADR nếu quyết định quan trọng.
- Đọc spec/task → neo vào `docs/architecture/` → phác luồng, migration, tích hợp → cập nhật task hoặc ADR.

## Goal

Produce a **clear, minimal design** for a new or extended feature: module boundaries, HTTP/API shape, persistence changes, failure modes, and prioritized trade-offs—aligned with the layered backend model—before implementation starts.

## Preconditions

- A feature intent exists: `docs/specs/feature-*.md` and/or `docs/current-task/*.md`.
- Baseline architecture docs exist under `docs/architecture/` (start from `01-README.md` and the numbered files referenced in Steps).

## Steps

1. **Read requirements** — Parse the spec and active task file for scope, acceptance criteria, and non-goals.
2. **Anchor to architecture** — Map the feature onto `docs/architecture/02-system-overview.md`, `docs/architecture/04-folder-structure.md`, and `docs/architecture/06-backend-layers-and-dependencies.md` (controller → application → domain/repository; async/events if applicable per `07-integrations.md`).
3. **Define the contract** — Request/response shapes, validation rules, error semantics (see `docs/api/` and `docs/knowledge-base/error-codes.md` if used), idempotency where relevant (`docs/architecture/08-transactions-and-consistency.md`).
4. **Data model** — New entities/tables vs extensions; migrations; indexes and constraints (`docs/architecture/05-database-design.md`).
5. **Cross-cutting** — Security (`docs/architecture/09-security-architecture-backend.md`), performance, observability, external integrations (`docs/architecture/07-integrations.md`).
6. **Record decisions** — If the choice is non-obvious or long-lived, add a short ADR: copy `docs/decisions/TEMPLATE.md` → `NNN-topic.md`, update `docs/decisions/README.md`.

## Output

- A short design note in the task file or an ADR: boundaries, API sketch, data delta, top risks—**no** over-engineering for trivial CRUD.

## References

- Rules: `rules/` (project-wide constraints)
- Docs: `docs/architecture/01-README.md` (reading order), `02-system-overview.md`, `04-folder-structure.md`, `05-database-design.md`, `06-backend-layers-and-dependencies.md`, `07-integrations.md`, `08-transactions-and-consistency.md`, `09-security-architecture-backend.md`
- API: `docs/api/01-README.md` and related numbered files as needed
- Specs: `docs/specs/README.md`
- Tasks: `docs/current-task/README.md`, `docs/current-task/TEMPLATE.md`
- Decisions: `docs/decisions/README.md`, `docs/decisions/TEMPLATE.md`
- Related skills: `skills/workflow/implement-feature/SKILL.md`, `skills/backend/create-rest-api/SKILL.md`, `skills/backend/create-service-layer/SKILL.md`, `skills/architecture/review-project-architecture/SKILL.md`

**Last updated:** 2026-04-08
