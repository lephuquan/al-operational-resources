# Checklist: Create REST API

Dùng trước khi merge slice API. Bỏ qua mục không áp dụng.

## Contract & routing

- [ ] Path + HTTP method đúng semantics và versioning team (`/api/vX/...`)
- [ ] Request/response khớp draft trong `docs/api/` hoặc task (field names, nullability)

## DTO & validation

- [ ] Request DTO có `@Valid` và đủ constraint Jakarta Validation
- [ ] Không expose entity JPA trực tiếp ra JSON (dùng DTO/response object)

## Controller

- [ ] Controller chỉ: mapping, validation trigger, gọi service, build response
- [ ] Status code hợp lý: ví dụ **201** create, **204** no body, **404** resource không tồn tại, **409** conflict (nếu nghiệp vụ có)

## Lỗi

- [ ] Không try/catch business exception rải rác; dùng `@ControllerAdvice` (hoặc pattern team đã chuẩn)
- [ ] Error envelope / mã lỗi nhất quán với `docs/api/` và project

## Security

- [ ] Endpoint có authz đúng (public vs authenticated vs role) nếu feature nhạy cảm

## Test

- [ ] Ít nhất một test happy path + một test validation hoặc error case
- [ ] Mock/stub service đúng với `@WebMvcTest` (không load full context không cần thiết)

## Docs

- [ ] Đã cập nhật `docs/api/08-endpoint-list.md` và `docs/api/10-current-api-changes.md` khi đổi contract

## An toàn

- [ ] Không log full request chứa PII/token; không hardcode secret trong code hoặc ví dụ

**Last updated:** 2026-04-09
