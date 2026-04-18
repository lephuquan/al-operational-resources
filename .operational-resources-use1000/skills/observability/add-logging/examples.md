# Examples: Add Logging

## Logger field

```java
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class OrderService {
  private static final Logger log = LoggerFactory.getLogger(OrderService.class);
}
```

## Parameterized logging

```java
log.info("orderId={} action=confirm status={}", orderId, status);
log.warn("partnerTimeout partner={} orderId={}", "acme", orderId);
log.error("paymentCaptureFailed orderId={}", orderId, exception);
```

## Expensive debug guard

```java
if (log.isDebugEnabled()) {
  log.debug("details={}", expensiveSummary());
}
```

## MDC — local scope (phải clear)

```java
MDC.put("jobId", jobId);
try {
  log.info("batchStart");
  // ...
} finally {
  MDC.remove("jobId");
}
```

Hoặc `MDC.clear()` nếu thread dedicated cho job và không giữ context khác.

## Tránh

```java
// Bad: eager string build + possible PII in user
log.info("User " + user + " updated");

// Prefer
log.info("userId={} action=profileUpdate", user.getId());
```

**Last updated:** 2026-04-11
