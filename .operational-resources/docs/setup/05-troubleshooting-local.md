# Troubleshooting — local development

## TL;DR (VI)

- Ghi lỗi **hay gặp trên máy dev** và cách xử lý đã thử; khác `knowledge-base/troubleshooting-manual.md` (prod/nghiệp vụ rộng hơn).

**Last updated:** 2026-04-14

## Purpose

Capture **repeatable** install/run failures on **personal dev machines** and **verified fixes** — avoid searching the same issue again.

Different from `docs/knowledge-base/troubleshooting-manual.md` (broader business/production knowledge).

---

## Entry template (copy per issue)

### [Short title — symptom]

- **Symptom:** (logs, behavior)
- **Cause:** (if known)
- **Fix:**
  ```text
  command or steps
  ```
- **Reference:** issue, link (if any)

---

## Log (add newest entries above this line)

### ShelfLog — cannot connect to PostgreSQL on localhost:5433

- **Symptom:** Spring Boot fails at startup with connection refused or timeout to `localhost:5433`.
- **Cause:** Docker Compose stack not running or wrong port.
- **Fix:**
  ```text
  docker compose -f .operational-resources/simulator/docker-compose.postgres.yml up -d
  ```
- **Reference:** `docs/setup/02-local-development.md`, `simulator/DEMO-PROJECT-BRIEF.md` §6

<!-- Add entries above -->
