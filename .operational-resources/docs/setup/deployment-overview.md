# Tổng quan triển khai (môi trường & pipeline)

## Mục đích

Tóm tắt **môi trường**, **cách artifact được build/deploy** và **liên kết tài liệu team** — ở mức đủ để ngữ cảnh (on-call, review MR ảnh hưởng deploy), **không** thay cho runbook hoặc wiki vận hành chính thức của tổ chức.

---

## Môi trường

| Môi trường | Mục đích | URL / endpoint (nếu được phép ghi) | Ghi chú |
|------------|----------|-------------------------------------|---------|
| Development | | | Thường trùng hoặc fork từ staging |
| Staging | UAT / demo | | |
| Production | Người dùng thật | | |

---

## Build & artifact

| Bước | Công cụ / nơi chạy | Output |
|------|---------------------|--------|
| CI build | `<!-- GitHub Actions / Jenkins / Azure DevOps -->` | `<!-- JAR, image Docker, … -->` |
| Versioning | `<!-- tag semver, build number -->` | |

---

## Triển khai (rút gọn)

```text
<!-- Ví dụ: merge vào main → pipeline → deploy lên k8s namespace X -->
```

Chi tiết quy trình phê duyệt, rollback — trỏ tài liệu team hoặc wiki nội bộ (một dòng URL nếu có).

---

## Quan hệ với chạy local

- `local-development.md` — **máy dev**.
- File này — **đường đi** của code sau khi merge; hữu ích khi task liên quan feature flag, config theo môi trường, hoặc migration DB trên staging trước prod.

---

**Last updated:** 2026-04-08
