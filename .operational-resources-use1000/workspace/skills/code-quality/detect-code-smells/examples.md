# Examples: Báo cáo code smells

Dùng làm khung output. Thay class/method/path cho đúng dự án.

## Mẫu báo cáo ngắn (markdown)

```markdown
## Code smell scan — scope: `order` package (PR #42)

| Smell | Evidence | Severity | Suggested next step |
|-------|----------|----------|-------------------|
| Long method | `OrderServiceImpl.placeOrder` ~120 lines, 4-level nesting | P1 | Extract validation + payment + persistence into private methods with tests |
| N+1 queries | `OrderController.list` loads lines per order in loop (line ~88) | P0 | Batch fetch or join fetch / DTO projection; add integration test with query count |
| Primitive obsession | `void update(String id, boolean draft, boolean notify, boolean archive)` | P2 | Introduce `UpdateOrderCommand` record |
| Duplicate logic | Same discount calc in `QuoteService` and `OrderService` | P1 | Extract to shared domain helper + unit tests |
| Layering | `OrderController` calls `orderRepository` directly | P0 | Move to `OrderService`; keep controller thin |
```

## Gợi ý mô tả một smell (một dòng)

- **Smell:** Long method — **Where:** `com.example.order.OrderServiceImpl#placeOrder` — **Why:** >80 lines, multiple concerns — **Next:** Split into `validate()`, `charge()`, `persist()` behind existing tests.

## Anti-pattern khi báo cáo

- “Code xấu” không có vị trí file/method.
- Gộp nhiều smell khác loại thành một ý mơ hồ.
- Đề xuất rewrite lớn không có bước nhỏ hoặc không nhắc test.

**Last updated:** 2026-04-09
