# 06 - Security Rules

- Tuyệt đối không hardcode **secret**, API key, password trong code hoặc commit.
- Mọi input từ client phải **validate** (Bean Validation) và **sanitize** khi cần (path, query, body).
- **Rate limiting** trên public API khi team/triển khai hỗ trợ (gateway hoặc filter).
- **HTTPS** ở production; **CORS** cấu hình đúng môi trường.
- **Authentication**: JWT / session / OAuth — theo chuẩn team; nếu dùng JWT, cân nhắc **refresh token** an toàn (HttpOnly cookie hoặc flow team định nghĩa).
- Không log dữ liệu nhạy cảm (password, token đầy đủ, PII không cần thiết).
- **Authorization** kiểm tra ở **service layer** (không chỉ dựa vào “ẩn” ở controller).
