# Examples: Investigate Bug

Không dán secret/PII. Thay `PROJ-123`, path cho đúng repo.

## Bảng giả thuyết — bằng chứng

| # | Giả thuyết | Thử gì | Kết quả | Kết luận |
|---|------------|--------|---------|----------|
| H1 | Null `dueDate` khi timezone Asia/HCM | Unit test + log tại mapper | Fail với NPE tại dòng X | **Xác nhận** |
| H2 | Cache stale | Tắt cache local | Vẫn lỗi | Loại trừ |
| H3 | DB sai timezone | Query `... AT TIME ZONE` trên staging | Khớp bug | Hỗ trợ H1 |

## Mẫu progress log (trong task §12)

```markdown
- **2026-04-11:** Thu thập log PROJ-123; stack → `OrderMapper.toDto` NPE.
- **2026-04-11:** Repro local với payload từ ticket (redacted); thêm unit test failing.
- **2026-04-11:** Fix null guard + test green; MR !456.
```

## Gợi ý Context pack (§8) cho bugfix

| Kind | Paths |
|------|--------|
| Skills | `skills/workflow/investigate-bug/README.md`, `skills/debugging/analyze-stacktrace/README.md`, `skills/debugging/debug-backend-error/README.md` |
| Rules | `rules/02-coding-standards.md`, `rules/06-security.md` |

**Last updated:** 2026-04-11
