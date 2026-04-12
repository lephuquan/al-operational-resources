# Checklist: Implement Request Tracing

Dùng trước khi merge cấu hình tracing, filter, hoặc thay bridge OTel/Brave.

## Contract

- [ ] Định dạng propagate (**W3C** / **B3**) khớp **gateway** và tài liệu nội bộ.

## Inbound & logs

- [ ] Request vào tạo/join span; **MDC** có key **traceId** (và span nếu cần) khớp **pattern Logback**.
- [ ] Không dựa trace header cho **authz**.

## Outbound

- [ ] `WebClient` / client chính **inject** header trace tới downstream (đã kiểm chứng bằng test hoặc capture).

## Async / pool

- [ ] Thread pool async (**@Async**, executor tùy chỉnh) **không** mất context; không rò MDC giữa request.

## Messaging (nếu có)

- [ ] Producer/consumer map trace vào **headers** message theo convention.

## Ops

- [ ] Có chỗ xem trace (UI) và cách lọc log theo **traceId** cho on-call.

## Security

- [ ] Không log field nhạy cảm trong `tracestate` / custom baggage.

**Last updated:** 2026-04-11
