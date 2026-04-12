# Examples: Caching Strategy

Minh hoạ **Spring**; chỉnh tên cache và key SpEL theo dự án.

## Key shape (distributed)

```text
app:catalog:v2:tenant:{tenantId}:product:{productId}
```

Đổi `v2` khi đổi cấu trúc value hoặc semantics.

## `@Cacheable` / `@CacheEvict` (sketch)

```java
@Cacheable(cacheNames = "products", key = "#tenantId + ':' + #productId")
public ProductDto getProduct(String tenantId, UUID productId) {
  return loadFromDb(tenantId, productId);
}

@CacheEvict(cacheNames = "products", key = "#tenantId + ':' + #productId")
public void updateProduct(String tenantId, UUID productId, ProductUpdate cmd) {
  persist(tenantId, productId, cmd);
}
```

## TTL (Redis — ý niệm config)

```yaml
spring:
  cache:
    redis:
      time-to-live: 300s
```

Hoặc TTL per-cache qua `RedisCacheManager` custom — document trong `docs/setup/`.

## Tránh

```java
// Risky: key chỉ id mà dữ liệu phụ thuộc tenant
@Cacheable(key = "#productId")  // thiếu tenant nếu DB multi-tenant
```

**Last updated:** 2026-04-11
