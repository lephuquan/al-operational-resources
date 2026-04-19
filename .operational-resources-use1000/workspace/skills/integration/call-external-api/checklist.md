# Checklist: Call External API

Dùng trước khi merge client HTTP outbound mới hoặc đổi config resilience.

## Config & secrets

- [ ] **Base URL** và flag từ properties/env — không URL prod cứng trong code.
- [ ] Secret chỉ qua env/vault; không log token/header nhạy cảm.

## Runtime safety

- [ ] **Timeout** connect + read/response đã set (không chờ vô hạn).
- [ ] Giới hạn **kích thước body** in-memory (tránh OOM).

## Architecture

- [ ] Controller/domain **không** gọi `WebClient` trực tiếp; có **port** + adapter (hoặc tương đương team chốt).
- [ ] Transaction: không giữ transaction DB mở suốt remote call dài (xem `08-transactions-and-consistency.md`).

## Errors & resilience

- [ ] 4xx/5xx/timeout map về exception/result thống nhất; không lộ message thô provider cho end user.
- [ ] **Retry** chỉ khi **idempotent** (hoặc có idempotency key) và có cap backoff.
- [ ] Circuit breaker (nếu bật) có metric/log để vận hành.

## Observability

- [ ] Có **correlation / trace** trên log hoặc header outbound (theo convention team).
- [ ] Metric latency/error (nếu stack bật Micrometer cho outbound).

## Test

- [ ] Unit test service với mock port.
- [ ] Ít nhất một test WireMock (hoặc tương đương) cho success + một nhánh lỗi (4xx/5xx hoặc timeout).

## Docs

- [ ] `docs/architecture/07-integrations.md` cập nhật auth, idempotency, failure mode tóm tắt.

**Last updated:** 2026-04-11
