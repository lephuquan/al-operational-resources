# Current Tasks — nguồn duy nhất (single source of truth)

## Vị trí

- **Chỉ dùng thư mục này:** `.operational-resources/docs/current-task/`
- **Không** tạo file task song song trong `rules/` — mọi task nằm ở đây để tránh nhân đôi và lệch bản.

## Quy ước đặt tên

- `YYYYMMDD-mo-ta-ngan.md` — ví dụ: `20260408-order-create-api.md`
- Một task = một file; ID trong metadata trùng với prefix ngày + slug.

## Chuẩn bắt buộc cho mọi task

Khi tạo task mới, copy **`TEMPLATE.md`** và điền đủ tối thiểu:

| Mục | Bắt buộc | Ghi chú |
|-----|----------|---------|
| Metadata (loại, ticket, trạng thái) | Có | |
| Tóm tắt một dòng | Có | |
| Nguồn & phạm vi | Có | |
| AC hoặc lý do không có AC | Có | |
| AC → Test (hoặc N/A có lý do) | Có* | *Spike/chore tài liệu có thể ghi N/A |
| Một khối loại task (A/B/C/D) | Có | Xóa khối không dùng |
| Hướng dẫn cho AI | Ít nhất 1 dòng | Tránh AL đoán sai |
| Definition of Done | Tick trước MR | |

## Loại task khác nhau

**Feature / Bugfix / Refactor / Spike / Chore / Ops** — dùng chung **`TEMPLATE.md`**: ở **§5** có khối A/B/C/D; **chỉ giữ một khối** tương ứng, xóa các khối còn lại.

## Dashboard (task đang chạy)

| ID | Task Name | Priority | Status | File |
|:---|:---|:---:|:---:|:---|
| 20260406 | Thiết lập workspace AL / operational docs | High | Done | `20260406-setup-personal-workspace.md` |
| 20250405 | Triển khai Order API (mẫu) | High | In Progress | `20250405-order-api.md` |

*(Cập nhật bảng khi đổi task.)*

## Quy trình

1. Copy `TEMPLATE.md` → `YYYYMMDD-ten-task.md`.
2. Điền metadata + các mục bắt buộc; xóa khối loại task không dùng.
3. Cập nhật bảng Dashboard ở trên.
4. Prompt AI: `@docs/current-task/YYYYMMDD-ten-task.md` + skill liên quan.
5. Đóng task: Status = Done; có thể chuyển file sang thư mục `archive/` sau này nếu bạn muốn (tùy chọn).

## Tham chiếu

- Flow tổng: `../../WORKFLOW.md`
- Rules (không chứa bản copy task): `../../rules/`
