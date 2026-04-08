# Authentication and Authorization

## Token strategy

- **Access Token**: JWT, thoi han 15 phut, truyen qua `Authorization: Bearer <token>`
- **Refresh Token**: HttpOnly cookie, thoi han 7 ngay
- **Logout**: xoa refresh cookie + revoke token (neu co co che blacklist/rotation)

## Roles and permissions

- Roles: ADMIN, MANAGER, USER, GUEST
- Permissions: granular (`view:orders`, `create:orders`, ...)

## Protected routes

- Tat ca route `/api/v2/*` (tru public routes) yeu cau Access Token
- Authorization check tai service layer (khong chi dua vao annotation o controller)

## Current auth flow

- Login -> tra access token + set refresh token cookie
- Refresh -> `POST /api/v2/auth/refresh`

**Spring Boot:** Spring Security filter chain + `@PreAuthorize`/method security (theo team).
