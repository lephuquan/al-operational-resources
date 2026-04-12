# Create Test Data (index)

## TL;DR (VI)

- Chuẩn hóa **factory / builder / Object Mother** cho entity & DTO: **default hợp lệ**, override **từng field** trong test — tránh magic number/string không tên.
- **Cô lập**: không share **mutable state** giữa test; DB dùng **rollback** / `@Sql` / cleanup theo convention team.
- **Deterministic**: clock cố định, **UUID** hoặc **seed** faker khi cần tránh flaky; không nhét **secret thật** / **PII** production vào fixture.

## Thư mục này chứa gì

| File | Mục đích |
|------|----------|
| `SKILL.md` | Quy trình: pattern, default, isolation, DB, thời gian, an toàn |
| `checklist.md` | Gate trước merge |
| `examples.md` | Factory/builder, `@Sql`, gợi ý JSON fixture |
| `README.md` | File này |

## Thứ tự khuyến nghị

1. Chọn pattern (factory tĩnh vs builder) khớp style repo.
2. Làm theo `SKILL.md`; dùng `examples.md` khi cần snippet.
3. Chạy `checklist.md` cho module test data mới hoặc refactor lớn.

## Liên kết nhanh

- `skills/testing/write-unit-test/SKILL.md`
- `skills/testing/write-integration-test/README.md`
- `skills/backend/create-jpa-entity/SKILL.md`
- `skills/backend/create-rest-api/README.md`
- `rules/07-testing.md`

**Last updated:** 2026-04-11
