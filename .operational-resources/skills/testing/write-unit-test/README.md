# Write Unit Test (index)

## TL;DR (VI)

- Unit test = **JUnit 5** + **Mockito** trên **logic thuần** (service/domain/util): **không** nâng Spring context trừ khi đó là **slice test** — khi đó dùng **`write-integration-test`** hub.
- **Một hành vi / một test**; tên rõ **`should…When…`** hoặc **`method_expected_when`**; **Arrange–Act–Assert**.
- Mock **ranh giới** (repo, client, clock); tránh **over-mock** và verify vô nghĩa; dữ liệu qua **`create-test-data`** factory/builder.

## Thư mục này chứa gì

| File | Mục đích |
|------|----------|
| `SKILL.md` | Quy trình: chọn unit, mock, AAA, verify, parameterized, anti-pattern |
| `checklist.md` | Gate trước merge |
| `examples.md` | MockitoExtension, `@InjectMocks`, `assertThrows`, `@ParameterizedTest` |
| `README.md` | File này |

## Thứ tự khuyến nghị

1. Chốt **class** cần bảo vệ (thường service/domain trước controller).
2. Làm theo `SKILL.md`; xem `examples.md` khi cần snippet.
3. Chạy `checklist.md` cho module test lớn hoặc MR nhạy cảm.

## Liên kết nhanh

- `skills/testing/create-test-data/README.md`
- `skills/testing/write-integration-test/README.md`
- `skills/backend/create-service-layer/SKILL.md`
- `rules/07-testing.md`

**Last updated:** 2026-04-11
