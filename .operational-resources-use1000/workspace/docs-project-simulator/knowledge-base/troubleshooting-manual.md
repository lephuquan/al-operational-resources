# Troubleshooting & Hallucination Manual

## 1. Khi AI lặp lỗi (error loop)

- **Dấu hiệu**: sửa mãi vẫn lỗi cũ hoặc lỗi lan sang chỗ khác không có căn cứ.
- **Cách xử lý**:
  1. Yêu cầu “stop and think step-by-step”.
  2. Dán log đầy đủ từ terminal (stdout + stacktrace).
  3. Yêu cầu liệt kê 3 hướng tiếp cận khác nhau rồi chọn một.

## 2. Khi AI dùng API cũ / sai version

- Dán đoạn tài liệu chính thức (Spring Boot 3.x, dependency thực tế trong `pom.xml`).

## 3. Verify sau khi AI gen code

- Chạy `./mvnw test` (hoặc `mvn test`).
- Chạy formatter/checkstyle nếu team có.
- Yêu cầu test mới cho bug fix quan trọng.
