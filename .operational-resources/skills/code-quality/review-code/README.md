# Review Code (index)

## TL;DR (VI)

- Playbook **review có cấu trúc** (self hoặc peer): đúng thứ tự ưu tiên, comment **actionable**, tách **blocking** vs **nit**.
- Dùng **`checklist.md`** làm lưới; **`examples.md`** cho mẫu tóm tắt PR.
- Luôn đối chiếu **`rules/08-review-checklist.md`**.

## Thư mục này chứa gì

| File | Mục đích |
|------|----------|
| `SKILL.md` | Quy trình review đầy đủ + kết luận Approve / Request changes |
| `checklist.md` | Gate theo từng nhóm (correctness, security, test, …) |
| `examples.md` | Mẫu summary PR, inline comment, self-review trước push |
| `README.md` | File này |

## Thứ tự khuyến nghị

1. Đọc context PR/task.
2. Chạy qua `SKILL.md` hoặc đánh dấu trực tiếp `checklist.md`.
3. Viết kết luận theo khung `examples.md`.

## Liên kết nhanh

- `rules/08-review-checklist.md`
- `skills/security/security-review/README.md` (rà soát bảo mật sâu khi cần)
- `skills/code-quality/detect-code-smells/README.md`
- `skills/code-quality/refactor-clean-code/README.md`
- `skills/workflow/prepare-pull-request/README.md`

**Last updated:** 2026-04-11
