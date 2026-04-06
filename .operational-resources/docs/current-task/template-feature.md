# Task: [Tên tính năng]

**ID:** [YYYYMMDD-name]  
**Trạng thái:** [In Progress | Review | Done]  
**Độ ưu tiên:** [High | Medium | Low]

## 1. Mục tiêu (Objective)

- Mô tả ngắn gọn tính năng này làm gì.
- Kết quả cuối cùng mong muốn là gì? (Ví dụ: API lưu đơn hàng vào DB và gửi email).

## 2. Context & Specs

- **Logic liên quan:** `.operational-resources/docs/specs/feature-[name].md`
- **Database:** `.operational-resources/docs/architecture/database-design.md`
- **Patterns:** `.operational-resources/docs/knowledge-base/coding-patterns.md`

## 3. Danh sách công việc (Checklist)

- [ ] Thiết kế DTO / request body + validation
- [ ] Service interface / implementation
- [ ] Repository / persistence
- [ ] Unit test + integration test (nếu cần)
- [ ] Controller / endpoint
- [ ] Cập nhật `docs/api/*` nếu đổi contract

## 4. Hướng dẫn cho AI (Instructions)

- "Thực hiện từng bước trong checklist; sau mỗi bước lớn, dừng để review nếu tôi yêu cầu."
- "Nếu đổi DB schema, cập nhật `architecture/database-design.md` và migration."

## 5. Nhật ký thay đổi (Progress Log)

- **[YYYY-MM-DD]**: …
