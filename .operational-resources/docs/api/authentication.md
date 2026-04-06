# Authentication & Authorization

## Token strategy (ví dụ — đồng bộ với ADR team)

- **Access Token**: JWT, thời hạn 15 phút, truyền qua `Authorization: Bearer <token>`
- **Refresh Token**: HttpOnly cookie, thời hạn 7 ngày
- **Logout**: xóa refresh cookie + revoke token (nếu có cơ chế blacklist/rotation)

## Roles & permissions

- Roles: ADMIN, MANAGER, USER, GUEST
- Permissions: granular (`view:orders`, `create:orders`, …)

## Protected routes

- Tất cả route `/api/v2/*` (trừ public routes) yêu cầu Access Token
- Authorization check tại **service layer** (không chỉ dựa vào annotation ở controller)

## Current auth flow

- Login → trả access token + set refresh token cookie
- Refresh → `POST /api/v2/auth/refresh`

**Spring Boot:** Spring Security filter chain + `@PreAuthorize` / method security (theo team).
