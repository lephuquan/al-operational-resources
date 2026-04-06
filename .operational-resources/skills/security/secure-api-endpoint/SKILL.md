# Skill: Secure API Endpoint

## Goal

Bảo vệ endpoint: authentication, authorization, CSRF (nếu session), method security.

## Steps

1. Phân loại public vs authenticated routes trong `SecurityFilterChain`.
2. Dùng `@PreAuthorize` / `authorizeHttpRequests` theo policy team.
3. Kiểm tra quyền ở **service** cho rule nghiệp phức tạp.
4. Rate limit / IP allowlist nếu có gateway.
5. Test: user không có role → 403.

## References

- `docs/api/authentication.md`
