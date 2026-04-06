# Security & Privacy Rules

Quy tắc bắt buộc khi coding.

## 1. Tuyệt đối không

- Hardcode API key, secret, password trong repo.
- Đưa dữ liệu khách hàng thật (PII) vào prompt AI.

## 2. Xử lý dữ liệu

- Validate input: **Jakarta Bean Validation** trên DTO (`@Valid`).
- API user-sensitive: authentication + authorization đầy đủ.
- Password: **BCrypt** / Argon2 (theo team).

## 3. Error handling

- Production: không trả full stack trace cho client.
- Dùng mã lỗi chuẩn trong `error-codes.md` + `api/error-handling.md`.
