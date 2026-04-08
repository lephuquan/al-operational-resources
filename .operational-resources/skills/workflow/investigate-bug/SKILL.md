# Skill: Investigate Bug

## Goal

Điều tra bug có phương pháp: giả thuyết → chứng cứ → fix → không tái diễn.

## Steps

1. Thu thập: bước tái hiện, log, version, môi trường.
2. Tái hiện cục bộ; thu hẹp component.
3. `debugging/analyze-stacktrace` nếu có exception.
4. Viết failing test trước khi sửa (khi khả thi).
5. Fix tối thiểu; ghi `notes/debugging/bug-history.md` nếu là lỗi hay gặp.

## References

- `docs/current-task/TEMPLATE.md` (khối bugfix)
