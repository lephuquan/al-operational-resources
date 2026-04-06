# Skill: Write Unit Test

## Goal

Unit test cho Java: JUnit 5 + Mockito, tập trung business logic, nhanh, deterministic.

## Steps

1. Chọn unit: service/domain pure logic (ưu tiên).
2. Mock dependency: `@ExtendWith(MockitoExtension.class)` hoặc `@MockBean` tùy context.
3. Đặt tên: `methodName_shouldExpectedBehavior_whenCondition`.
4. Arrange–Act–Assert; tránh test nhiều hành vi trong một test.
5. Verify tương tác khi quan trọng (`verify`); tránh over-mock.

## References

- `rules/07-testing.md`
