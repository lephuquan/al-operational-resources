# Skill: Write Unit Test

## TL;DR (VI)

- Ưu tiên test **domain/service** và **pure function**; **không** `@SpringBootTest` cho logic có thể cô lập bằng **constructor injection** + mock.
- **`@ExtendWith(MockitoExtension.class)`** + **`@Mock`** / **`@Spy`** + **`@InjectMocks`** (hoặc manual `new` + mocks) — **`@MockBean`** chỉ trong **slice** Spring (xem hub integration).
- **AAA** rõ ràng; **một assert chính** (có thể thêm vài `assertThat` liên quan cùng hành vi); **`verify`** khi **tương tác** là một phần contract.
- Tránh test **implementation details** (private method, số lần gọi nội bộ không quan trọng) trừ khi đó là **invariant** rõ ràng.

## Goal

Write **fast, deterministic** unit tests for Java code (JUnit 5 + Mockito) that protect **business behavior** without relying on a full application context.

## Preconditions

- Dependencies are **injectable** (constructor injection preferred) or can be refactored to be testable.
- `rules/07-testing.md` naming and coverage expectations understood.

## Steps

1. **Pick the unit under test**
   - Prefer **services**, **domain policies**, and **pure utilities**.
   - Avoid “unit” tests that require **`ApplicationContext`** — those belong in **`skills/testing/write-integration-test/README.md`**.

2. **Choose instantiation style**
   - **`@InjectMocks`** with **`@Mock`** dependencies when using MockitoExtension.
   - Or **`new Service(mockRepo, mockClock)`** for explicit clarity — especially when the constructor has logic.

3. **Stub behavior, not everything**
   - Use **`when(mock.method()).thenReturn(...)`** / **`thenThrow`** for collaborators.
   - Use **lenient** stubs only when necessary to reduce noise; default strict stubbing is usually better.

4. **Structure: Arrange–Act–Assert**
   - One **clear** action (`act`) per test; avoid multiple unrelated actions in a single `@Test`.

5. **Naming**
   - Use team convention: e.g. **`shouldRejectOrderWhenOutOfStock`** or **`createOrder_failsWhenProductInactive`**.
   - Test name should read as **specification**, not as method name only.

6. **Assertions**
   - Prefer **AssertJ** (`assertThat`) if the project uses it; otherwise JUnit assertions.
   - For exceptions, use **`assertThrows`** and assert **message/type** as needed.

7. **Verification**
   - **`verify(mock).method(...)`** when the **side effect** or **call** is part of the contract (e.g. must publish event).
   - Avoid **`verify`** on every dependency on every test — that couples tests to implementation.

8. **Time and randomness**
   - Inject **`Clock`**, **`Supplier<UUID>`**, or wrap **`Random`** so tests use **fixed** values.

9. **Parameterized tests**
   - Use **`@ParameterizedTest`** + **`@CsvSource` / `@MethodSource`** for tables of inputs and expected outcomes.

10. **Test data**
   - Use **`skills/testing/create-test-data/README.md`** builders/factories instead of raw literals repeated everywhere.

11. **Anti-patterns to flag**
   - Tests that mirror production code line-by-line (no real assertions).
   - **Static** singletons that cannot be replaced — refactor seam or use integration test sparingly.

12. **Verify locally**
   - Run the **smallest** test scope (`-Dtest=…`) then module / full `mvn test` per team habit.

## Output

- New or updated `@Test` methods, small test helpers, and optional test doubles — with names that document behavior.

## References

- `skills/testing/write-unit-test/README.md`
- `skills/testing/write-unit-test/checklist.md`
- `rules/07-testing.md`
- `skills/testing/create-test-data/README.md`
- `skills/testing/write-integration-test/README.md`
- `skills/backend/create-service-layer/SKILL.md`
- `skills/code-quality/refactor-clean-code/README.md`

**Last updated:** 2026-04-11
