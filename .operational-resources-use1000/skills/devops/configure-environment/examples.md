# Examples: Environment configuration

Chỉ dùng giá trị giả / placeholder. Không commit secret thật.

## `application.yml` (default)

```yaml
spring:
  application:
    name: order-api

app:
  payment:
    base-url: ${APP_PAYMENT_BASE_URL:http://localhost:9090}
    api-key: ${APP_PAYMENT_API_KEY:}   # required in prod — validated at startup
```

## `application-dev.yml`

```yaml
logging:
  level:
    com.example: DEBUG

app:
  features:
    mock-payment: true
```

## `application-prod.yml`

```yaml
app:
  features:
    mock-payment: false
```

## `@ConfigurationProperties` (gợi ý)

```java
@ConfigurationProperties(prefix = "app.payment")
@Validated
public record PaymentClientProperties(
        @NotBlank String baseUrl,
        @NotBlank String apiKey
) {}
```

## `.env.example` (local)

```bash
# Copy to .env and fill — never commit .env
APP_PAYMENT_BASE_URL=https://payment.example.com
APP_PAYMENT_API_KEY=
SPRING_PROFILES_ACTIVE=dev,local
```

## Ghi chú MR (mẫu)

```markdown
## Config
- Added `app.payment.*` with env vars `APP_PAYMENT_BASE_URL`, `APP_PAYMENT_API_KEY` (documented in `docs/setup/02-local-development.md`).
- `application-local.yml` remains gitignored; see `application-local.yml.example`.
```

**Last updated:** 2026-04-09
