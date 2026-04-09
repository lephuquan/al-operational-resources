# Review Project Architecture (index)

## TL;DR (VI)

- Thư mục này dùng để **review kiến trúc hiện trạng** và ra hành động ưu tiên.
- Đọc `SKILL.md` để biết flow, dùng `checklist.md` để không sót mục, và `examples.md` để xuất báo cáo nhanh.

## Folder contents

| File | Purpose |
|------|---------|
| `SKILL.md` | Main playbook for architecture review |
| `checklist.md` | Quality checklist before finalizing findings |
| `examples.md` | Sample reports and reusable output skeleton |
| `README.md` | This index and usage order |

## When to use

Use when:

- You need a quick architecture health check before planning a feature
- You suspect layering/coupling/testability issues
- You want prioritized actions without starting a large refactor

## Recommended order

1. Start with `SKILL.md` and set scope/timebox.
2. Walk through `checklist.md` while reviewing code.
3. Write output using `examples.md` skeleton.
4. Share report with 3 strengths + 3 risks + P0/P1/P2 actions.

## Expected output

- Review scope (what was reviewed and for how long)
- Three strengths
- Three risks (with impact)
- Three prioritized actions (P0/P1/P2)
- Suggested first implementation slice

## Key references

- `docs/architecture/01-README.md`
- `docs/architecture/02-system-overview.md`
- `docs/architecture/04-folder-structure.md`
- `docs/architecture/06-backend-layers-and-dependencies.md`
- `docs/architecture/09-security-architecture-backend.md`
- `docs/api/05-error-handling.md` (if API error mapping is in scope)

## Next step after review

If the report is accepted and actioned:

- Design major changes via `skills/architecture/design-feature-architecture/SKILL.md`
- Execute implementation via `skills/workflow/implement-feature/SKILL.md`
