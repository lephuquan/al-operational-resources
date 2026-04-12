# Examples: Create Test Data

## Factory tĩnh (Java)

```java
public final class OrderFactory {

  private OrderFactory() {}

  public static Order pending(UUID userId) {
    return Order.builder()
        .id(UUID.randomUUID())
        .userId(userId)
        .status(OrderStatus.PENDING)
        .createdAt(Instant.parse("2026-01-01T00:00:00Z"))
        .build();
  }
}
```

Test chỉ override phần cần: `var order = OrderFactory.pending(USER_A);` rồi `order.cancel()` hoặc dùng `toBuilder()` nếu entity hỗ trợ.

## Builder fluent (tùy chọn)

```java
public class UserBuilder {
  private String email = "user@example.test";
  private Role role = Role.USER;

  public UserBuilder email(String email) {
    this.email = email;
    return this;
  }

  public UserBuilder role(Role role) {
    this.role = role;
    return this;
  }

  public User build() {
    return new User(UUID.randomUUID(), email, role);
  }
}
```

## `@Sql` seed nhỏ

```java
@SpringBootTest
@Sql("/testdata/orders/one_pending_order.sql")
class OrderServiceIT { /* ... */ }
```

Giữ file SQL **tối thiểu** và versioned cùng schema.

## JSON request (MockMvc)

`src/test/resources/payloads/create-order.json` — load bằng `MockMvc` `content(resource)` hoặc `Files.readString` trong helper; chỉnh field ít khi cần bản hơi khác (copy-once pattern).

**Last updated:** 2026-04-11
