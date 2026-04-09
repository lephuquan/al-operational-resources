# Skill: Review Project Architecture

## TL;DR (VI)

- Rà soát repo **nhanh**: layer, coupling, security, testability — không refactor lớn trừ khi có plan riêng.
- Kết luận: **3 điểm mạnh + 3 rủi ro + hành động P0/P1/P2**.
- Tập trung finding có thể hành động ngay, tránh nhận xét chung chung.

## Goal

Deliver a **concise architecture review** of the repository: layering, coupling, cross-cutting concerns, and test posture—with prioritized, actionable follow-ups (no large refactors without an explicit plan).

## Preconditions

- **None** — applies to any Spring Boot–style backend documented in this workspace.
- Access to current code and architecture docs in `.operational-resources/docs/`.

## Steps

1. **Read baseline and scope**
   - Start with `docs/architecture/02-system-overview.md`, `04-folder-structure.md`, and `06-backend-layers-and-dependencies.md`.
   - Define review scope: whole repo vs feature area vs changed modules only.
2. **Inspect layering and coupling**
   - Verify controllers are thin and services own orchestration/domain behavior.
   - Check repository/data access boundaries and dependency direction.
   - Flag layer leaks (web logic in domain, domain logic in controller, direct DB in wrong places).
3. **Review cross-cutting quality**
   - Security model and endpoint protection (`09-security-architecture-backend.md`).
   - Error handling consistency (`docs/api/05-error-handling.md` if applicable).
   - Logging/metrics/tracing quality for debugging and operations.
4. **Assess test posture and reliability**
   - Coverage balance (unit vs integration) on critical flows.
   - Identify brittle/flaky tests, heavy setup, missing negative cases.
5. **Prioritize findings**
   - Write 3 strengths and 3 risks with impact reasoning.
   - Propose actions labeled **P0 / P1 / P2** with smallest safe next step.
6. **Publish concise report**
   - Keep output implementation-oriented and scoped.
   - Avoid suggesting broad refactors unless explicitly requested.

## Output

- A short review report including:
  - Scope of review
  - Three strengths
  - Three risks with impact
  - Three prioritized actions (**P0/P1/P2**) and recommended first slice
- Optional: a follow-up plan only if user asks for implementation/refactor.

## References

- Rules: `rules/` (project-wide constraints)
- Docs: `docs/architecture/01-README.md`, `02-system-overview.md`, `04-folder-structure.md`, `06-backend-layers-and-dependencies.md`, `09-security-architecture-backend.md`
- API / errors: `docs/api/01-README.md`, `docs/api/05-error-handling.md` (if present)
- Related skills: `skills/architecture/design-feature-architecture/SKILL.md`, `skills/code-quality/review-code/SKILL.md`, `skills/workflow/implement-feature/SKILL.md`

**Last updated:** 2026-04-08
