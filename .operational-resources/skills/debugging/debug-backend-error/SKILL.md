# Skill: Debug Backend Error (Local)

## Goal

Xử lý lỗi backend trong môi trường dev/local: tái hiện nhanh, khoanh vùng lớp, fix tối thiểu, có regression test.

## Steps

1. Thu thập: stack trace đầy đủ, request (method, URL, body redacted), version code/branch.
2. Tái hiện với input tối thiểu (Postman/curl/MockMvc).
3. Khoanh vùng: Controller vs Service vs Repository vs integration (DB, HTTP client).
4. Bật log DEBUG tạm cho package liên quan (không commit log noisy).
5. Fix nhỏ nhất; thêm test chứng minh bug đã hết.
6. Cập nhật `docs/notes/debugging/bug-history.md` nếu là lỗi hay gặp lại.

## References

- `debugging/analyze-stacktrace/SKILL.md`
