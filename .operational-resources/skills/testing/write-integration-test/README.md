# Write Integration Test (index)

## TL;DR (VI)

- Chọn **slice** đúng: **`@WebMvcTest`** / **`@DataJpaTest`** khi đủ; **`@SpringBootTest`** khi cần **full context** — tránh context nặng không cần thiết.
- DB: **Testcontainers** (PostgreSQL, …) khi cần **parity** prod; **H2** chỉ khi team chấp nhận khác biệt dialect.
- **Cô lập dữ liệu**: `@Transactional` + rollback, **`@Sql`**, hoặc cleanup rõ ràng; fixture dùng **`create-test-data`** hub.
- Tránh **flaky**: **clock** cố định, **random** có seed, không phụ thuộc thời gian thực / mạng ngoài trừ khi có **WireMock** / stub.

## Thư mục này chứa gì

| File | Mục đích |
|------|----------|
| `SKILL.md` | Quy trình: slice, DB, HTTP, security, async, độ tin cậy |
| `checklist.md` | Gate trước merge |
| `examples.md` | `@SpringBootTest`, `@DataJpaTest`, MockMvc, Testcontainers |
| `README.md` | File này |

## Thứ tự khuyến nghị

1. Chốt **phạm vi** cần chứng minh (API contract, persistence, slice nào).
2. Làm theo `SKILL.md`; copy từ `examples.md` khi cần.
3. Chạy `checklist.md` trước MR.

## Liên kết nhanh

- `skills/testing/create-test-data/README.md`
- `skills/testing/write-unit-test/SKILL.md`
- `skills/backend/create-rest-api/README.md`
- `skills/error-handling/global-exception-handler/README.md`
- `skills/security/secure-api-endpoint/README.md`
- `rules/07-testing.md`

**Last updated:** 2026-04-11
