# Prepare Pull Request (index)

## TL;DR (VI)

- PR **nhỏ, đọc được**: diff tập trung; tránh **noise** format + file vô tình; **self-review** trước khi mời người khác.
- Mô tả chuẩn: **What / Why / How to test / Risk & rollback**; **link ticket** + (khi có) link task `docs/current-task/`.
- Chạy **test + lint/format** theo team; đối chiếu **`rules/08-review-checklist.md`** và **`review-code`** hub nếu dùng.

## Thư mục này chứa gì

| File | Mục đích |
|------|----------|
| `SKILL.md` | Quy trình: diff, quality gate, mô tả PR, reviewer |
| `checklist.md` | Gate trước khi bấm Create MR / Ready for review |
| `examples.md` | Khung markdown mô tả PR, nhánh, draft |
| `README.md` | File này |

## Thứ tự khuyến nghị

1. `git status` + `git diff` — đảm bảo scope đúng ticket.
2. Làm theo `SKILL.md`; tick `checklist.md`.
3. Dán mô tả từ `examples.md` (chỉnh nội dung thật).

## Liên kết nhanh

- `rules/08-review-checklist.md`
- `skills/code-quality/review-code/README.md`
- `skills/workflow/implement-feature/README.md`
- `skills/workflow/investigate-bug/README.md`
- `docs/current-task/TEMPLATE.md` (§13 DoD)
- `WORKFLOW.md` (mục MR)

**Last updated:** 2026-04-11
