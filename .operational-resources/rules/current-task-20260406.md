# Current Task: Thiết lập workspace AL — 06/04/2026

**Mô tả**: Hoàn thiện cấu trúc `.operational-resources/` (rules, docs, skills, notes) để làm việc với AI/AL tối ưu, không ảnh hưởng team.

**Ticket / Issue**: [n/a — công việc cá nhân]

## Requirements

- [x] `AGENTS.md` và bộ `rules/` đầy đủ, đường dẫn `.operational-resources/`
- [x] `docs/` skeleton + templates
- [x] `skills/` + `notes/` khởi tạo

## References

- Architecture: `.operational-resources/docs/architecture/`
- API (personal): `.operational-resources/docs/api/`
- Rules priority: `.operational-resources/rules/00-personal-priority.md`

## Notes & decisions

- Git: thư mục `.operational-resources/` được ignore cục bộ qua `.git/info/exclude` để không đụng team.
- Khi bắt task mới: copy cấu trúc file này → `current-task-YYYYMMDD-ten-task.md` và cập nhật bảng trong `docs/current-task/README.md` nếu dùng dashboard.
