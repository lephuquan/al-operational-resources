# Skill: Write Integration Test

## Goal

Integration test với Spring Boot: context thật (hoặc slice), DB testcontainer/H2 theo team.

## Steps

1. Chọn scope: `@SpringBootTest` (nặng) vs `@DataJpaTest` vs `@WebMvcTest`.
2. Dùng `@Testcontainers` + PostgreSQL nếu cần parity với prod.
3. `@Transactional` + rollback sau test (hoặc `@Sql` cleanup) theo convention.
4. Test API: `MockMvc` hoặc `TestRestTemplate`.
5. Tránh flaky: fixed clock, không phụ thuộc thời gian thực nếu không cần.
