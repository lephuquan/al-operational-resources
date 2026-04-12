# Create REST API (index)

## TL;DR (VI)

- Playbook thêm **REST endpoint** (Spring): DTO, validation, controller mỏng, HTTP đúng, test tối thiểu.
- Bám **`docs/api/`** + **`rules/03-api-development.md`**; lỗi xử lý tập trung qua **`@ControllerAdvice`**.
- Service logic: **`skills/backend/create-service-layer`**.

## Thư mục này chứa gì

| File | Mục đích |
|------|----------|
| `SKILL.md` | Quy trình đầy đủ từ contract → DTO → controller → error → test → docs |
| `examples.md` | Snippet Java, JSON envelope, WebMvcTest, cURL |
| `checklist.md` | Quality gate trước merge |
| `README.md` | File này — thứ tự dùng |

## Thứ tự khuyến nghị

1. Chốt contract trong task / `docs/api/`.
2. Làm theo `SKILL.md` (hoặc song song tạo service trong slice cùng endpoint).
3. Chạy `checklist.md`.
4. Tham chiếu `examples.md` khi cần copy nhanh.

## Liên kết nhanh

- `skills/performance/optimize-api-response/README.md` (gọn payload, pagination)
- `docs/api/01-README.md`, `docs/api/03-response-format.md`
- `rules/03-api-development.md`
- `skills/backend/create-service-layer/SKILL.md`
- `skills/error-handling/global-exception-handler/README.md`
- `skills/workflow/implement-feature/README.md`

**Last updated:** 2026-04-11
