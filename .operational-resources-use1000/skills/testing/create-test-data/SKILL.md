# Skill: Create Test Data

## TL;DR (VI)

- Tạo **test data** qua **factory** hoặc **builder** có **default hợp lệ**; mỗi test chỉ override field liên quan **hành vi đang kiểm tra**.
- Tách **builders** theo bounded context (order, user, payment) thay vì một “god” fixture cho cả repo — trừ khi team cố ý centralize.
- Integration: **tối thiểu seed**, **rollback** hoặc **@Sql** cleanup; tránh phụ thuộc thứ tự test không tên.
- Không đưa **credential thật** vào `src/test`; dữ liệu “giống prod” chỉ dùng **đã khử nhạy cảm** hoặc synthetic.

## Goal

Produce **clear, reusable, isolated** test data for unit and integration tests so suites stay **readable**, **fast**, and **deterministic**.

## Preconditions

- Conventions for test packages (`src/test/java/...`) and DB tests (`@DataJpaTest`, `@SpringBootTest`, Testcontainers) agreed per `rules/07-testing.md`.
- Entities/DTOs exist or are being introduced alongside tests.

## Steps

1. **Pick a pattern**
   - **Static factory** methods: `OrderFactory.pending()` for common cases.
   - **Fluent builder**: `OrderBuilder.withProduct(id).quantity(3).build()` when many optional fields exist.
   - **Object Mother** class per aggregate: `OrderMother.readyToShip()` — use when the team already uses this name.

2. **Sensible defaults**
   - Every factory method returns an object that satisfies **invariants** (non-null ids where required, positive amounts, valid enums).
   - Name defaults after **business meaning** (`validUser()`, `expiredToken()`), not `user1()` unless that is the convention.

3. **Override only what matters**
   - In each test, change the **minimum** set of fields that drive the assertion; avoid copying large object literals.

4. **Immutability and sharing**
   - Prefer **new instances** per test. If you reuse a “template” object, **copy** or rebuild — do not mutate a shared static instance between tests.

5. **Identifiers and relationships**
   - Use **fixed UUIDs** or sequences when tests assert equality or snapshots.
   - For FK graphs, provide small helpers that wire **parent → child** consistently (e.g. `UserFactory` + `OrderFactory.forUser(user)`).

6. **Database-backed tests**
   - Prefer **`@Transactional`** rollback on integration tests when the team allows it, or explicit **`@Sql`** / `@AfterEach` cleanup.
   - Keep seed **minimal**: only rows required for the scenario under test.
   - Align with migration schema — use **`skills/database/create-migration/README.md`** when schema changes break fixtures.

7. **HTTP / JSON fixtures**
   - For `MockMvc` / WebTestClient, store **request JSON** under `src/test/resources/...` when payloads are large; keep small bodies inline for readability.

8. **Time and randomness**
   - Inject **`Clock`** or use **fixed** `Instant` / `LocalDate` in tests; avoid `now()`-dependent assertions unless you control time.
   - If using **Random** or datafaker, set a **fixed seed** when flakiness appears.

9. **Security and compliance**
   - Do not commit **real** emails, phone numbers, or **production-like** secrets. Use obvious fakes (`user@example.test`, `test-api-key` in test-only stubs).

10. **Discoverability**
   - Place factories next to the module they belong to (`order/testdata/OrderFactory`) or in a shared `testdata` package — **one** convention per repo.

11. **Verify**
   - Run affected tests; ensure no **order-dependent** failures when the suite runs alone vs full build.

## Output

- Factory/builder (or JSON fixture) types, optional `@Sql` scripts, and documentation in PR if introducing a new test-data convention.

## References

- `skills/testing/create-test-data/README.md`
- `skills/testing/create-test-data/checklist.md`
- `rules/07-testing.md`
- `skills/testing/write-unit-test/README.md`
- `skills/testing/write-integration-test/README.md`
- `skills/backend/create-jpa-entity/SKILL.md`
- `skills/backend/create-rest-api/README.md`
- `skills/database/create-migration/README.md`

**Last updated:** 2026-04-11
