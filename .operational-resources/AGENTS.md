# AGENTS.md - Personal AI Workspace

Last updated: 2026-04-08
Owner: Phu Quan Le (personal only)

## 1) Workspace intent
- This workspace is personal and optimized for fast, high-quality delivery with AI.
- It must not change team-shared conventions without explicit confirmation.
- Team standards remain default; personal rules can override for local workflow decisions.

## 2) Project context
- Project: `al-operational-resources`
- Stack: Spring Boot 3.x, Java 17, Maven
- Architecture target: Layered + clean boundaries (controller/service/repository/domain)
- Main goal: deliver features safely with strong tests and maintainable code

## 3) Core principles
- Readability and maintainability over clever shortcuts.
- Security-first: validate all input, never hardcode secrets.
- Performance-aware: avoid unnecessary DB calls, design for pagination.
- Testability-first: code should be easy to unit/integration test.

## 4) Working protocol with AI
1. Plan briefly before non-trivial implementation.
2. Read `.operational-resources/rules/` first, then `.operational-resources/docs/`.
3. If unclear, ask instead of guessing.
4. Do not auto-commit or push.
5. After each task: summarize changes and suggest next checks.

## 5) Forbidden actions
- No deleting major files/folders without confirmation.
- No adding dependencies without explicit reason.
- No architecture-level changes without plan and approval.
- No secret exposure in code, logs, or docs.

## 6) Priority order
1. `.operational-resources/rules/00-personal-priority.md`
2. This `AGENTS.md`
3. Other `.operational-resources/rules/*.md`
4. `.operational-resources/docs/**`
5. Team docs/rules for cross-check and alignment

## 7) References
- Directory map (cấu trúc thư mục): `.operational-resources/MAP.md`
- Task → implement → test → review → MR: `.operational-resources/WORKFLOW.md`
- Rules: `.operational-resources/rules/`
- Personal docs: `.operational-resources/docs/`
- Backend architecture (numbered): `.operational-resources/docs/architecture/01-README.md`
- Architecture playbooks (design vs review): `.operational-resources/skills/architecture/README.md`
- ADRs (index + template): `.operational-resources/docs/decisions/README.md`
- Feature specs (index): `.operational-resources/docs/specs/README.md`
- Local run & setup (no secrets): `.operational-resources/docs/setup/01-README.md`
- Skills index: `.operational-resources/skills/README.md`
- Adding a skill / topic: `.operational-resources/skills/HOW-TO-ADD-TOPIC.md` (copy `.operational-resources/skills/SKILL-TEMPLATE.md` → `skills/<group>/<topic>/SKILL.md`)
- Notes: `.operational-resources/notes/`
