# Current tasks (single source of truth)

## TL;DR (VI)

- Thư mục **duy nhất** chứa file task cá nhân; không tạo bản song song trong `rules/`.
- **Nội dung kỹ thuật / template** dùng **English** để AI đọc ổn định; phần này là **lối vào** + dashboard.
- Sao chép `TEMPLATE.md` → đặt tên `YYYYMMDD-slug.md` → điền và cập nhật bảng bên dưới.

This folder is the **only** place for active personal task files. Use **`TEMPLATE.md`** for every new task. Main instructions are in **English**; this README is the entry point and dashboard.

## Location

- **Path:** `.operational-resources/docs/current-task/`
- **Do not** duplicate tasks under `rules/` — one source of truth avoids drift.

## File naming

- Pattern: `YYYYMMDD-short-description.md` — example: `20260408-order-create-api.md`
- One task = one file; metadata **ID** should match the date prefix + slug.

## Minimum content per task

Copy **`TEMPLATE.md`**, then fill at least:

| Section in `TEMPLATE.md` | Required | Notes |
|--------------------------|----------|--------|
| §0 Definition of Ready | Before large implementation | Clear requirements or explicit blockers |
| Metadata + §1 summary | Yes | |
| §2 sources, in/out scope, assumptions | Yes | Reduces scope misunderstandings |
| §3 AC + §3.1 behavior (features) | Strongly recommended | Happy path, errors, edge cases |
| §4 AC → Test | Yes* | *Spike/chore may be N/A with reason |
| §5 non-functional | When relevant | |
| §6 one block A/B/C/D | Yes | Delete unused blocks |
| §7 Revision | When AC changes | Track updates / major pivots |
| §8 context pack (rules + docs + skills) | Yes | AI knows what to read before coding |
| §10 AI guidance (MUST / SHOULD / ASK) | Yes | |
| §13 Definition of Done | Before MR | |

## Task types

**Feature / Bugfix / Refactor / Spike / Chore / Ops** — all use **`TEMPLATE.md`**. In **§6**, keep **one** block (A/B/C/D) and remove the others.

## Dashboard (active tasks)

| ID | Task name | Priority | Status | File |
|:---|:---|:---:|:---:|:---|
| 20260406 | Personal AL / operational workspace setup | High | Done | `20260406-setup-personal-workspace.md` |
| 20250405 | Order API (sample) | High | In Progress | `20250405-order-api.md` |

*(Update this table when tasks change.)*

## Workflow

1. Copy `TEMPLATE.md` → `YYYYMMDD-task-name.md`.
2. Fill metadata and required sections; delete unused §6 blocks.
3. Update the Dashboard table above.
4. Prompt AI: `@docs/current-task/YYYYMMDD-task-name.md` + relevant skill.
5. Close task: set Status to **Done**; optionally move the file to `archive/` later.

## References

- End-to-end flow: `../../WORKFLOW.md`
- Rules (no task copies): `../../rules/`

**Last updated:** 2026-04-08
