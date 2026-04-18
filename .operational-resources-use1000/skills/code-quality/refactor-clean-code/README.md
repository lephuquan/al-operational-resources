# Refactor Clean Code (index)

## TL;DR (VI)

- Playbook **refactor an toàn**: test là lưới an toàn, **bước nhỏ**, giữ **hành vi**, PR gọn.
- Thường dùng **sau** `detect-code-smells` hoặc khi task ghi rõ “refactor only”.
- Xem `SKILL.md` cho quy trình, `checklist.md` trước merge, `examples.md` cho mẫu ghi MR/task.

## Thư mục này chứa gì

| File | Mục đích |
|------|----------|
| `SKILL.md` | Quy trình: bảo vệ hành vi → micro-steps → contract → commit discipline |
| `examples.md` | Mẫu ghi chú MR/task + chuỗi bước + anti-pattern |
| `checklist.md` | Gate trước/sau refactor |
| `README.md` | File này |

## Thứ tự khuyến nghị

1. Có test + scope rõ.
2. (Tuỳ chọn) Danh sách smell từ `detect-code-smells`.
3. Làm theo `SKILL.md` từng bước nhỏ.
4. Chạy `checklist.md` trước merge.

## Liên kết nhanh

- `skills/code-quality/detect-code-smells/README.md`
- `skills/code-quality/review-code/SKILL.md`
- `skills/testing/write-unit-test/README.md`
- `current-task/TEMPLATE.md`
- `rules/02-coding-standards.md`, `rules/08-review-checklist.md`

**Last updated:** 2026-04-09
