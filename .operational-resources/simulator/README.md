# Simulator — demo A→Z cho task lifecycle

## Mục đích

Bộ tài liệu **giả lập** để:

1. Đọc **`DEMO-PROJECT-BRIEF.md`** như **hợp đồng** sản phẩm + kỹ thuật (ShelfLog).
2. Đọc tài liệu ShelfLog trong **`.operational-resources/docs/`** (brief §9): `project-overview.md`, `specs/feature-shelflog-items.md`, `api/08-endpoint-list.md`, `setup/02-local-development.md`, ADR-006.
3. **Hai ticket giả lập:** **SIM-DEMO-1** infra trước (`20260414-shelflog-infra.md`), rồi **SIM-DEMO-2** feature chính (`20260411-shelf-items-api.md`). Luồng: **`task-lifecycle/`**.

**SIM-DEMO-1:** baseline Maven, Spring profiles, Postgres/H2, Actuator — độ khó **thấp–trung bình**. **SIM-DEMO-2:** CRUD + phân trang + validation — **trung bình**. Docker cho dev app; `./mvnw test` không cần Docker.

## File và thư mục

| Path | Vai trò |
|------|---------|
| [`../docs/`](../docs/README.md) | **Nguồn tài liệu duy nhất** cho ShelfLog (spec, setup, API, ADR, kiến trúc) — xem `DEMO-PROJECT-BRIEF.md` §9 |
| [`DEMO-PROJECT-BRIEF.md`](DEMO-PROJECT-BRIEF.md) | Bối cảnh sản phẩm, stack (gồm Docker), domain, API, checklist doc §9 |
| [`DEMO-TICKET-20260414-shelflog-infra.md`](DEMO-TICKET-20260414-shelflog-infra.md) | **SIM-DEMO-1** — mẫu; canonical `../docs/current-task/20260414-shelflog-infra.md` |
| [`DEMO-TICKET-20260411-shelf-items-api.md`](DEMO-TICKET-20260411-shelf-items-api.md) | **SIM-DEMO-2** (task chính) — mẫu; canonical `../docs/current-task/20260411-shelf-items-api.md` |
| [`DEMO-LOG-20260414-shelflog-infra.md`](DEMO-LOG-20260414-shelflog-infra.md) | File runbook + execution log chi tiết để làm SIM-DEMO-1 theo từng bước |
| [`DEMO-SCRIPT-20260414-shelflog-infra.ps1`](DEMO-SCRIPT-20260414-shelflog-infra.ps1) | Script demo chạy tuần tự các bước SIM-DEMO-1 và ghi entry vào log |
| [`docker-compose.postgres.yml`](docker-compose.postgres.yml) | PostgreSQL 16 (xem brief §6) |

## Gợi ý thứ tự demo

1. Đọc `task-lifecycle/README.md` → `FROM-TICKET-TO-DONE.md`.
2. Đọc `DEMO-PROJECT-BRIEF.md`, rồi **`.operational-resources/docs/README.md`** và các file ShelfLog trong `docs/` (brief §9).
3. Làm **SIM-DEMO-1** trước (infra), rồi **SIM-DEMO-2** (API); cập nhật dashboard `docs/current-task/README.md`.
4. Mỗi ticket: `skills/workflow/implement-feature/` hoặc skill ops tương ứng; đổi contract → chỉ **`.operational-resources/docs/`**.

**Cập nhật lần cuối:** 2026-04-14
