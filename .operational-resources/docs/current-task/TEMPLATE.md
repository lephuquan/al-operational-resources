# Task — [Tên ngắn gọn]

> **Quy ước:** Mỗi task = **một file** `YYYYMMDD-ten-task.md` trong **chỉ** `docs/current-task/`. Không tạo bản song song trong `rules/`.  
> Copy file này → đổi tên → xóa mục không dùng (theo loại task).

---

## Metadata (bắt buộc)

| Trường | Giá trị |
|--------|---------|
| **Loại task** | `feature` \| `bugfix` \| `refactor` \| `spike` \| `chore` \| `ops` |
| **ID file** | `YYYYMMDD-slug.md` |
| **Ticket / Issue** | Link hoặc mã (PROJ-123) |
| **Trạng thái** | Draft \| In Progress \| Review \| Blocked \| Done |
| **Ưu tiên** | High \| Medium \| Low |
| **Owner** | (bạn / team) |

---

## 0. Definition of Ready — trước khi nhờ AL code (bắt buộc đánh dấu)

Điền **trước** khi bắt đầu implementation lớn; nếu chưa đủ — ghi vào §11 hoặc tạm **Blocked**.

- [ ] Ticket/spec có **mục tiêu** và **AC** (hoặc đã ghi rõ “không có AC — chỉ mục tiêu kỹ thuật: …”).
- [ ] **Phạm vi** §2 đã điền; biết điều gì **không làm** (out of scope).
- [ ] **Câu hỏi mở** §11: không còn blocker — hoặc đã ghi **giả định tạm** để AL tiếp tục (sẽ xác nhận lại sau).
- [ ] Đã liệt kê **skills + docs** AL phải đọc ở §8 (ít nhất rules + 1 skill liên quan).
- [ ] Nếu thay đổi lớn so với ticket gốc: đã ghi ở **§7 Revision** và (khi cần) đã **sync với BA/Lead**.

---

## 1. Tóm tắt một dòng (bắt buộc)

[Một câu: làm gì, cho ai, kết quả kinh doanh/kỹ thuật là gì.]

---

## 2. Nguồn, phạm vi & giả định (bắt buộc)

### 2.1 Liên kết chính thức

- **Ticket / mô tả:** (link hoặc tóm tắt)
- **Spec:** `docs/specs/...` (nếu có)
- **API / contract:** `docs/api/...` (nếu đụng)
- **ADR liên quan:** `docs/decisions/...` (nếu có)

### 2.2 In scope / Out of scope

| In scope (làm trong task này) | Out of scope (không làm / ticket khác) |
|-------------------------------|------------------------------------------|
| … | … |

### 2.3 Giả định & phụ thuộc

- **Giả định** (nếu chưa xác nhận với BA): …
- **Phụ thuộc** (team khác, service khác, flag, DB migration): …

---

## 3. Acceptance criteria (bắt buộc khi có từ BA/Lead)

Nếu không có AC từ ticket — ghi: *“Không có AC riêng — mục tiêu kỹ thuật: …”* và vẫn có checklist có thể kiểm chứng.

- [ ] AC1: …
- [ ] AC2: …

### 3.1 Hành vi chi tiết (khuyến nghị cho feature — tránh AL chỉ làm happy path)

| Kịch bản | Kết quả mong đợi | Ghi chú |
|----------|------------------|---------|
| Happy path | … | |
| Lỗi nghiệp vụ / validation | … | mã lỗi / HTTP |
| Edge case (null, empty, concurrent, …) | … | |
| Thay đổi sau này (extensibility) | … | optional: interface ổn định, feature flag |

---

## 4. Ánh xạ AC → Test (bắt buộc trước khi coi xong — trừ spike/chore thuần tài liệu)

