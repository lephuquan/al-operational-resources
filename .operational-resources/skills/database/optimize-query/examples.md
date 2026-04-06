# Examples: Query Optimization

```java
@Query("select o from Order o join fetch o.lines where o.id = :id")
Optional<Order> findWithLinesById(@Param("id") Long id);
```

Batch size (ví dụ `application.yml`):

```yaml
spring:
  jpa:
    properties:
      hibernate:
        default_batch_fetch_size: 16
```
