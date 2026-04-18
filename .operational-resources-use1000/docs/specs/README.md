# Feature specifications (`docs/specs/`)

## TL;DR (VI)

- **`specs/`** = đặc tả **nghiệp vụ / hành vi** theo từng feature (ổn định, ít đổi theo từng phiên làm việc).
- **`current-task/`** = **công việc đang làm** (theo ngày/ticket); thường **trỏ vào** một phần của spec.
- **`docs/api/`** = **hợp đồng HTTP** (path, JSON) — khác với spec (business).

This folder holds **business-level** feature specs for personal AI-assisted work. Use **`TEMPLATE.md`** when creating a new `feature-*.md` file.

## Purpose

- Clarify **what** the product should do (stories, AC, flows, edge cases).
- Give AI **stable requirements** separate from day-to-day task files.
- Align implementation and tests with the same source of truth.

## Spec vs `current-task/` vs `docs/api/`

| Artifact | Focus |
|----------|--------|
| **`specs/feature-*.md`** | Business rules, user-visible behavior, acceptance over time |
| **`current-task/*.md`** | A **single slice of work** (scope, DoD, links, AI MUST/SHOULD) |
| **`docs/api/*.md`** | HTTP contract: URLs, envelopes, errors |

A task file should **link** to the relevant spec section when implementing a feature.

## Naming

- One file per major feature area: `feature-<area>.md` (kebab-case).
- Copy from **`TEMPLATE.md`**; set a feature code (e.g. `FEA-AUTH-001`) in metadata.

## Index (this workspace)

| File | Feature code | Status (example) | Notes |
|------|----------------|------------------|--------|
| `feature-auth.md` | FEA-AUTH-001 | Completed (update as needed) | Auth & session |
| `feature-order.md` | FEA-ORDER-001 | In Progress | Orders |
| `feature-payment.md` | FEA-PAY-001 | Draft | Payments |
| `feature-dashboard.md` | FEA-DASH-001 | Draft | Dashboard / reporting |
| `feature-notification.md` | FEA-NOTIF-001 | Draft | Notifications |
| `feature-user-management.md` | FEA-USER-001 | Draft | Users / roles |
| `feature-shelflog-items.md` | FEA-SHELF-001 | Active (demo) | ShelfLog — shelf items CRUD + list (simulator) |

*(Update the table when you add files or change status.)*

## Prompting (examples)

- "Implement according to `docs/specs/feature-auth.md` §3–5."
- "Cross-check `docs/api/08-endpoint-list.md` with `docs/specs/feature-order.md` for order creation."

## Related

- Task template (links to specs): `current-task/TEMPLATE.md`
- API contract: `docs/api/01-README.md`

**Last updated:** 2026-04-14