| AC / Mục tiêu | Mô tả | Test (class#method hoặc mô tả) | Loại |
|---------------|-------|-----------------------------------|------|
| … | … | … | unit / IT / E2E / N/A + lý do |

Cập nhật lại bảng này khi **§7** có thay đổi AC.

---

## 5. Non-functional & ràng buộc kỹ thuật (điền khi liên quan)

- **Performance / SLI:** (ví dụ p95, batch size)
- **Bảo mật:** (authz, PII, audit)
- **Tương thích / versioning API:** breaking hay không
- **Idempotency / retry:** (nếu có tích hợp ngoài)

---

## 6. Khối theo loại task — giữ **một** khối, xóa các khối khác

### A — FEATURE

- **User impact:** …
- **Luồng triển khai gợi ý:** DTO + validation → service → repo/DB → controller → test → `docs/api/` nếu đổi contract.
- **Mở rộng sau:** (optional) điểm nối để thêm field/rule mà không phá contract — ghi ở đây hoặc §3.1.

### B — BUGFIX

- **Hiện tượng / nghiệp vụ ảnh hưởng:** …
- **Chứng cứ:** log, input, môi trường
- **Tái hiện:** …
- **Hướng fix & regression test:** …

### C — REFACTOR

- **Smell / risk:** …
- **Hành vi giữ nguyên:** (trừ khi ticket cho phép đổi)
- **Chiến lược & hồi quy:** …

### D — SPIKE / CHORE / OPS

- **Output:** doc / PoC / runbook
- **AC → Test:** có thể N/A + lý do

---

## 7. Revision — cập nhật yêu cầu trong quá trình làm (bắt buộc ghi khi có thay đổi)

Khi AC hoặc phạm vi **đổi** so với lần mở task (dù nhỏ), ghi dòng mới — để AL và bạn không mất ngữ cảnh.

| Ngày | Thay đổi | Loại | Hành động (đã sync BA/Lead? cập nhật AC/test?) |
|------|----------|------|--------------------------------------------------|
| YYYY-MM-DD | Mô tả ngắn | Nhỏ (wording) / Trung bình (thêm AC) / **Lớn** (đổi hướng nghiệp vụ) | Ví dụ: đã cập nhật §3–4; cần ticket PROJ-456 |

**Quy ước:**

- **Thay đổi nhỏ:** cập nhật §3–4 và checklist; ghi một dòng ở đây.
- **Thay đổi lớn:** dừng implementation nếu chưa đồng ý với BA/Lead; hoặc tách task / ticket mới — ghi rõ trong cột Hành động.

---

## 8. Gói ngữ cảnh cho AL — rules, docs, skills (bắt buộc: ít nhất rules + 1 skill)

AL nên đọc (điền path thật; xóa dòng không dùng):

| Loại | Đường dẫn (ví dụ) |
|------|-------------------|
| Rules | `rules/00-personal-priority.md`, `rules/02-coding-standards.md`, … |
| Docs | `docs/architecture/system-overview.md`, `docs/api/...`, `docs/specs/...` |
| Skills | `skills/backend/create-rest-api/SKILL.md`, … |

**Prompt gợi ý (copy):**  
“Đọc file task này trước. Tuân thủ rules và skills trong bảng trên. Không thêm dependency / không đổi kiến trúc lớn mà không hỏi.”

---

## 9. Checklist thực hiện (tùy chỉnh)

- [ ] …
- [ ] …

---

## 10. Hướng dẫn chi tiết cho AI (bắt buộc — ít nhất 3 ý)

- **MUST:** … (ví dụ: Bean Validation trên DTO, không log PII)
- **SHOULD:** … (ví dụ: thêm integration test cho endpoint mới)
- **ASK FIRST:** … (ví dụ: thêm starter mới, đổi schema chung)

---

## 11. Câu hỏi mở, rủi ro & blocker

- … (trống = không blocker; hoặc ghi “đang chờ X”)

---

## 12. Nhật ký tiến độ (Progress log)

- **[YYYY-MM-DD]** Làm gì / phát hiện gì / quyết định gì (kèm link §7 nếu đổi scope)

---

## 13. Definition of Done (tick trước MR)

- [ ] §0 Definition of Ready đã được thỏa (hoặc điều chỉnh có chủ đích)
- [ ] Code + test khớp §3–4 (và §7 nếu đã revision)
- [ ] `./mvnw test` pass (hoặc lệnh team)
- [ ] Self-review `rules/08-review-checklist.md`
- [ ] MR: mô tả + link ticket + **How to test** + ảnh hưởng breaking (nếu có)

---

**Last updated (template):** 2026-04-08
