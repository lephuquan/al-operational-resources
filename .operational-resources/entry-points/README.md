# Entry points — định tuyến E2E (`.operational-resources/`)

## TL;DR (VI)

- Đây là **mục lục điểm vào** cho ba **luồng** thường gặp: **một task ticket**, **dựng/bổ sung docs+skills+rules**, **kiểm tra & bảo trì** chúng.
- **Nội dung chi tiết** luồng “một task” vẫn nằm tại **`.operational-resources/PLAYBOOK.md`** và **`.operational-resources/WORKFLOW.md`** (gốc folder) — **không di chuyển** để giữ ổn định link từ `AGENTS.md`, `MAP.md`, `docs/current-task/README.md`, v.v.
- Các file **`01`…`03`** trong thư mục này chỉ **sắp thứ tự đọc** và **neo skill** — tránh trùng lặp dài.

## Chọn lối vào

| # | Kịch bản | File |
|---|----------|------|
| 1 | **Một task** từ lúc nhận ticket đến Done/MR | [`01-one-task-e2e.md`](01-one-task-e2e.md) |
| 2 | **Dự án mới / mở rộng** `docs/`, `skills/`, `rules/` | [`02-bootstrap-docs-skills-rules.md`](02-bootstrap-docs-skills-rules.md) |
| 3 | **Kiểm tra & cập nhật** định kỳ tài liệu + playbook | [`03-maintain-docs-skills-rules.md`](03-maintain-docs-skills-rules.md) |

## Liên kết gốc (luôn hữu ích)

- `.operational-resources/AGENTS.md` — giao ước làm việc với AI
- `.operational-resources/MAP.md` — bản đồ thư mục
- `.operational-resources/skills/README.md` — catalog skill
- `.operational-resources/docs/README.md` — thứ tự đọc `docs/`
- `.operational-resources/rules/README.md` — quy tắc cá nhân

**Last updated:** 2026-04-11
