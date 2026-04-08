# Task — [Tên ngắn gọn]

> **Quy ước:** Mỗi task = **một file** `YYYYMMDD-ten-task.md` trong **chỉ** thư mục này (`docs/current-task/`).  
> **Không** tạo bản song song trong `rules/` — tránh nhân đôi.  
> Copy file này → đổi tên → xóa các mục không dùng (theo loại task).

---

## Metadata (bắt buộc)

| Trường | Giá trị |
|--------|---------|
| **Loại task** | `feature` \| `bugfix` \| `refactor` \| `spike` \| `chore` \| `ops` |
| **ID file** | `YYYYMMDD-slug.md` (trùng tên file) |
| **Ticket / Issue** | Link hoặc mã (PROJ-123) |
| **Trạng thái** | Draft \| In Progress \| Review \| Done |
| **Ưu tiên** | High \| Medium \| Low |

---

## 1. Tóm tắt một dòng (bắt buộc)

[Một câu: làm gì, vì ai / vì mục tiêu gì.]

---

## 2. Nguồn & phạm vi (bắt buộc)

- **Ticket / mô tả chính thức:** (link hoặc paste ngắn)
- **Spec / thiết kế liên quan:** `docs/specs/...` (nếu có)
- **API / contract:** `docs/api/...` (nếu đụng)
- **Phạm vi trong / ngoài:** [trong phạm vi / không làm X / phụ thuộc team khác]

---

## 3. Acceptance criteria (bắt buộc khi có từ BA/Lead; nếu không có — ghi “Không có AC riêng — mục tiêu kỹ thuật: …”)

- [ ] …
- [ ] …

---

## 4. Ánh xạ AC → Test (bắt buộc trước khi coi xong — trừ spike/chore thuần tài liệu)

| AC / Mục tiêu | Mô tả | Test (class#method hoặc ghi chú) | Loại |
|---------------|-------|-----------------------------------|------|
| … | … | … | unit / IT / E2E / N/A + lý do |

---

## 5. Khối theo loại task (giữ một khối — xóa các khối không dùng)

### A — FEATURE (phát triển tính năng)

- **User impact:** …
- **Checklist gợi ý:** DTO + validation → service → repo/DB → controller → test → cập nhật `docs/api/` nếu đổi contract.

### B — BUGFIX

- **Hiện tượng:** …
- **Chứng cứ (log, input):** …
- **Bước tái hiện:** 1. … 2. …
- **Giả thuyết nguyên nhân / hướng fix:** …
- **Regression:** test nào chứng minh không tái phát.

### C — REFACTOR

- **Lý do (smell / risk):** …
- **Phạm vi file / behavior:** (hành vi giữ nguyên trừ khi ghi rõ)
- **Chiến lược:** extract / rename / pattern …
- **Hồi quy:** `./mvnw test` + test biên nếu cần.

### D — SPIKE / CHORE / OPS (tùy)

- **Câu hỏi cần trả lời / việc cần làm:** …
- **Output mong đợi:** (doc, PoC, script — không nhất thiết AC→Test)

---

## 6. Checklist thực hiện (tùy chỉnh theo task)

- [ ] …
- [ ] …

---

## 7. Hướng dẫn cho AI (Instructions) — bắt buộc có ít nhất một dòng

- Ví dụ: “Đọc `rules/02-coding-standards.md`, làm theo `skills/backend/create-rest-api/SKILL.md`, không thêm dependency mà không hỏi.”

---

## 8. Câu hỏi mở & rủi ro

- … (trống = không còn blocker)

---

## 9. Nhật ký (Progress log)

- **[YYYY-MM-DD]** …

---

## 10. Definition of Done (tick trước khi MR)

- [ ] Code + test theo mục 4
- [ ] `./mvnw test` pass (hoặc lệnh team)
- [ ] Self-review `rules/08-review-checklist.md`
- [ ] MR mô tả + link ticket

**Last updated (template):** 2026-04-08
