# Examples: JPA Entity

Không chứa secret. Điều chỉnh package, tên bảng, strategy ID theo dự án.

## Ví dụ 1 — Entity + timestamps

```java
@Entity
@Table(name = "orders")
@Getter
@Setter
public class Order {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 32)
    private String status;

    @Column(name = "created_at", nullable = false)
    private Instant createdAt;

    @Column(name = "updated_at", nullable = false)
    private Instant updatedAt;

    @PrePersist
    void onCreate() {
        Instant now = Instant.now();
        createdAt = now;
        updatedAt = now;
    }

    @PreUpdate
    void onUpdate() {
        updatedAt = Instant.now();
    }
}
```

## Ví dụ 2 — OneToMany + lazy (aggregate)

```java
@Entity
@Table(name = "orders")
@Getter
@Setter
public class Order {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    private List<OrderLine> lines = new ArrayList<>();

    public void addLine(OrderLine line) {
        lines.add(line);
        line.setOrder(this);
    }
}

@Entity
@Table(name = "order_lines")
@Getter
@Setter
public class OrderLine {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "order_id", nullable = false)
    private Order order;
}
```

## Ví dụ 3 — Repository

```java
public interface OrderRepository extends JpaRepository<Order, Long> {

    Optional<Order> findByIdAndDeletedAtIsNull(Long id);

    List<Order> findByStatusAndDeletedAtIsNull(String status);
}
```

## Ví dụ 4 — Flyway migration (PostgreSQL, gợi ý)

```sql
CREATE TABLE orders (
    id BIGSERIAL PRIMARY KEY,
    status VARCHAR(32) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL,
    updated_at TIMESTAMPTZ NOT NULL
);

CREATE TABLE order_lines (
    id BIGSERIAL PRIMARY KEY,
    order_id BIGINT NOT NULL REFERENCES orders(id),
    product_id VARCHAR(64) NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0)
);

CREATE INDEX idx_order_lines_order_id ON order_lines(order_id);
```

## Lưu ý nhanh

- Tránh gọi `order.getLines()` trong `toString()` / `equals` nếu đang lazy và ngoài transaction.
- Nếu team dùng **Lombok `@Data`** trên entity: cân nhắc `@EqualsAndHashCode(onlyExplicitlyIncluded = true)` + `@ToString(exclude = "lines")` hoặc không dùng `@Data` cho entity có quan hệ.

**Last updated:** 2026-04-09
