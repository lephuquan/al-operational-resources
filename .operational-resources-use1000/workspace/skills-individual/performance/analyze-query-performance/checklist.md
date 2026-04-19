# Checklist: Analyze Query Performance

Dùng trước khi chốt RCA “DB chậm” hoặc trước khi mở MR index lớn.

## Capture

- [ ] Đã có **câu SQL** (hoặc fingerprint) và **tham số** / use case tái hiện — không chỉ “API chậm” mơ hồ.
- [ ] Dữ liệu reproduce có **quy mô** gần prod (hoặc giải thích rõ vì sao plan vẫn đại diện).

## Evidence

- [ ] Đã chạy **`EXPLAIN (ANALYZE)`** (hoặc tương đương) và lưu **execution time** + điểm đáng ngờ trên plan.
- [ ] So sánh **estimated vs actual rows** khi nghi ngờ stats.

## Safety

- [ ] Không dán **PII/secret** vào ticket; query mẫu đã **sanitize**.

## Next step

- [ ] Đã chỉ rõ nhánh xử lý: **optimize-query** (ORM/fetch), **migration** (index/DDL), hoặc **DBA** (stats, partition, …).

## After fix

- [ ] Có **EXPLAIN after** hoặc metric latency/query count để đối chiếu.

**Last updated:** 2026-04-11
