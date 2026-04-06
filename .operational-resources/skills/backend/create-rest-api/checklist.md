# Checklist: Create REST API

- [ ] Path + HTTP method đúng REST semantics
- [ ] Request DTO có `@Valid` và constraint đủ
- [ ] Response shape khớp envelope dự án (`success` / `data` / `error` nếu dùng)
- [ ] Không logic nghiệp vụ nặng trong controller
- [ ] Status code: 201 cho create, 204 nếu no body, 404 khi không tìm thấy resource
- [ ] Test: ít nhất một test happy path + một validation/error case
- [ ] Ghi endpoint vào `docs/api/endpoint-list.md`
