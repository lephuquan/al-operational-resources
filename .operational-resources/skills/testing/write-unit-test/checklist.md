# Checklist: Write Unit Test

Dùng trước merge khi thêm **nhiều unit test** hoặc refactor suite.

## Scope

- [ ] Test thật sự là **unit** (không cần Spring context đầy đủ) — nếu cần context, xem **`write-integration-test`** hub.

## Quality

- [ ] Mỗi test có **một hành vi** rõ; tên test đọc được như **spec**.
- [ ] **AAA** dễ nhìn (blank line giữa block nếu file dài).

## Mocking

- [ ] Mock **ranh giới** (I/O, repo, client); không mock **value object** thuần nếu không cần.
- [ ] **`verify`** chỉ khi tương tác là **phần contract** — không verify mọi call by default.

## Determinism

- [ ] Không phụ thuộc **thời gian thực** / **random** không kiểm soát.

## Data

- [ ] Dùng **factory/builder** chung khi lặp lại cấu trúc phức tạp — **`create-test-data`** hub.

## Value

- [ ] Test có **assert ý nghĩa** — không chỉ “chạy được” hoặc mirror code production.

**Last updated:** 2026-04-11
