# Checklist: Caching Strategy

Dùng trước khi merge cache mới (Redis/Caffeine/Spring Cache).

## Justification

- [ ] Có **số liệu** hoặc profiling cho thấy path đủ nóng để cache.
- [ ] Đã ghi nhận **cửa sổ stale** chấp nhận được hoặc có **evict** đồng bộ với ghi.

## Keys & scope

- [ ] Key có **namespace + phạm vi** (tenant/user nếu cần); không gộp nhầm dữ liệu giữa tenant.
- [ ] Không key **unbounded** (raw query vô hạn) trừ khi hash + giới hạn.

## Invalidation

- [ ] Mọi mutation liên quan có **evict** hoặc **update** cache tương ứng (hoặc TTL đủ ngắn + UX chấp nhận được).
- [ ] Nhiều instance: local cache có **chiến lược** (TTL ngắn, pub/sub, hoặc chỉ dùng distributed).

## Resilience

- [ ] Có xử lý khi **Redis down** (fallback DB hoặc fail fast có kiểm soát) — đã ghi trong code/doc.

## Stampede

- [ ] Hot key có biện pháp chống **thundering herd** nếu đã xác định rủi ro.

## Security & privacy

- [ ] Không log value cache chứa PII; không expose cache key lộ cấu trúc nội bộ ra client nếu không cần.

## Observability

- [ ] Có metric hoặc log mức cao cho hit/miss hoặc latency load path.

## Test

- [ ] Test hit sau lần gọi thứ hai; test **sau update** dữ liệu không trả bản stale vô hạn (trừ khi spec cho phép đến TTL).

**Last updated:** 2026-04-11
