# Examples: Implement feature với AL

Không chứa secret. Thay `<task>`, tên file, path cho đúng repo.

## Mẫu prompt — một slice (khuyến nghị)

```text
Context:
- Task file: docs/current-task/<task>.md
- Rules: rules/02-coding-standards.md, rules/03-api-development.md (điều chỉnh theo task)
- Skills: skills/backend/create-rest-api/README.md, skills/backend/create-service-layer/README.md, skills/testing/create-test-data/README.md
- Constraints: không đổi package root; không thêm dependency mới; không đổi public API ngoài scope slice

Task:
- Implement slice: POST /api/v1/... (chỉ endpoint + DTO + service stub + một integration test happy path)
- Giữ diff nhỏ; không refactor module khác.

Expected output:
- Danh sách file đã sửa/tạo
- Lệnh test đã chạy và kết quả
- Cập nhật bảng AC → Test trong task file (markdown snippet)
```

## Mẫu ghi progress log trong task

```markdown
## Progress log

- 2026-04-09: Slice 1 — POST ... + OrderService.create stub + IT happy path; mvn test OK.
- 2026-04-10: Slice 2 — validation errors + error code XYZ; mvn test OK.
```

## Mẫu chia slice (gợi ý)

| Slice | Nội dung | Done khi |
|-------|----------|----------|
| 1 | Endpoint + DTO + service + happy IT | AC1 có test |
| 2 | Validation + error mapping | AC2 có test |
| 3 | DB/migration nếu cần | AC3 + migration chạy local |

**Last updated:** 2026-04-11
