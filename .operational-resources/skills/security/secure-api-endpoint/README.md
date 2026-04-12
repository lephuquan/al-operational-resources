# Secure API Endpoint (index)

## TL;DR (VI)

- **`SecurityFilterChain`**: phân tách **public** vs **authenticated**; matcher **cụ thể** — tránh để endpoint nhạy cảm **lọt** default permit.
- **Authn** (JWT / session / resource server): validate **một chỗ**; **không log** token, password, API key.
- **Authz**: rule **thô** (`@PreAuthorize`, `authorizeHttpRequests`); rule **nghiệp vụ** (ownership, state) ở **service** — xem `docs/architecture/09-security-architecture-backend.md`.
- **CSRF** khi dùng **cookie session**; **CORS** thu hẹp origin; **input** tại boundary — **`validate-input`**; **401/403** thống nhất — **`global-exception-handler`**.

## Thư mục này chứa gì

| File | Mục đích |
|------|----------|
| `SKILL.md` | Quy trình filter chain, authn/authz, CSRF/CORS, test |
| `examples.md` | Gợi ý `SecurityFilterChain`, `@PreAuthorize` |
| `checklist.md` | Gate trước merge |
| `README.md` | File này |

## Thứ tự khuyến nghị

1. Đọc contract team: `docs/api/04-authentication.md` và allowlist endpoint (`08-endpoint-list.md` nếu có).
2. Làm theo `SKILL.md`; chỉnh `global-exception-handler` cho mapping lỗi security nếu cần.
3. Chạy `checklist.md` và test 401/403.

## Liên kết nhanh

- `skills/security/validate-input/SKILL.md`
- `skills/security/security-review/SKILL.md`
- `skills/error-handling/global-exception-handler/README.md`
- `skills/devops/health-check-endpoint/README.md`
- `skills/integration/implement-webhook-handler/README.md`
- `docs/api/04-authentication.md`
- `docs/architecture/09-security-architecture-backend.md`

**Last updated:** 2026-04-11
