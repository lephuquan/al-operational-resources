# Examples: Reduce Memory Usage

## JPA `Stream` (phải đóng — khung minh hoạ)

```java
@Transactional(readOnly = true)
public void exportAll(Consumer<Order> consumer) {
  try (Stream<Order> stream = orderRepository.streamAll()) {
    stream.forEach(consumer);
  }
}
```

Cần repository hỗ trợ stream; kiểm tra fetch size / dialect theo doc Hibernate.

## Xử lý theo batch ID

```java
UUID lastId = null;
final int batch = 500;
List<Order> chunk;
do {
  chunk = orderRepository.findNextBatch(lastId, batch);
  for (Order o : chunk) {
    process(o);
  }
  lastId = chunk.isEmpty() ? null : chunk.get(chunk.size() - 1).getId();
} while (!chunk.isEmpty());
```

## Copy stream sang output (không nạp hết file)

```java
try (InputStream in = source.openStream();
     OutputStream out = Files.newOutputStream(target)) {
  in.transferTo(out);
}
```

**Last updated:** 2026-04-11
