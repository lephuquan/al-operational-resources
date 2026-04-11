# Detect Code Smells (index)

## TL;DR (VI)

- Playbook **nhận diện** code smells trong Java/Spring trên scope đã chốt — **không** bắt buộc refactor ngay.
- Dùng `SKILL.md` cho quy trình, `examples.md` cho khung báo cáo, `checklist.md` để không sót nhóm smell.
- Sau khi có danh sách: chuyển sang **`refactor-clean-code`** hoặc tạo task/PR từng bước.

## Thư mục này chứa gì

| File | Mục đích |
|------|----------|
| `SKILL.md` | Quy trình quét smell + ưu tiên + output |
| `examples.md` | Mẫu bảng báo cáo và mô tả một smell |
| `checklist.md` | Quality gate cho bản scan |
| `README.md` | File này |

## Thứ tự khuyến nghị

1. Chốt scope (PR diff / package / module).
2. Đọc `SKILL.md` và quét theo từng nhóm.
3. Điền báo cáo theo `examples.md`.
4. Chạy `checklist.md` trước khi chia sẻ kết quả.

## Liên kết nhanh

- `rules/02-coding-standards.md`, `rules/08-review-checklist.md`
- `skills/code-quality/review-code/SKILL.md`
- `skills/code-quality/refactor-clean-code/SKILL.md`
- `skills/database/optimize-query/SKILL.md`

**Last updated:** 2026-04-09
