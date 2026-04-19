# Personal docs — AI context (`docs/`)

## TL;DR (VI)

- Đây là **điểm vào** cho toàn bộ tài liệu trong `.operational-resources/docs/` (ngữ cảnh cá nhân + AI).
- **`docs/` ở root repo** (nếu team có) là chuẩn chung; **không nhầm** với thư mục này.
- Nội dung chính **English**; mục này để bạn đọc nhanh.

**Task → Done (E2E):** **`.operational-resources/task-lifecycle/README.md`**.  
**Bootstrap / maintain docs+skills+rules:** **`.operational-resources/guides/README.md`**.  
This file lists **recommended reading order** for **`docs/`** only. Path on disk: `.operational-resources/docs/`.

## Purpose of `docs/`

- Provide **context** for implementation: architecture, API contract, specs, setup, decisions, knowledge base.
- Help AI apply **your** priorities while respecting team norms when they exist.
- Stay **separate** from playbooks in `skills/` (how-to) and ephemeral work in `current-task/`.

## Recommended reading order (AI)

1. `project-overview.md` — project intent and stack (start here); **ShelfLog demo** pointers when running simulator tasks
2. `architecture/01-README.md` → `architecture/02-system-overview.md` — backend shape (`01`…`09`)
3. `setup/01-README.md` → `02`…`05` — local run, env names, deploy summary
4. `current-task/` — active task (`README.md` + `TEMPLATE.md`; English template + `TL;DR (VI)`)
5. `api/` from `api/01-README.md` + `specs/README.md` — HTTP contract and feature behavior (`specs/TEMPLATE.md` for new features); for the **ShelfLog** demo, read `specs/feature-shelflog-items.md` and `api/08-endpoint-list.md`
6. `decisions/README.md` — ADR index + `TEMPLATE.md`
7. `knowledge-base/` — patterns, naming, errors, troubleshooting

## Example prompts

- "Use full context from `.operational-resources/docs/`"
- "Read `project-overview.md` and `architecture/02-system-overview.md` first"
- "Active task: `current-task/YYYYMMDD-task-name.md`"

## Important notes

- **This folder** (under `.operational-resources/`) is **personal** and optimized for your AI workflow. **Official product or team documentation** usually lives elsewhere (e.g. `docs/` at the **repository root** for the shared codebase, Confluence, wiki). Before merging to shared branches, **reconcile** with team standards.
- Update these files when behavior or contracts change.
- When a task completes, **promote** durable facts into `specs/`, `api/`, `decisions/`, or team docs **on purpose**.
- **Resource changelog (this bundle):** when you add or materially change workspace resources (rules, skills, docs structure, etc.), append an entry to **[`../RESOURCE-CHANGE-LOG.md`](../RESOURCE-CHANGE-LOG.md)** at the **workspace root** (newest first).

**Last updated:** 2026-04-17
