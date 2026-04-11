# Checklist: Implement File Upload

Dùng trước khi merge slice upload. Bỏ qua mục không áp dụng.

## Endpoint & contract

- [ ] `Content-Type` multipart đúng; tên part (`file`) khớp client
- [ ] Response không lộ đường dẫn tuyệt đối server / bucket internal path nhạy cảm

## Validation

- [ ] Từ chối file rỗng
- [ ] Giới hạn size: config `spring.servlet.multipart.*` + logic nghiệp vụ (nếu cần)
- [ ] Whitelist extension và/hoặc MIME; cân nhắc verify nội dung thật (magic) nếu risk cao
- [ ] Sanitize / bỏ qua `originalFilename` khi build path; chống path traversal (`..`, absolute path)

## Lưu trữ

- [ ] File local nằm ngoài webroot có thể execute trực tiếp
- [ ] Object storage: key có prefix, quyền private mặc định nếu không public
- [ ] Không lưu BLOB lớn trong DB trừ khi có quyết định rõ

## Bảo mật

- [ ] Authz: chỉ user/role được phép upload (nếu API nhạy cảm)
- [ ] Không log nội dung file / path chứa PII
- [ ] (Tuỳ chính sách) virus scan / async pipeline — ghi rõ trong task nếu có

## Test

- [ ] Happy path multipart
- [ ] Empty / oversize / sai loại (ít nhất một negative case)
- [ ] Service/storage mock hoặc temp dir sạch sau test

## Docs

- [ ] Đã cập nhật `docs/api/08-endpoint-list.md` và `10-current-api-changes.md` nếu endpoint public

**Last updated:** 2026-04-09
