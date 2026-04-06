# Skill: Caching Strategy

## Goal

Cache đúng chỗ: TTL, invalidation, stampede, cache-aside.

## Steps

1. Xác định read-heavy key; đo trước khi cache.
2. Spring Cache (`@Cacheable`) hoặc Redis; key namespace rõ ràng.
3. TTL + invalidation khi update entity.
4. Tránh cache user-specific data không có scope.
5. Document trong ADR nếu thay đổi hành vi consistency.
