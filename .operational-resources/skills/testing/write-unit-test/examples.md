# Examples: Write Unit Test

## Mockito + JUnit 5

```java
@ExtendWith(MockitoExtension.class)
class OrderServiceTest {

  @Mock OrderRepository orders;
  @Mock StockClient stock;
  @InjectMocks OrderService underTest;

  @Test
  void shouldRejectWhenOutOfStock() {
    var req = new CreateOrderRequest(UUID.randomUUID(), 2);
    when(stock.available(req.productId())).thenReturn(0);

    assertThatThrownBy(() -> underTest.create(req))
        .isInstanceOf(OutOfStockException.class);

    verify(orders, never()).save(any());
  }
}
```

## `assertThrows`

```java
@Test
void create_failsWhenQuantityNonPositive() {
  var req = new CreateOrderRequest(UUID.randomUUID(), 0);

  assertThrows(IllegalArgumentException.class, () -> underTest.create(req));
}
```

## `@ParameterizedTest`

```java
@ParameterizedTest
@CsvSource({"0,false", "1,true", "100,true"})
void activeWhenMinQuantity(int qty, boolean expected) {
  assertThat(underTest.isBulk(qty)).isEqualTo(expected);
}
```

## Instantiation tường minh (không `@InjectMocks`)

```java
@Test
void usesExplicitConstructor() {
  var clock = Clock.fixed(Instant.parse("2026-01-01T00:00:00Z"), ZoneOffset.UTC);
  var svc = new OrderService(mockRepo, clock);
  // ...
}
```

**Last updated:** 2026-04-11
