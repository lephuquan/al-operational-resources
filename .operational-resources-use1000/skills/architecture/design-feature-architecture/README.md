# Design Feature Architecture (index)

## TL;DR (VI)

- Thư mục này dùng để **thiết kế feature trước khi code** theo trình tự rõ ràng.
- Đi theo thứ tự: `SKILL.md` -> `examples.md` -> `checklist.md`.
- Đầu ra cuối: một **design note** đủ để implement, và **ADR** khi quyết định có tính dài hạn.

## Thư mục này chứa gì

| File | Mục đích |
|------|----------|
| `SKILL.md` | Playbook chính: làm gì, theo thứ tự nào, đầu ra tối thiểu là gì |
| `examples.md` | Ví dụ tham chiếu + mẫu dán nhanh (paste-ready template) |
| `checklist.md` | Quality gate để tự soát trước khi chuyển sang code |
| `README.md` | Index/hướng dẫn sử dụng end-to-end |

## Khi nào dùng skill này

Nên dùng khi:

- Bắt đầu **new feature** hoặc mở rộng lớn (major extension)
- Thay đổi chạm nhiều lớp: **API + data + transactions + integrations**
- Cần ghi rõ trade-off trước khi code để tránh rework

Không cần dùng quá nặng cho CRUD nhỏ, ít impact kiến trúc.

## Thứ tự khuyến nghị

1. Đọc `SKILL.md` để chốt scope, boundaries, assumptions.
2. Dùng khung trong `examples.md` để soạn design note cho task hiện tại (`docs/current-task/*.md`).
3. Chạy `checklist.md` để phát hiện lỗ hổng trước khi implement.
4. Nếu quyết định quan trọng/khó đảo ngược, tạo ADR từ `docs/decisions/TEMPLATE.md`.
5. Handoff sang implementation với trạng thái rõ ràng: **Ready** hoặc **Blocked**.

## Gói output kỳ vọng

Bắt buộc có:

- Scope và non-goals
- Layer boundaries + API behavior
- Data impact (migration/index/constraint)
- Top risks + mitigations

Tùy trường hợp:

- ADR file + cập nhật index tại `docs/decisions/README.md`

## Tài liệu cần đọc trước (read-first)

- `docs/architecture/01-README.md`
- `docs/architecture/02-system-overview.md`
- `docs/architecture/04-folder-structure.md`
- `docs/architecture/06-backend-layers-and-dependencies.md`
- `docs/architecture/08-transactions-and-consistency.md`
- `docs/architecture/09-security-architecture-backend.md`

## Handoff sang triển khai

Khi design note đã rõ và checklist không còn blocker nghiêm trọng, chuyển sang:

- `skills/workflow/implement-feature/SKILL.md`
