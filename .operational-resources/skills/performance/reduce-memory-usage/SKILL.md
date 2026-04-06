# Skill: Reduce Memory Usage

## Goal

Giảm footprint: streaming, batch, tránh collection khổng lồ trong memory.

## Steps

1. Tránh `findAll()` khi không cần; dùng streaming query / batch size.
2. Xử lý file lớn: `InputStream` streaming, không byte[] toàn bộ.
3. GC pressure: giảm object churn trong hot loop.
4. Heap dump khi cần (prod chỉ khi có quyết định sự cố).
