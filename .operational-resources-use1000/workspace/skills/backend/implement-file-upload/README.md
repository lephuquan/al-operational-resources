# Implement File Upload (index)

## TL;DR (VI)

- Playbook **upload multipart** an toàn: validate size/type, **sanitize** tên, lưu qua **service + storage abstraction** (local/S3).
- Controller mỏng; rủi ro bảo mật xem **`rules/06-security.md`**.
- Đi kèm **cấu hình** `spring.servlet.multipart.*` và test **MockMvc multipart**.

## Thư mục này chứa gì

| File | Mục đích |
|------|----------|
| `SKILL.md` | Quy trình: endpoint → validate → storage → metadata → config → test → docs |
| `examples.md` | Controller, service, port storage, yaml, MockMvc |
| `checklist.md` | Quality gate |
| `README.md` | File này |

## Thứ tự khuyến nghị

1. Chốt loại file, max size, nơi lưu trong task/spec.
2. Làm theo `SKILL.md`; tách `FileStorage` để dễ test.
3. Chạy `checklist.md`.
4. Cập nhật `docs/api/` nếu endpoint public.

## Liên kết nhanh

- `skills/performance/reduce-memory-usage/README.md` (streaming, không nạp full file vào heap)
- `rules/06-security.md`
- `docs/architecture/09-security-architecture-backend.md`
- `skills/backend/create-rest-api/SKILL.md`
- `skills/backend/create-service-layer/SKILL.md`
- `skills/workflow/implement-feature/README.md`

**Last updated:** 2026-04-11
