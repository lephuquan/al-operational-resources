# Hướng dẫn: rà soát & cập nhật `docs/`, `skills/`, `rules/`

## Mục đích

Quy trình **định kỳ** (ví dụ mỗi sprint / tháng), **trước release lớn**, hoặc **ngay khi** có thay đổi đáng kể (contract API, kiến trúc, đổi tên skill, migration) — để tránh **link gãy**, **catalog lệch**, **trùng nguồn sự thật**, và **tài liệu lỗi thời**.

## Khi nào chạy checklist này

- [ ] Theo lịch team (vd. cuối tháng)
- [ ] Trước khi tag release hoặc merge nhánh dài
- [ ] Sau khi refactor lớn `.operational-resources/` hoặc đổi cấu trúc `skills/`
- [ ] Sau khi BA/Lead thống nhất thay đổi hành vi sản phẩm (đồng bộ `docs/api`, `specs`)

## Checklist

### 1) Mục lục & bản đồ

- [ ] **`.operational-resources/skills/README.md`** — mọi skill mới đã có dòng; các dòng **hub** (`README.md` trong folder) khớp thực tế
- [ ] **`.operational-resources/MAP.md`** — sơ đồ cây và bảng mô tả **`skills/`**, **`workflow/`**, **`guides/`** còn đúng với catalog
- [ ] **`.operational-resources/docs/README.md`** — thứ tự đọc vẫn phản ánh cấu trúc hiện tại

### 2) Liên kết & tham chiếu chéo

- [ ] Spot-check **References** trong vài **`SKILL.md`** / **`README.md`** skill (đặc biệt skill vừa sửa)
- [ ] Tìm path cũ (ví dụ chỉ `SKILL.md` khi đã chuyển hub `README.md`) — sửa dần khi chạm file
- [ ] **`task-lifecycle/`**, **`AGENTS.md`**, **`guides/README.md`** và liên kết chéo giữa chúng vẫn đúng

### 3) Chất lượng nội dung

- [ ] **`Last updated`** ở file “chuẩn” đã chỉnh khi đổi hành vi đáng kể
- [ ] **`docs/api/`** và **`docs/specs/`** đồng bộ nếu contract đổi
- [ ] **`rules/`** — không mâu thuẫn với nhau; `00-personal-priority` vẫn là nguồn override rõ ràng

### 4) Task & ghi chú

- [ ] **`docs/current-task/README.md`** dashboard không còn file task **Done** cũ kéo dài (dọn hoặc archive theo convention team)
- [ ] **`notes/`** — insight bền đã **promote** sang `docs/` / `skills/` khi phù hợp (xem `notes/README.md`)

### 5) Công cụ (tuỳ chọn)

- Grep nội bộ: `skills/` path không tồn tại, hoặc `http://` mẫu cũ
- So sánh danh sách thư mục `skills/*/*/` với bảng trong `skills/README.md`

## Sau khi sửa lớn

- Một vòng **task lifecycle** nhẹ: **`.operational-resources/task-lifecycle/FROM-TICKET-TO-DONE.md`** (§8–§9) xem DoD/evidence vẫn khớp quy trình thực tế.

## Thêm tài nguyên mới (ôn lại)

Khi review phát hiện thiếu khung: xem lại **[`bootstrap-docs-skills-rules.md`](bootstrap-docs-skills-rules.md)**.

**Last updated:** 2026-04-11
