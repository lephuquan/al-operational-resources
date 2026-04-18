# Hướng dẫn: triển khai / mở rộng `docs/`, `skills/`, `rules/`

## Mục đích

Dùng khi **clone workspace mới**, **onboard** AI context, hoặc **bổ sung** một lớp tài liệu (quy tắc, kiến trúc, playbook) mà **không** gói trong một task sản phẩm cụ thể — hoặc khi task riêng “dựng khung tài liệu” cần checklist rõ.

## Nguyên tắc

- **`rules/`** = luật ưu tiên; **`docs/`** = ngữ cảnh dự án; **`skills/`** = cách làm lặp lại (playbook). Không trộn **task đang chạy** vào `rules/` (task chỉ ở `current-task/`).
- Phần **chạy được** (code, `pom.xml`, CI) vẫn ở tree chính repo; `.operational-resources/` chỉ **bản đồ + quy trình**.

## Thứ tự bootstrap (khuyến nghị)

1. **Bản đồ tổng:** **`.operational-resources/MAP.md`** — hiểu cây thư mục.
2. **AI + ưu tiên:** **`.operational-resources/AGENTS.md`** → **`rules/00-personal-priority.md`** → các **`rules/*.md`** liên quan stack (API, security, testing, …).
3. **Docs — khung đọc:** **`.operational-resources/docs/README.md`** rồi lần lượt:
   - **`docs/project-overview.md`**
   - **`docs/architecture/01-README.md`**, **`02-system-overview.md`**
   - **`docs/setup/01-README.md`** (local, env)
   - **`docs/api/01-README.md`** nếu có HTTP contract cá nhân
4. **Quyết định & đặc tả (khi cần):**
   - ADR: **`docs/decisions/README.md`** + **`TEMPLATE.md`**
   - Feature spec: **`docs/specs/README.md`** + **`TEMPLATE.md`**
5. **Thêm skill / topic mới:** **`.operational-resources/skills/HOW-TO-ADD-TOPIC.md`**
   - Copy **`skills/SKILL-TEMPLATE.md`** → `skills/<nhóm>/<tên>/SKILL.md`
   - (Tuỳ độ phức tạp) thêm **`README.md`**, **`checklist.md`**, **`examples.md`** — xem các hub mẫu trong `skills/README.md`
   - **Đăng ký** dòng trong **`skills/README.md`**; cập nhật **`MAP.md`** nếu thêm nhóm hoặc thay đổi mô tả `skills/`
6. **Catalog skill:** **`.operational-resources/skills/README.md`** — đảm bảo skill mới có hub line nếu theo pattern hub.

## Checklist nhanh sau khi bổ sung

- [ ] Path trong **References** của skill trỏ đúng file tồn tại
- [ ] **`skills/README.md`** có dòng (và hub nếu có)
- [ ] **`MAP.md`** hàng tương ứng còn đúng (nếu đổi cấu trúc)

Sau khi ổn định hoặc theo chu kỳ: chạy **[`review-and-update-docs-skills-rules.md`](review-and-update-docs-skills-rules.md)**.

**Last updated:** 2026-04-11
