# Entry 3 — Kiểm tra & bảo trì `docs/`, `skills/`, `rules/`

## Mục đích

Quy trình **định kỳ** (hoặc trước release lớn) để tránh **link gãy**, **catalog lệch**, **trùng nguồn sự thật**, và **skill lỗi thời**.

## Checklist bảo trì

### 1) Mục lục & bản đồ

- [ ] **`.operational-resources/skills/README.md`** — mọi skill mới đã có dòng; các dòng **hub** (`README.md` trong folder) khớp thực tế
- [ ] **`.operational-resources/MAP.md`** — sơ đồ cây và bảng mô tả **`skills/`**, **`workflow/`** còn đúng với catalog
- [ ] **`.operational-resources/docs/README.md`** — thứ tự đọc vẫn phản ánh cấu trúc hiện tại

### 2) Liên kết & tham chiếu chéo

- [ ] Spot-check **References** trong vài **`SKILL.md`** / **`README.md`** skill (đặc biệt skill vừa sửa)
- [ ] Tìm path cũ (ví dụ chỉ `SKILL.md` khi đã chuyển hub `README.md`) — sửa dần khi chạm file
- [ ] **`PLAYBOOK.md`**, **`WORKFLOW.md`**, **`AGENTS.md`** vẫn trỏ đúng entry chính

### 3) Chất lượng nội dung

- [ ] **`Last updated`** ở file “chuẩn” đã chỉnh khi đổi hành vi đáng kể
- [ ] **`docs/api/`** và **`docs/specs/`** đồng bộ nếu contract đổi
- [ ] **`rules/`** — không mâu thuẫn với nhau; `00-personal-priority` vẫn là nguồn override rõ ràng

### 4) Task & vận hành

- [ ] **`docs/current-task/README.md`** dashboard không còn file task **Done** cũ kéo dài (dọn hoặc archive theo convention team)
- [ ] **`notes/`** — insight bền đã **promote** sang `docs/` / `skills/` khi phù hợp (xem `notes/README.md`)

### 5) Công cụ (tuỳ chọn)

- Grep nội bộ: `skills/` path không tồn tại, hoặc `http://` mẫu cũ
- So sánh danh sách thư mục `skills/*/*/` với bảng trong `skills/README.md`

## Sau khi sửa lớn

- Một vòng **Entry 1** nhẹ: đọc lại **`.operational-resources/PLAYBOOK.md`** xem DoD/evidence vẫn khớp quy trình thực tế.

**Last updated:** 2026-04-11
