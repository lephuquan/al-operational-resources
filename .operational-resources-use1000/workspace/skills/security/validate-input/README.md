# Validate Input (index)

## TL;DR (VI)

- **Boundary đầu tiên**: DTO request + **Bean Validation** (`@Valid`, `@NotNull`, `@Size`, `@Pattern`, …); không tin client — rule nghiệp vụ vẫn kiểm tra ở **service**.
- Tránh **mass assignment** (bind `role`, `balance`, flag nội bộ); dùng **DTO read-only** hoặc **record** có field tối thiểu cho từng use case.
- Thông báo lỗi **an toàn** (không lộ schema/stack); neo **`global-exception-handler`** và `docs/api/05-error-handling.md`.
- Rà soát rủi ro: **`security-review/checklist.md`**.

## Thư mục này chứa gì

| File | Mục đích |
|------|----------|
| `SKILL.md` | Quy trình DTO, annotation, group, custom constraint, service, error |
| `checklist.md` | Gate trước merge |
| `examples.md` | Snippet DTO, controller, `@Constraint` |
| `README.md` | File này |

## Thứ tự khuyến nghị

1. Chốt field được phép từ client cho từng endpoint (contract / OpenAPI).
2. Làm theo `SKILL.md`; map lỗi 400 thống nhất qua handler dự án.
3. Chạy `checklist.md`.

## Liên kết nhanh

- `skills/security/secure-api-endpoint/README.md`
- `skills/security/security-review/README.md`
- `skills/error-handling/global-exception-handler/README.md`
- `skills/backend/create-rest-api/README.md`
- `docs/architecture/09-security-architecture-backend.md`
- `docs/api/05-error-handling.md`

**Last updated:** 2026-04-11
