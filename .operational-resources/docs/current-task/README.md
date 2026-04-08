# Current Tasks — nguồn duy nhất (single source of truth)

## Vị trí

- **Chỉ dùng thư mục này:** `.operational-resources/docs/current-task/`
- **Không** tạo file task song song trong `rules/` — mọi task nằm ở đây để tránh nhân đôi và lệch bản.

## Quy ước đặt tên

- `YYYYMMDD-mo-ta-ngan.md` — ví dụ: `20260408-order-create-api.md`
- Một task = một file; ID trong metadata trùng với prefix ngày + slug.

## Chuẩn bắt buộc cho mọi task

Khi tạo task mới, copy **`TEMPLATE.md`** và điền đủ tối thiểu:

| Mục (trong `TEMPLATE.md`) | Bắt buộc | Ghi chú |
|---------------------------|----------|---------|
| §0 Definition of Ready | Tick trước khi code lớn | Đảm bảo đã làm rõ yêu cầu hoặc ghi blocker |
| Metadata + §1 tóm tắt | Có | |
| §2 nguồn, in/out scope, giả định | Có | Giảm hiểu nhầm khi scope đổi |
| §3 AC + §3.1 hành vi (feature) | Khuyến nghị mạnh | Happy path + lỗi + edge |
| §4 AC → Test | Có* | *Spike/chore có thể N/A |
| §5 non-functional (khi cần) | Tùy | |
| §6 một khối A/B/C/D | Có | Xóa khối không dùng |
| §7 Revision | Ghi khi AC thay đổi | Theo dõi cập nhật / thay đổi lớn |
| §8 gói ngữ cảnh rules + docs + skills | Có | AL biết đọc đâu trước khi code |
| §10 hướng dẫn AI (MUST/SHOULD/ASK) | Có | |
| §13 Definition of Done | Tick trước MR | |

## Loại task khác nhau

**Feature / Bugfix / Refactor / Spike / Chore / Ops** — dùng chung **`TEMPLATE.md`**: ở **§6** có khối A/B/C/D; **chỉ giữ một khối** tương ứng, xóa các khối còn lại.

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
