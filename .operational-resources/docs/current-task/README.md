# Current Tasks Dashboard

Đây là nơi quản lý công việc đang thực hiện. AI nên đọc file này trước để biết task nào **ưu tiên cao nhất**.

## 1. Task đang thực hiện (Active)

| ID | Task Name | Priority | Status | Assigned File |
|:---|:---|:---:|:---:|:---|
| 20260406 | Thiết lập workspace AL / operational docs | High | Done | `20260406-setup-personal-workspace.md` |
| 20250405 | Triển khai Order API (mẫu) | High | In Progress | `20250405-order-api.md` |

*(Cập nhật bảng khi đổi task; có thể thêm cột Owner nếu cần.)*

## 2. Quy trình làm việc (Workflow)

1. **Chọn template**: Feature / Bugfix / Refactor — dùng `template-*.md` trong thư mục này.
2. **Tạo file task**: `YYYYMMDD-ten-task.md`.
3. **Cập nhật README**: thêm dòng vào bảng Active.
4. **Thực thi với AI**: "Dựa trên file `docs/current-task/<file>.md`, làm bước tiếp theo trong checklist."
5. **Đóng task**: đánh dấu Done / chuyển sang archive (tùy bạn).

## 3. Lưu ý cho AI

- Tuân thủ `docs/knowledge-base/` khi thực hiện task.
- Task kéo dài > ~3 phiên chat: tóm tắt tiến độ vào file task để tránh mất context.

## 4. Đường dẫn tham chiếu

Dùng prefix: `.operational-resources/docs/...` (không dùng `.personal-ai/`).
