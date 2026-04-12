# Security Review (index)

## TL;DR (VI)

- Playbook **rà soát bảo mật** trước merge / release: **secret**, **injection**, **authz/IDOR**, **lộ dữ liệu**, **log**, **dependency**, **cấu hình** (CORS, upload, redirect).
- Dùng **`checklist.md`** làm gate; **`SKILL.md`** là thứ tự đọc diff và câu hỏi cần trả lời.
- Neo **`secure-api-endpoint`** (triển khai), **`validate-input`** hub (boundary), **`review-code`** (PR tổng quát), **`rules/06-security.md`**.

## Thư mục này chứa gì

| File | Mục đích |
|------|----------|
| `SKILL.md` | Quy trình review: scope, secret, injection, authz, data, deps, verify |
| `checklist.md` | Danh mục tick (PR / release) |
| `examples.md` | Gợi ý lệnh grep, dependency scan, kịch bản IDOR |
| `README.md` | File này |

## Thứ tự khuyến nghị

1. Xác định **scope** thay đổi (API mới, payment, file, admin, outbound URL).
2. Chạy theo `SKILL.md`; tick `checklist.md`.
3. Must-fix ghi vào PR; cái còn lại backlog có ticket nếu cần.

## Liên kết nhanh

- `skills/security/secure-api-endpoint/README.md`
- `skills/security/validate-input/README.md`
- `skills/code-quality/review-code/README.md`
- `rules/06-security.md`
- `docs/architecture/09-security-architecture-backend.md`
- `docs/api/04-authentication.md`

**Last updated:** 2026-04-11
