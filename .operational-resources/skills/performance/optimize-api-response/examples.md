# Examples: Optimize API Response

## DTO record + non-null

```java
@JsonInclude(JsonInclude.Include.NON_NULL)
public record OrderSummaryDto(
    UUID id,
    String status,
    Instant createdAt
) {}
```

## Controller trả DTO (sketch)

```java
@GetMapping("/{id}")
public OrderSummaryDto get(@PathVariable UUID id) {
  return orderService.getSummary(id);
}
```

## Spring Data projection (interface)

```java
public interface OrderIdAndStatus {
  UUID getId();
  String getStatus();
}

List<OrderIdAndStatus> findByCustomerId(UUID customerId, Pageable pageable);
```

Tránh trả `Order` entity nếu chỉ cần hai cột.

## Pagination

Dùng `Page<OrderSummaryDto>` hoặc envelope theo `docs/api/07-pagination-filtering.md` + skill `implement-pagination-search`.

**Last updated:** 2026-04-11
