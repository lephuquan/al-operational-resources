# Examples: Health Check Endpoint

Snippet **không chứa secret**. Property names theo **Spring Boot 3.x** (tương thích tư tưởng 2.3+).

## `application.yml` — prod-oriented

```yaml
management:
  endpoints:
    web:
      exposure:
        include: health,info
  endpoint:
    health:
      show-details: never
      probes:
        enabled: true
```

## `application.yml` — dev (chi tiết khi cần)

```yaml
management:
  endpoints:
    web:
      exposure:
        include: health,info
  endpoint:
    health:
      show-details: when_authorized
      probes:
        enabled: true
```

## Spring Security 6 — permit health probes (MVC)

Chỉ ví dụ: đặt **trước** rule `anyRequest` tương đương; chỉnh cho đúng cấu hình project.

```java
http.authorizeHttpRequests(auth -> auth
    .requestMatchers("/actuator/health", "/actuator/health/**").permitAll()
    .anyRequest().authenticated()
);
```

Nếu management server **tách port** (`management.server.port`), có thể không cần permit trên port app chính — vẫn phải kiểm chứng thực tế.

## Kubernetes probes

```yaml
livenessProbe:
  httpGet:
    path: /actuator/health/liveness
    port: 8080
  initialDelaySeconds: 30
  periodSeconds: 10
readinessProbe:
  httpGet:
    path: /actuator/health/readiness
    port: 8080
  initialDelaySeconds: 10
  periodSeconds: 5
```

Đổi `port` nếu dùng **`management.server.port`** riêng (khi đó probe phải trỏ đúng cổng management).

## Custom `HealthIndicator` (blocking, đơn giản)

```java
@Component
public class ExternalServiceHealthIndicator implements HealthIndicator {

    @Override
    public Health health() {
        try {
            boolean ok = pingExternalService(); // implement: timeout ngắn
            return ok ? Health.up().build()
                      : Health.down().withDetail("reason", "unavailable").build();
        } catch (Exception ex) {
            return Health.down().withDetail("reason", "error").build();
        }
    }

    private boolean pingExternalService() {
        return true; // thay bằng gọi thật có giới hạn thời gian
    }
}
```

Tránh `withDetail("error", ex.getMessage())` nếu message có thể lộ nội bộ.

## Quick local checks

```bash
curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/actuator/health
curl -s http://localhost:8080/actuator/health/readiness
```

**Last updated:** 2026-04-11
