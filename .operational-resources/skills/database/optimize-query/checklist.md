# Checklist: Optimize query

Dùng trước khi merge thay đổi hiệu năng. Bỏ qua mục không áp dụng.

## Đo lường

- [ ] Đã tái hiện slow path (dev/staging hoặc test có volume đủ)
- [ ] Có số liệu before (query count, latency, hoặc EXPLAIN) — không chỉ “cảm giác nhanh hơn”

## N+1 & fetch

- [ ] Không còn lazy load trong loop không kiểm soát
- [ ] Nếu dùng `JOIN FETCH` + pagination: đã kiểm tra duplicate/count

## Index & plan

- [ ] Index mới có lý do gắn với predicate/sort thực tế
- [ ] Đã xem EXPLAIN (hoặc tương đương) cho query chính sau thay đổi
- [ ] Migration/index đi qua `create-migration` khi cần

## Đúng hành vi

- [ ] Kết quả nghiệp vụ không đổi (hoặc thay đổi đã được chốt)
- [ ] Test bao phủ path tối ưu (ít nhất integration hoặc test đếm query)

## Cache (nếu có)

- [ ] Có TTL hoặc cơ chế invalidate; không cache dữ liệu nhạy cảm sai policy

**Last updated:** 2026-04-09
