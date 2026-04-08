# API versioning strategy

## TL;DR (VI)

- **Breaking change** → tăng **major** trong URL (`/v3/`) hoặc theo chuẩn team.
- **Thêm field optional / hành vi tương thích** → thường giữ version, vẫn ghi trong `10-current-api-changes.md`.

**Last updated:** 2026-04-08

## Definitions

- **Breaking change** (requires a new major API version or explicit deprecation path):
  - Removing or renaming fields, endpoints, or query parameters.
  - Changing type or meaning of existing fields.
  - Tightening validation so previously accepted requests are rejected.
  - Changing error codes or HTTP status for the same failure condition (careful — clients depend on both).

- **Non-breaking change** (usually same major version):
  - Adding new **optional** request fields or response fields.
  - Adding new endpoints.
  - Adding new enum values **only if** clients tolerate unknown values (document).

## URL versioning (default for this standard)

- Path includes major version: `/api/v{major}/resource`.
- Clients pin to a major version explicitly.

## Alternatives (document if used)

| Approach | Pros | Cons |
|----------|------|------|
| URL path (`/v2/`) | Visible, cache-friendly | Longer paths |
| Header (`Accept: application/vnd.company.v2+json`) | Clean URLs | Harder to test in browser |
| Query `?version=2` | Rare | Easy to forget; caching issues |

Pick **one primary** strategy per product surface; if the gateway uses headers, mirror that in `12-openapi-source-of-truth.md`.

## Lifecycle

- **Current:** active development and new features.
- **Legacy:** still supported; bugfixes only; no new features.
- **Deprecated:** scheduled removal; see `11-deprecation-policy.md`.

## When to document

- Any breaking or risky change: `10-current-api-changes.md`.
- Long-lived decisions: ADR under `docs/decisions/` if your workspace uses ADRs.
