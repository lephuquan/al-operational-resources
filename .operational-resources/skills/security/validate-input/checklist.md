# Checklist: Validate Input

Dùng trước merge khi thêm/sửa **DTO**, **endpoint**, hoặc **handler** lỗi validation.

## DTO & binding

- [ ] Request DTO **chỉ** chứa field client được phép gửi cho use case đó (không có field privilege / trạng thái nội bộ bind từ JSON).
- [ ] Ràng buộc **Bean Validation** đủ cho null/trống/độ dài/dải giá trị/format cơ bản.

## Trigger validation

- [ ] `@RequestBody` có **`@Valid`** (hoặc `@Validated` + group đúng).
- [ ] Query/path/header: đã ràng buộc bằng cách team chọn (validated params hoặc DTO wrapper).

## Custom & edge cases

- [ ] Nếu có **`Map`** / JSON tự do: có **whitelist** hoặc validate tường minh — không nhận object lồng bất kỳ không kiểm soát.

## Service layer

- [ ] Rule nghiệp vụ (số dư, ownership, state) vẫn kiểm tra ở **service** / domain — không chỉ tin annotation.

## Errors

- [ ] Lỗi validation map về **400** và format API chuẩn; không lộ **SQL**, **stack**, message nội bộ cho client production.

## Tests

- [ ] Có test **negative** (payload sai) cho DTO/endpoint quan trọng.

**Last updated:** 2026-04-11
