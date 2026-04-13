# Simulator — demo A→Z cho task lifecycle

## Mục đích

Bộ tài liệu **giả lập** (chỉ thay `docs/` / `src/` khi bạn chủ động làm theo task) để:

1. Đọc **`DEMO-PROJECT-BRIEF.md`** như **nguồn mô tả dự án** — đủ chi tiết để AI hiểu và **soạn / bổ sung** bộ `docs/` cho một Spring Boot đơn giản.
2. Sao chép **`DEMO-TICKET-20260411-shelf-items-api.md`** → `docs/current-task/20260411-shelf-items-api.md` (hoặc tên bạn chọn), rồi chạy luồng **`task-lifecycle/`** từ đầu đến cuối.

Độ khó task: **trung bình** — CRUD + phân trang + validation + quy tắc nghiệp vụ nhỏ + test (unit/IT). **Yêu cầu kỹ thuật về Docker** (Postgres trong container) nằm trong brief; **H2** chỉ dùng cho profile test nếu cấu hình như vậy.

## File trong thư mục

| File | Vai trò |
|------|---------|
| [`DEMO-PROJECT-BRIEF.md`](DEMO-PROJECT-BRIEF.md) | Bối cảnh sản phẩm, **stack kỹ thuật (gồm Docker)**, domain, API, cấu hình DB, checklist doc cho AI |
| [`DEMO-TICKET-20260411-shelf-items-api.md`](DEMO-TICKET-20260411-shelf-items-api.md) | File task đầy đủ theo `docs/current-task/TEMPLATE.md` — dùng như ticket thật |
| [`docker-compose.postgres.yml`](docker-compose.postgres.yml) | Compose **chuẩn demo**: PostgreSQL 16 (xem brief §6) |

## Gợi ý thứ tự demo

1. Đọc `task-lifecycle/README.md` → `FROM-TICKET-TO-DONE.md`.
2. (Tuỳ chọn) Nhờ AI: đọc `simulator/DEMO-PROJECT-BRIEF.md` và tạo/cập nhật các file doc được liệt kê trong **§9** của brief — mục tiêu là cây `docs/` trong `.operational-resources/`.
3. Sao chép file ticket vào `docs/current-task/`, cập nhật bảng dashboard trong `docs/current-task/README.md`.
4. Triển khai code trong `src/` theo task + `skills/workflow/implement-feature/`.

**Cập nhật lần cuối:** 2026-04-11
