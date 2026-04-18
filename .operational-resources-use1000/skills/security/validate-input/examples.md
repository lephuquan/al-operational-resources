# Examples: Validate Input

## Request DTO

```java
public record CreateOrderRequest(
    @NotNull UUID productId,
    @Min(1) @Max(99) int quantity,
    @Size(max = 500) String note
) {}
```

## Controller

```java
@PostMapping("/api/v1/orders")
public OrderResponse create(@Valid @RequestBody CreateOrderRequest body) {
  return orderService.create(body);
}
```

## `@Validated` trên tham số đơn

```java
@RestController
@Validated
public class OrderController {

  @GetMapping("/api/v1/orders/{id}")
  public OrderResponse get(@PathVariable @NotNull UUID id) {
    return orderService.get(id);
  }
}
```

## Custom constraint (khung minh họa)

```java
@Target({FIELD, TYPE_USE})
@Retention(RUNTIME)
@Constraint(validatedBy = OrderDatesValidator.class)
public @interface ValidOrderDates {
  String message() default "end must be after start";
  Class<?>[] groups() default {};
  Class<? extends Payload>[] payload() default {};
}
```

Logic kiểm tra đặt trong `OrderDatesValidator implements ConstraintValidator<...>`; kiểm tra cần DB nên làm ở **service** và ném exception domain thay vì nhồi query vào validator.

## Gợi ý test (MockMvc)

Gửi body thiếu field bắt buộc hoặc vi phạm `@Size` / `@Min` → kỳ vọng **400** và body lỗi đúng contract dự án.

**Last updated:** 2026-04-11
