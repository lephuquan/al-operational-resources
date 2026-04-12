# Skill: Write Integration Test

## TL;DR (VI)

- **Ưu tiên slice** nhẹ nhất đủ bằng chứng: **`@WebMvcTest`** (controller + MVC), **`@DataJpaTest`** (JPA + SQL), **`@JdbcTest`** khi chỉ JDBC — **`@SpringBootTest`** khi cần nhiều bean thật cùng lúc.
- **DB test**: Testcontainers bản prod-like; cấu hình qua **`@DynamicPropertySource`** / `application-test.yml`; migration (**Flyway/Liquibase**) chạy như runtime nếu team bật.
- **HTTP**: **`MockMvc`** (in-process) hoặc **`TestRestTemplate`** / **`WebTestClient`** (full server tùy `webEnvironment`).
- **Bảo mật**: dùng **`@WithMockUser`** / **`SecurityMockMvcRequestPostProcessors`** hoặc JWT test helper — khớp **`secure-api-endpoint`**.
- **Độ tin cậy**: không share trạng thái mutable; mock **clock**; stub HTTP ngoài bằng **WireMock** khi cần.

## Goal

Write **Spring Boot integration tests** that prove **real wiring** (HTTP, persistence, security, messaging slices) while staying **fast enough**, **deterministic**, and **easy to maintain**.

## Preconditions

- `rules/07-testing.md` and team defaults (Testcontainers vs H2, profile names).
- Feature boundaries known: which layers must be exercised together.

## Steps

1. **Choose test type**
   - **Controller + mapping + validation + security**: `@WebMvcTest` + `@MockBean` for services, or slice that includes `SecurityFilterChain` as needed.
   - **Repositories / entities / queries**: `@DataJpaTest` (+ `@AutoConfigureTestDatabase` policy per team).
   - **End-to-end within JVM**: `@SpringBootTest` with narrowed `classes = …` or `properties = …` when possible.

2. **Database strategy**
   - Prefer **Testcontainers** for PostgreSQL/MySQL parity; register datasource URL via **`@DynamicPropertySource`** or Testcontainers JUnit 5 extension.
   - If using **H2**, document limitations (dialect, types) and avoid prod-only SQL features in tests.

3. **Schema and migrations**
   - Align with **`skills/database/create-migration/README.md`**: tests should apply the same migration path as the app, or use a dedicated test schema strategy the team owns.

4. **Test isolation**
   - Use **`@Transactional`** + rollback on test methods when services do not **commit** internally; if tests require committed data visible to other connections, use **`@Sql`** or explicit cleanup instead.
   - Build data with **`skills/testing/create-test-data/README.md`** factories or minimal `@Sql` scripts.

5. **HTTP testing**
   - **`MockMvc`**: `perform(post(...).contentType(...).content(json))` and assert status + JSON body.
   - **`TestRestTemplate`** / **`WebTestClient`**: use `RANDOM_PORT` or `DEFINED_PORT` when testing the full servlet stack or filters that behave differently in mock mode.

6. **Security**
   - For secured endpoints, add mock authentication or import a **test security** configuration that relaxes rules — **do not** disable security globally in production code.
   - Match expected **401/403** with **`skills/error-handling/global-exception-handler/README.md`** behavior.

7. **External systems**
   - Stub outbound HTTP with **WireMock** or test doubles registered as **`@MockBean`** / **`@Primary`** in a **`@TestConfiguration`** profile.

8. **Time and async**
   - Replace **`Clock`** with fixed instant in tests; for **`@Async`** or reactive flows, await completion with **`Awaitility`** or **`StepVerifier`** per stack.

9. **Profiles and properties**
   - Use **`@ActiveProfiles("test")`** and `src/test/resources/application-test.yml` for toggles (logging, feature flags, fake URLs).

10. **Assertions**
   - Prefer stable assertions: JSON path, response DTO parsing, or repository **`count()`** — avoid brittle full-string snapshots unless the team standardizes them.

11. **Performance and CI**
   - Keep **context starts** low: reuse context with **`@DirtiesContext`** only when necessary; split heavy suites if CI time explodes.

12. **Verify**
   - Run `mvn test` / Gradle equivalent; ensure tests pass **alone** and in **full suite** order.

## Output

- Integration test class(es), optional test `application-test.yml`, Testcontainers setup, and notes in PR if new conventions were introduced.

## References

- `skills/testing/write-integration-test/README.md`
- `skills/testing/write-integration-test/checklist.md`
- `rules/07-testing.md`
- `skills/testing/create-test-data/README.md`
- `skills/testing/write-unit-test/SKILL.md`
- `skills/backend/create-rest-api/README.md`
- `skills/database/create-migration/README.md`
- `skills/error-handling/global-exception-handler/README.md`
- `skills/security/secure-api-endpoint/README.md`
- `skills/integration/call-external-api/README.md` (WireMock, timeouts)

**Last updated:** 2026-04-11
