# Skill: Implement File Upload

## Goal

Nhận file multipart an toàn: giới hạn kích thước, loại MIME, lưu storage (local/S3), không path traversal.

## Steps

1. Endpoint: `multipart/form-data` với `@RequestParam("file") MultipartFile file`.
2. Validate: kích thước tối đa, extension/MIME whitelist, tên file sanitize.
3. Lưu: service ghi blob (filesystem hoặc object storage); trả URL hoặc id tham chiếu.
4. Không lưu file trong DB dạng BLOB lớn trừ khi team yêu cầu.
5. Cấu hình `spring.servlet.multipart.*` (max-file-size, max-request-size).
6. Test: MockMvc với multipart hoặc integration test.

## References

- `rules/06-security.md`
