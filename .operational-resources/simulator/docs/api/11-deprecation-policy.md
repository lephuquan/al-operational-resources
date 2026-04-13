# API deprecation policy

## TL;DR (VI)

- Không đột ngột “tắt” API: cần **thông báo**, **timeline**, **hướng migration**.
- Breaking lớn → ưu tiên **version mới** (`/v3/`) thay vì sửa gãy `/v2/`.

**Last updated:** 2026-04-08

## Principles

- Clients need **predictable** migration windows and **clear** signals.
- Deprecation is a **product** decision as much as a technical one; align with stakeholders.

## When to deprecate

- Endpoint or field is **unsafe**, **unused**, or **replaced** by a better design.
- A **major version** introduces a cleaner model (prefer new version over silent behavior change).

## Minimum notice period

- Default **90 days** from announcement to end-of-support (adjust per team policy).
- Security-sensitive issues may require **accelerated** timelines — document exception.

## What to publish

For each deprecated item:

1. **What** is deprecated (endpoint, field, enum value, error code).
2. **Why** (short).
3. **Replacement** (what to use instead).
4. **Timeline:** deprecation date, end-of-support date.
5. **Contact** for questions (team channel).

## Where to record

- `10-current-api-changes.md` — running log.
- `08-endpoint-list.md` — mark deprecated routes (e.g. note column).
- OpenAPI: `deprecated: true` + `x-sunset` or team extension if used (`12-openapi-source-of-truth.md`).

## HTTP semantics

- Optionally return **`Deprecation`** / **`Sunset`** / **`Link`** headers if your platform supports them; otherwise document in changelog only.

## Versioning interaction

- Prefer **new major version** for breaking changes instead of silently changing behavior under the same `/v{major}`.
- See `06-versioning.md`.

## Checklist

- [ ] Stakeholders informed
- [ ] Docs updated (`08`, `10`, OpenAPI)
- [ ] Clients identified (internal apps, partners)
- [ ] Monitoring for usage of deprecated paths
- [ ] Removal executed only after sunset date
