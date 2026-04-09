# Skill: Design Feature Architecture

## TL;DR (VI)

- Thiết kế feature **trước khi code**: ranh giới layer, contract API, dữ liệu, lỗi, NFR; ghi ADR nếu quyết định quan trọng.
- Đọc spec/task → neo vào `docs/architecture/` → phác luồng, migration, tích hợp → cập nhật task hoặc ADR.
- Luôn kết thúc bằng output có thể dùng ngay cho bước implement: design note + risk list + decision log.

## Goal

Produce a **clear, minimal design** for a new or extended feature: module boundaries, HTTP/API shape, persistence changes, failure modes, and prioritized trade-offs—aligned with the layered backend model—before implementation starts.

## Preconditions

- A feature intent exists: `docs/specs/feature-*.md` and/or `docs/current-task/*.md`.
- Baseline architecture docs exist under `docs/architecture/` (start from `01-README.md` and the numbered files referenced in Steps).
- Scope owner is known (who can confirm assumptions and trade-offs).

## Steps

1. **Read requirements and boundaries**
   - Parse spec/task for scope, acceptance criteria, non-goals, and rollout expectation.
   - List missing inputs as explicit assumptions (do not silently guess).
2. **Anchor to architecture baseline**
   - Map feature to existing runtime and package boundaries using:
     - `docs/architecture/02-system-overview.md`
     - `docs/architecture/04-folder-structure.md`
     - `docs/architecture/06-backend-layers-and-dependencies.md`
   - Decide where orchestration lives (controller/service/domain) and whether async/event flow is needed (`07-integrations.md`).
3. **Define API/behavior contract**
   - Sketch request/response, validation, and error semantics in line with `docs/api/`.
   - Decide idempotency and consistency behavior for retries and duplicate requests (`08-transactions-and-consistency.md`).
4. **Design data and persistence impact**
   - Identify new tables/entities vs extensions to existing schema.
   - Define migration/index/constraint impact (`05-database-design.md`).
   - Mark hot paths and read/write amplification risks.
5. **Cover cross-cutting concerns**
   - Security authorization and sensitive data handling (`09-security-architecture-backend.md`).
   - Observability signals (logs/metrics/traces) for critical flows.
   - Performance guardrails and integration failure strategy (`07-integrations.md`).
6. **Finalize decisions and outputs**
   - Produce a short design note in current task file.
   - If the decision is non-obvious or long-lived, create ADR (`docs/decisions/TEMPLATE.md` → `NNN-topic.md`) and update index.
   - Publish top risks and mitigations before coding starts.

## Output

- A design note in `docs/current-task/<task>.md` containing:
  - Scope and non-goals
  - Layer/module boundaries
  - API sketch and error behavior
  - Data changes (schema/migration/index)
  - Top 3 risks + mitigations
- An ADR file only when needed (significant, long-lived, or cross-team impact).
- A clear "ready for implementation" checkpoint: what can be coded now vs what still needs confirmation.

## References

- Rules: `rules/` (project-wide constraints)
- Docs: `docs/architecture/01-README.md` (reading order), `02-system-overview.md`, `04-folder-structure.md`, `05-database-design.md`, `06-backend-layers-and-dependencies.md`, `07-integrations.md`, `08-transactions-and-consistency.md`, `09-security-architecture-backend.md`
- API: `docs/api/01-README.md` and related numbered files as needed
- Specs: `docs/specs/README.md`
- Tasks: `docs/current-task/README.md`, `docs/current-task/TEMPLATE.md`
- Decisions: `docs/decisions/README.md`, `docs/decisions/TEMPLATE.md`
- Related skills: `skills/workflow/implement-feature/SKILL.md`, `skills/backend/create-rest-api/SKILL.md`, `skills/backend/create-service-layer/SKILL.md`, `skills/architecture/review-project-architecture/SKILL.md`

**Last updated:** 2026-04-08
