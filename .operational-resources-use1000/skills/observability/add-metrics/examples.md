# Examples: Add Metrics

Giả định **Spring Boot 3 + Micrometer**. Đổi tên meter theo convention dự án.

## Inject `MeterRegistry`

```java
@Service
public class OrderService {

  private final MeterRegistry registry;

  public OrderService(MeterRegistry registry) {
    this.registry = registry;
  }
}
```

## Counter với tag hữu hạn

```java
registry.counter("app.orders.confirmed",
    "channel", "web").increment();
```

## Timer (lambda)

```java
registry.timer("app.payment.outbound", "partner", "stripe")
    .record(() -> client.capture(intentId));
```

Hoặc:

```java
Timer.Sample sample = Timer.start(registry);
try {
  // work
} finally {
  sample.stop(registry.timer("app.jobs.reconcile", "status", "done"));
}
```

## YAML — exposure (ví dụ)

```yaml
management:
  endpoints:
    web:
      exposure:
        include: health,info,metrics,prometheus
```

Chỉ bật **`prometheus`** khi scrape cần và **bảo vệ** endpoint.

## Tránh cardinality cao

```java
// Bad: unbounded tag
registry.counter("app.api.calls", "userId", userId).increment();

// Prefer
registry.counter("app.api.calls", "endpoint", "orders_create").increment();
```

**Last updated:** 2026-04-11
