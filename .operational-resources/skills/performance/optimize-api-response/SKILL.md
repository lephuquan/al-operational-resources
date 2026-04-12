# Skill: Optimize API Response

## Goal

Giảm payload và thời gian serial: DTO projection, tránh trả entity JPA trực tiếp, batch load.

## Steps

1. Dùng DTO/record cho response; không serialize graph lazy.
2. `@JsonInclude(NON_NULL)` nếu cần gọn payload.
3. Pagination cho list lớn.
4. Field selection: GraphQL hoặc API có `fields` param — chỉ khi team chọn.
5. Đo: Micrometer timer trên controller/service.
6. **Cache** read-heavy chỉ khi có TTL/evict rõ — `skills/performance/caching-strategy/README.md`.

## References

- `skills/performance/caching-strategy/README.md`
- `skills/observability/add-metrics/README.md`
- `skills/backend/implement-pagination-search/README.md`

**Last updated:** 2026-04-11
