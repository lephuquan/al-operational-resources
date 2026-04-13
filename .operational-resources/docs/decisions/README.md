# Architecture Decision Records (ADR)

## TL;DR (VI)

- Ghi **quyết định kỹ thuật / kiến trúc** quan trọng (tại sao chọn A): phục vụ AI và review sau này.
- **README** và **`TEMPLATE.md`** dùng English; nội dung từng ADR có thể VI hoặc EN.
- ADR mới: copy **`TEMPLATE.md`** → `NNN-short-title-kebab-case.md` (số tăng dần).

Personal ADRs explain **why** the codebase looks the way it does. They complement `docs/architecture/` (how it is structured) and `docs/api/` (HTTP contracts).

## Purpose

- Give AI stable **rationale** for big choices (persistence, auth, layering).
- Avoid re-litigating the same debates; link ADRs from tasks and PRs.
- Onboarding: new contributors read decisions before proposing changes.

## Naming

| Rule | Example |
|------|---------|
| Sequential number | `001-`, `002-`, … (three digits, zero-padded) |
| Kebab-case slug | `use-jwt-with-refresh-token` |
| Full filename | `003-use-jwt-with-refresh-token.md` |

Record only **meaningful** decisions — not every small tweak.

## Lifecycle and status

| Status | Meaning |
|--------|---------|
| **Proposed** | Under discussion; may change. |
| **Accepted** | Team/personal agreement; follow unless superseded. |
| **Rejected** | Explored and discarded; keep for history. |
| **Superseded** | Replaced by a newer ADR — set **Supersedes** / **Superseded by** links between files. |

When replacing a decision: add a new ADR with a higher number, mark the old one **Superseded**, and link both ways.

## Index (this workspace)

| ID | File | Title (summary) | Status |
|----|------|-----------------|--------|
| ADR-001 | `001-spring-data-jpa.md` | Spring Data JPA for persistence | Accepted |
| ADR-002 | `002-adopt-clean-architecture.md` | Clean / layered architecture for backend | Accepted |
| ADR-003 | `003-use-jwt-with-refresh-token.md` | JWT + HttpOnly refresh token | Proposed / update per team |
| ADR-004 | `004-implement-soft-delete.md` | Soft delete for important entities | Proposed / Accepted (update file) |
| ADR-005 | `005-optional-frontend-nextjs.md` | Optional Next.js if SPA is split | Proposed |
| ADR-006 | `006-shelflog-demo-postgres-docker.md` | ShelfLog demo: Postgres via Docker dev, H2 tests | Accepted |

*(Update this table when you add or change status.)*

## How to add a new ADR

1. Pick the next number (`006-…`).
2. Copy **`TEMPLATE.md`** → `NNN-title-kebab-case.md`.
3. Set the first-line title to **`# ADR-NNN: …`** matching the file number.
4. Add a row to the **Index** table above.
5. Link from `docs/current-task/…` or `docs/architecture/01-README.md` when relevant.

## References

- Feature design skill: `skills/architecture/design-feature-architecture/SKILL.md`
- Task template (related ADR field): `docs/current-task/TEMPLATE.md`

**Last updated:** 2026-04-14
