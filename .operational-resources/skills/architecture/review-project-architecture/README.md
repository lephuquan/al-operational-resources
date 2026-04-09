# Review Project Architecture (index)

## TL;DR (VI)

- Thư mục này dùng để **review kiến trúc hiện trạng** và ra hành động ưu tiên.
- Đọc `SKILL.md` để biết flow, dùng `checklist.md` để không sót mục, và `examples.md` để xuất báo cáo nhanh.

## Thư mục này chứa gì

| File | Mục đích |
|------|---------|
| `SKILL.md` | Playbook chính để review kiến trúc |
| `checklist.md` | Checklist chất lượng trước khi chốt findings |
| `examples.md` | Báo cáo mẫu + khung output tái sử dụng |
| `README.md` | File index và thứ tự sử dụng |

## Khi nào dùng

Nên dùng khi:

- Bạn cần health check kiến trúc nhanh trước khi lên kế hoạch feature
- Bạn nghi có vấn đề về layering/coupling/testability
- Bạn muốn hành động ưu tiên rõ ràng mà chưa cần mở refactor lớn

## Thứ tự khuyến nghị

1. Bắt đầu từ `SKILL.md` để chốt scope/timebox.
2. Đi qua `checklist.md` trong lúc review code.
3. Viết output theo khung trong `examples.md`.
4. Chia sẻ báo cáo gồm 3 strengths + 3 risks + hành động P0/P1/P2.

## Output kỳ vọng

- Review scope (review gì, trong bao lâu)
- Three strengths
- Three risks (kèm impact)
- Three prioritized actions (P0/P1/P2)
- Gợi ý first implementation slice

## Tài liệu tham chiếu chính

- `docs/architecture/01-README.md`
- `docs/architecture/02-system-overview.md`
- `docs/architecture/04-folder-structure.md`
- `docs/architecture/06-backend-layers-and-dependencies.md`
- `docs/architecture/09-security-architecture-backend.md`
- `docs/api/05-error-handling.md` (nếu review có phạm vi API error mapping)

## Bước tiếp theo sau review

Nếu báo cáo được chấp nhận và đưa vào thực thi:

- Thiết kế thay đổi lớn bằng `skills/architecture/design-feature-architecture/SKILL.md`
- Triển khai bằng `skills/workflow/implement-feature/SKILL.md`
