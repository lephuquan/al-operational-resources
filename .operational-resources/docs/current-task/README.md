# Current tasks (single source of truth)

## TL;DR (VI)

- Thư mục **duy nhất** chứa file task cá nhân; không tạo bản song song trong `rules/`.
- **Luồng làm việc với AL (task → code → test → MR):** đọc **`../../PLAYBOOK.md`**, rồi khi implement bám **`../../skills/workflow/implement-feature/README.md`**.
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

1. **(Khuyến nghị)** Đọc playbook tổng: **`../../PLAYBOOK.md`** (DoR/DoD, prompt contract, evidence checklist).
2. Copy `TEMPLATE.md` → `YYYYMMDD-task-name.md`.
3. Fill metadata and required sections; delete unused §6 blocks.
4. Update the Dashboard table above.
5. Khi triển khai code: bám **`../../skills/workflow/implement-feature/README.md`** (slice, checklist, ví dụ prompt) + skill chi tiết trong §8 context pack.
6. Prompt AI: `@docs/current-task/YYYYMMDD-task-name.md` + relevant skill.
7. Close task: set Status to **Done**; optionally move the file to `archive/` later.

## References

- **Playbook vận hành với AL (single entry):** `../../PLAYBOOK.md`
- **Implement feature từ task (hub skill):** `../../skills/workflow/implement-feature/README.md`
- End-to-end flow (chi tiết): `../../WORKFLOW.md`
- Rules (no task copies): `../../rules/`

**Last updated:** 2026-04-09
