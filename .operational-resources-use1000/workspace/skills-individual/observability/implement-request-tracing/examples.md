# Examples: Implement Request Tracing

Tuỳ phiên bản Spring Boot và bridge (**Brave** vs **OTel**). Xem tài liệu chính thức khi copy-paste.

## `application.yml` (gợi ý)

```yaml
management:
  tracing:
    sampling:
      probability: 1.0   # dev; prod: giảm hoặc dùng remote sampler
  observations:
    http:
      client:
        enabled: true
      server:
        enabled: true
```

## Logback pattern (snippet)

```xml
<pattern>%d{ISO8601} [%thread] %-5level %logger{36} traceId=%X{traceId} spanId=%X{spanId} - %msg%n</pattern>
```

Tên key MDC có thể là `traceId` / `spanId` (Brave) — đối chiếu doc **`micrometer-tracing`**.

## `WebClient` + quan sát (ý niệm)

Đăng ký builder với **`ObservationRegistry`** (Spring Boot 3 thường inject sẵn):

```java
@Bean
WebClient webClient(WebClient.Builder builder, ObservationRegistry registry) {
  return builder.observationRegistry(registry).build();
}
```

## Kiểm tra nhanh

1. Gọi một API qua gateway có gửi `traceparent`.
2. Xem log hai service: cùng **traceId**.
3. Xem UI trace (nếu exporter bật): một trace nối các span.

**Last updated:** 2026-04-11
