# Skill: Implement File Upload

## TL;DR (VI)

- Nhận **`multipart/form-data`** an toàn: giới hạn **size**, **MIME/extension whitelist**, tên file **sanitize**, chống **path traversal**.
- Logic lưu file nằm ở **service** + abstraction storage (local / S3-compatible); controller chỉ nhận `MultipartFile` và gọi service.
- Bám **`rules/06-security.md`** và cấu hình **`spring.servlet.multipart.*`**.

## Goal

Triển khai luồng upload file (một hoặc nhiều file) với kiểm soát rủi ro: từ chối payload quá lớn, loại file không cho phép, tên path nguy hiểm; lưu trữ ổn định (disk hoặc object storage) và trả về **id / URL an toàn** cho client — không lộ đường dẫn nội bộ server.

## Preconditions

- Đã biết nơi lưu (local path, bucket S3, …) và giới hạn dung lượng/loại file theo nghiệp vụ.
- Spring Boot đã bật multipart (mặc định có); biết profile `application*.yml` của dự án.
- Endpoint không conflict với contract hiện có trong `docs/api/` (cập nhật docs nếu là API công khai).

## Steps

1. **Endpoint (controller)**
   - `consumes = MULTIPART_FORM_DATA`, `@RequestParam("file") MultipartFile file` (hoặc `MultipartFile[]` / `List` nếu multi).
   - Không tin tưởng `file.getOriginalFilename()` cho path; chỉ dùng sau sanitize hoặc bỏ qua, tạo tên mới (UUID + extension hợp lệ).

2. **Validation tại service (hoặc dedicated validator)**
   - `file.isEmpty()` → 400.
   - Kích thước: so với max đã cấu hình + check thêm trong code nếu cần per-use-case.
   - MIME: `file.getContentType()` + (khuyến nghị) kiểm tra **magic bytes** / thư viện detect thật nếu risk cao — không chỉ tin header.
   - Extension whitelist khớp loại cho phép (ảnh, PDF, …).

3. **Lưu trữ**
   - Ghi blob qua service: `FileStorage` / `ObjectStorageClient` interface để dễ test và đổi backend.
   - Local: ghi ra thư mục **ngoài** webroot; tên file = random + extension; không join user input vào path.
   - S3-compatible: key prefix cố định + id; ACL/private theo policy.

4. **Metadata (tuỳ nghiệp vụ)**
   - Lưu bản ghi DB: `stored_name`, `original_name` (optional), `content_type`, `size`, `owner_id`, `created_at` — tránh BLOB lớn trong DB trừ khi team yêu cầu.

5. **Cấu hình**
   - `spring.servlet.multipart.max-file-size`, `max-request-size` đồng bộ với giới hạn nghiệp vụ.
   - Timeout / connection size nếu qua reverse proxy (ghi chú trong task hoặc `docs/setup/`).

6. **Lỗi HTTP**
   - Validation/storage fail → 400 / 413 / 415 / 500 phù hợp; map qua `@ControllerAdvice` thống nhất với `docs/api/`.

7. **Test**
   - `MockMvc` với `multipart(...)` + file mock; hoặc integration test với temp dir.
   - Case: empty file, oversize (mock), wrong type, happy path.

## Output

- Controller endpoint + service storage + (tuỳ chọn) entity/record metadata + test.
- Cập nhật `docs/api/` (endpoint list / changelog) nếu API public.

## References

- `rules/06-security.md`
- `skills/security/validate-input/README.md` (DTO / `@Valid` cho metadata kèm file)
- `docs/architecture/09-security-architecture-backend.md`
- `docs/api/02-api-overview.md`, `docs/api/08-endpoint-list.md`, `docs/api/10-current-api-changes.md`
- `skills/backend/create-rest-api/SKILL.md`
- `skills/backend/create-service-layer/SKILL.md`
- `skills/backend/create-jpa-entity/SKILL.md` (metadata entity nếu cần)
- `skills/performance/reduce-memory-usage/README.md`

**Last updated:** 2026-04-11
