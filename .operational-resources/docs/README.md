# Personal Docs - AI Context Repository

Đây là bộ tài liệu **cá nhân** của Phú Quân Lê, được ưu tiên cao khi Cursor (hoặc các AI agent khác) làm việc với dự án này.

**Vị trí thực tế**: `.operational-resources/docs/` (tương đương vai trò `.personal-ai/docs/` trong tài liệu gốc).

## Mục đích của thư mục `docs/`

- Cung cấp **ngữ cảnh, kiến trúc, business logic, và kiến thức dự án** cho AI.
- Giúp AI hiểu rõ lý do đằng sau các quyết định kỹ thuật.
- Làm tài liệu tham khảo nhanh cho cả AI và con người.

## Thứ tự đọc khuyến nghị cho AI (Cursor)

1. `project-overview.md` — tổng quan dự án
2. `architecture/01-README.md` → `architecture/02-system-overview.md` — kiến trúc BE (đánh số `01`…`09`)
3. `setup/` — chạy local, biến môi trường (tên), triển khai tóm tắt; đọc sớm khi task cần chạy app hoặc đổi cấu hình (`setup/README.md` là mục lục)
4. `current-task/` — task đang làm (`README.md` + `TEMPLATE.md`; nội dung template English, có `TL;DR (VI)`)
5. `api/` (bắt đầu từ `api/01-README.md`) + `specs/` — contract API và đặc tả tính năng
6. `decisions/` — lý do kiến trúc và trade-off
7. `knowledge-base/` — pattern và kinh nghiệm tích lũy

## Hướng dẫn sử dụng khi prompt Cursor

- "Use full context from `.operational-resources/docs/`"
- "Read `project-overview.md` and `architecture/02-system-overview.md` first"
- "Refer to `current-task/YYYYMMDD-xxx.md` for the active task"

## Lưu ý quan trọng

- Nội dung trong thư mục này được ưu tiên **cao hơn** `docs/` chính thức của team **cho luồng làm việc cá nhân**; khi merge/PR cần **đối chiếu** với chuẩn team.
- Cập nhật thường xuyên để AI luôn có thông tin mới nhất.
- Khi task hoàn thành, nội dung quan trọng có thể **sync** sang docs chung của dự án (có chủ đích).

**Last updated**: 08/04/2026
