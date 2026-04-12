# Checklist: Reduce Memory Usage

Dùng trước khi merge thay đổi xử lý bulk/stream hoặc cấu hình heap.

## Data paths

- [ ] Không còn **`findAll()`** / tương đương cho volume không giới hạn trên path người dùng hoặc job lớn.
- [ ] **Stream/batch** có **đóng** resource (try-with-resources / explicit close) khi dùng JPA/JDBC stream.

## Files / HTTP

- [ ] Upload/download lớn không đọc **full `byte[]`** không giới hạn; có **max size** ở boundary.

## Cache

- [ ] Cache in-process có **giới hạn** (size/weight) hoặc TTL — không phình heap vô hạn.

## JVM / container

- [ ] **Heap + limit pod** đã xem xét; có ghi `docs/setup/` hoặc runbook nếu đổi `JAVA_OPTS`.
- [ ] Không chỉ tăng memory mà **không** xử lý nguồn allocation.

## Evidence

- [ ] Có **trước/sau** (metric, load test ngắn, hoặc mô tả reproduce) trong MR/incident.

## Production dumps

- [ ] Nếu heap dump prod: đã có **phê duyệt** và xử lý **PII**.

**Last updated:** 2026-04-11
