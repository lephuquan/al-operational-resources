# Current tasks (single source of truth)

## TL;DR (VI)

- Th? m?c **duy nh?t** ch?a file task cá nhân; không t?o b?n song song trong `rules/`.
- **Lu?ng m?t task (ticket ? Done):** **`../../task-lifecycle/README.md`** ? **`../../task-lifecycle/FROM-TICKET-TO-DONE.md`**.
- **Bootstrap / b?o trì tài li?u:** **`../../guides/README.md`**.
- Khi implement code: bám **`../../skills/workflow/implement-feature/README.md`** (bugfix: **`investigate-bug`** hub).
- **N?i dung k? thu?t / template** dùng **English** ?? AI ??c ?n ??nh; ph?n này là **l?i vào** + dashboard.
- Sao chép `TEMPLATE.md` ? ??t tên `YYYYMMDD-slug.md` ? ?i?n và c?p nh?t b?ng bên d??i.

This folder is the **only** place for active personal task files. Use **`TEMPLATE.md`** for every new task. Main instructions are in **English**; this README is the entry point and dashboard.

## Location

- **Path:** `.operational-resources/docs/current-task/`
- **Do not** duplicate tasks under `rules/` ? one source of truth avoids drift.

## File naming

- Pattern: `YYYYMMDD-short-description.md` ? example: `20260408-order-create-api.md`
- One task = one file; metadata **ID** should match the date prefix + slug.

## Minimum content per task

Copy **`TEMPLATE.md`**, then fill at least:

| Section in `TEMPLATE.md` | Required | Notes |
|--------------------------|----------|--------|
| §0 Definition of Ready | Before large implementation | Clear requirements or explicit blockers |
| Metadata + §1 summary | Yes | |
| §2 sources, in/out scope, assumptions | Yes | Reduces scope misunderstandings |
| §3 AC + §3.1 behavior (features) | Strongly recommended | Happy path, errors, edge cases |
| §4 AC ? Test | Yes* | *Spike/chore may be N/A with reason |
| §5 non-functional | When relevant | |
| §6 one block A/B/C/D | Yes | Delete unused blocks |
| §7 Revision | When AC changes | Track updates / major pivots |
| §8 context pack (rules + docs + skills) | Yes | AI knows what to read before coding |
| §10 AI guidance (MUST / SHOULD / ASK) | Yes | |
| §13 Definition of Done | Before MR | |

## Task types

**Feature / Bugfix / Refactor / Spike / Chore / Ops** ? all use **`TEMPLATE.md`**. In **§6**, keep **one** block (A/B/C/D) and remove the others.

## Dashboard (active tasks)

| ID | Task name | Priority | Status | File |
|:---|:---|:---:|:---:|:---|
| 20260406 | Personal AL / operational workspace setup | High | Done | `20260406-setup-personal-workspace.md` |
| 20260414 | ShelfLog ? infra baseline (SIM-DEMO-1) | High | Done | `20260414-shelflog-infra.md` |
| 20260411 | ShelfLog ? shelf items API (SIM-DEMO-2) | Medium | Ready / Draft | `20260411-shelf-items-api.md` |
| 20250405 | Order API (sample) | High | In Progress | `20250405-order-api.md` |

*(Update this table when tasks change.)*

## Workflow

1. **(Khuy?n ngh?)** ??c **`../../task-lifecycle/FROM-TICKET-TO-DONE.md`** (DoR, t?ng b??c, MR, DoD).
2. Copy `TEMPLATE.md` ? `YYYYMMDD-task-name.md`.
3. Fill metadata and required sections; delete unused §6 blocks.
4. Update the Dashboard table above.
5. Khi tri?n khai code: bám **`../../skills/workflow/implement-feature/README.md`** (slice, checklist, ví d? prompt) + skill chi ti?t trong §8 context pack.
6. Prompt AI: `@docs/current-task/YYYYMMDD-task-name.md` + relevant skill.
7. Close task: set Status to **Done**; optionally move the file to `archive/` later.

## References

- **Task lifecycle (E2E):** `../../task-lifecycle/README.md`, `../../task-lifecycle/FROM-TICKET-TO-DONE.md`
- **Guides (bootstrap / review tài li?u):** `../../guides/README.md`
- **Implement feature t? task (hub skill):** `../../skills/workflow/implement-feature/README.md`
- Rules (no task copies): `../../rules/`

**Last updated:** 2026-04-14 (SIM-DEMO-1 + SIM-DEMO-2)
