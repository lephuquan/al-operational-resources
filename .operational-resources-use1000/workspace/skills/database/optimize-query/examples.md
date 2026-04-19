# Examples: Query optimization

Snippet tham chiếu. Điều chỉnh entity/query theo dự án.

## 1) JOIN FETCH (JPQL)

```java
@Query("select distinct o from Order o join fetch o.lines where o.id in :ids")
List<Order> findAllWithLinesByIds(@Param("ids") Collection<Long> ids);
```

> `distinct` giúp giảm duplicate root khi collection join — vẫn cần kiểm tra với volume thật.

## 2) `@EntityGraph` (gợi ý)

```java
@EntityGraph(attributePaths = {"lines"})
@Query("select o from Order o where o.id = :id")
Optional<Order> findWithLinesById(@Param("id") Long id);
```

## 3) Batch fetch size (`application.yml`)

```yaml
spring:
  jpa:
    properties:
      hibernate:
        default_batch_fetch_size: 16
```

## 4) DTO projection (giảm cột/load)

```java
@Query("select new com.example.OrderSummary(o.id, o.reference, o.status) from Order o where o.tenantId = :t")
List<OrderSummary> summarizeByTenant(@Param("t") String tenantId);
```

## 5) EXPLAIN — PostgreSQL (chạy thủ công)

```sql
EXPLAIN (ANALYZE, BUFFERS)
SELECT * FROM orders
WHERE tenant_id = $1 AND status = 'OPEN'
ORDER BY created_at DESC
LIMIT 20;
```

## 6) Assert query count — ý tưởng test

```text
// Pseudocode: dùng statistics từ datasource-proxy hoặc Hibernate Statistics
// trong integration test — ngưỡng ví dụ: list orders không vượt N queries.
```

**Last updated:** 2026-04-09
