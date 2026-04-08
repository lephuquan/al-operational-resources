# Architecture skills (hub)

## TL;DR (VI)

- Hai playbook: **thiết kế feature trước khi code** và **review kiến trúc repo** — bám `docs/architecture/` (đánh số `01`…`09`).
- Đọc **`docs/architecture/01-README.md`** để biết thứ tự đọc; HTTP contract nằm ở `docs/api/`, không trùng folder này.

## What lives here

| Skill | Use when |
|-------|----------|
| [design-feature-architecture](design-feature-architecture/) | Bạn có spec/task mới và cần phác boundary, API, DB, NFR, ADR trước khi implement. |
| [review-project-architecture](review-project-architecture/) | Bạn cần đánh giá nhanh layering, coupling, security, tests — ra P0/P1/P2, không refactor lớn. |

## Docs to read first

1. `docs/architecture/01-README.md` — index and reading order  
2. `02-system-overview.md`, `04-folder-structure.md`, `06-backend-layers-and-dependencies.md` — shared baseline for both skills  
3. `docs/specs/README.md` and `docs/current-task/README.md` — inputs for **design**  

## Files per skill

| Path | Role |
|------|------|
| `*/SKILL.md` | Playbook (required) |
| `design-feature-architecture/examples.md` | Sample design note (no secrets) |
| `*/checklist.md` | Quick verification lists |

**Last updated:** 2026-04-08
