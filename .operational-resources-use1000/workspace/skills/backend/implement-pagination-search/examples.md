# Examples: Pagination & search

Snippet baseline. Điều chỉnh path, field, envelope theo dự án.

## 1) Controller — `Pageable`

```java
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@GetMapping
public ResponseEntity<ApiResponse<Page<OrderSummaryResponse>>> list(
        Pageable pageable,
        @RequestParam(required = false) String q) {
    Page<OrderSummaryResponse> page = orderQueryService.search(q, pageable);
    return ResponseEntity.ok(ApiResponse.ok(page));
}
```

## 2) Giới hạn `size` (gợi ý trong service)

```java
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;

private static final int MAX_SIZE = 100;

public Page<OrderSummaryResponse> search(String q, Pageable pageable) {
    int size = Math.min(pageable.getPageSize(), MAX_SIZE);
    Pageable safe = PageRequest.of(pageable.getPageNumber(), size, pageable.getSort());
    // ...
    return orderRepository.findAll(buildSpec(q), safe).map(mapper::toSummary);
}
```

## 3) `Specification` động (JPA)

```java
import java.util.Locale;
import org.springframework.data.jpa.domain.Specification;

public static Specification<Order> keywordSpec(String raw) {
    String q = raw == null ? "" : raw.trim();
    if (q.isEmpty()) {
        return (root, query, cb) -> cb.conjunction();
    }
    String pattern = "%" + q.toLowerCase(Locale.ROOT) + "%";
    return (root, query, cb) -> cb.like(cb.lower(root.get("reference")), pattern);
}
```

> Với LIKE từ user: nên escape `%` và `_` hoặc dùng `escape` clause; ví dụ trên chỉ minh họa.

## 4) Repository

```java
public interface OrderRepository extends JpaRepository<Order, Long>, JpaSpecificationExecutor<Order> {
}
```

## 5) Meta từ `Page` (ý tưởng map sang DTO contract)

```java
// Spring Page already exposes: totalElements, totalPages, number, size, ...
// Wrap trong ApiResponse + data.items + data.meta tùy docs/api/
```

## Lưu ý

- Với Springdoc/OpenAPI, có thể annotate `Pageable` bằng `@ParameterObject` để bung `page`, `size`, `sort` trên UI — tùy dependency dự án.
- `JOIN FETCH` + `Page` có thể gây duplicate hoặc count sai — kiểm tra kỹ hoặc dùng `@EntityGraph` / query tách.
- Full-text search nâng cao: cân nhắc PostgreSQL `tsvector`, OpenSearch, v.v. — không ép vào LIKE nếu data lớn.

**Last updated:** 2026-04-09
