# Project overview

## TL;DR (VI)

- Repo **`al-operational-resources`**: workspace **cá nhân** (rules + docs + skills) để làm việc với AI/Cursor, song song với code dự án thật trong `src/`.
- Stack chính: **Spring Boot 3.x, Java 17, Maven** (khớp `AGENTS.md`).
- **Demo ứng dụng tham chiếu (ShelfLog):** đặc tả `specs/feature-shelflog-items.md`, ticket `current-task/20260411-shelf-items-api.md`, brief `../simulator/DEMO-PROJECT-BRIEF.md` — dùng để giả lập task end-to-end.
- Đọc tiếp: `docs/README.md` (thứ tự đọc), `architecture/01-README.md`.

**Last updated:** 2026-04-14

---

## Identity

| Field | Value |
|-------|--------|
| **Repository** | `al-operational-resources` |
| **Workspace type** | Personal operational resources: `.operational-resources/` (rules, docs, skills, notes) + application code under `src/` when present |
| **Owner** | Phu Quan Le (personal; see `AGENTS.md`) |
| **Team / org** | Optional: align with your team’s official process; this tree does not replace BA or shared wiki |

## Goals

- **Fast, safe delivery** with AI assistance (clear context, fewer wrong assumptions).
- **Maintainable** Java/Spring code when the repo hosts application modules.
- **No silent drift** from team conventions: confirm before changing shared standards.

## Scope (this repo)

- **In scope:** personal rules and documentation for AI; Spring Boot service code and tests as the project evolves; references to feature areas (Auth, Orders, …) documented under `docs/specs/`.
- **Out of scope:** secrets in docs; replacing official team documentation or ticket systems.

## Demo reference application: ShelfLog

**ShelfLog** is a **fictional** product used to exercise this workspace: `task-lifecycle/`, `skills/`, and `docs/` stay aligned with a concrete but bounded problem (CRUD + pagination + validation + Postgres/H2 split). It is **not** a production service.

| Artifact | Path |
|----------|------|
| Product + stack contract | `.operational-resources/simulator/DEMO-PROJECT-BRIEF.md` |
| Feature spec | `docs/specs/feature-shelflog-items.md` |
| Infra demo task (do first) | `docs/current-task/20260414-shelflog-infra.md` (SIM-DEMO-1) |
| Feature demo task (main) | `docs/current-task/20260411-shelf-items-api.md` (SIM-DEMO-2) |
| Compose (Postgres 16, host **5433**) | `.operational-resources/simulator/docker-compose.postgres.yml` |
| ADR | `docs/decisions/006-shelflog-demo-postgres-docker.md` |

## Tech stack (current)

| Layer | Choice |
|-------|--------|
| **Backend** | Spring Boot 3.x, Java 17, Maven |
| **Persistence** | Spring Data JPA when used; DB via team/project choice (e.g. PostgreSQL, H2 for local) |
| **Auth** | JWT + refresh (see `docs/decisions/` and `docs/api/`) — adjust to match team |
| **Testing** | JUnit 5, Mockito, Spring Boot Test |
| **Frontend** | Not in this repo by default; optional separate app or monorepo (see `docs/decisions/005-optional-frontend-nextjs.md`) |
| **Deployment** | Docker / K8s / VM per team — only summarized in `docs/setup/04-deployment-overview.md` |

## Architecture (target)

- **Layered** boundaries: controller → application/service → domain (as applicable) → persistence/infrastructure.
- **Optional:** DDD-style domain modeling or event-driven modules when complexity warrants (record in `docs/decisions/`).

## Main risks (to watch)

1. **Context drift:** personal `docs/` out of sync with `src/` or team API — update docs in the same MR when behavior changes.
2. **Scope creep:** personal rules overriding team norms without explicit agreement — default to team, then opt-in overrides locally.
3. **Dependency / security:** new libraries or secrets — follow `rules/` and never commit secrets.

## Related documents

- Reading order and folder map: `docs/README.md`
- Backend architecture: `docs/architecture/01-README.md`
- API contract: `docs/api/01-README.md`
- Local run: `docs/setup/01-README.md`
- Task format: `docs/current-task/README.md`
