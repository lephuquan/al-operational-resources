# Examples: Integrate Message Queue

Minh hoạ **không gắn chặt một vendor**; chỉnh tên field theo chuẩn team.

## Envelope JSON (domain event)

```json
{
  "schemaVersion": 1,
  "eventType": "order.confirmed",
  "occurredAt": "2026-04-11T10:15:30Z",
  "correlationId": "req-abc-123",
  "payload": {
    "orderId": "550e8400-e29b-41d4-a716-446655440000"
  }
}
```

## Spring AMQP — listener sketch (RabbitMQ)

Cần **manual ack** (`SimpleRabbitListenerContainerFactory` với `setAcknowledgeMode(MANUAL)`). `parseAndValidate` = logic dự án. Imports: `com.rabbitmq.client.Channel`, `java.io.IOException`.

```java
@Component
public class OrderEventListener {

  private final OrderApplicationService orders;

  public OrderEventListener(OrderApplicationService orders) {
    this.orders = orders;
  }

  @RabbitListener(queues = "${app.messaging.order-queue}")
  public void onMessage(String json, Channel channel, long deliveryTag) throws IOException {
    var event = parseAndValidate(json);
    orders.onOrderConfirmed(event.payload().orderId());
    channel.basicAck(deliveryTag, false);
  }
}
```

Xử lý lỗi: `basicNack` + `requeue` chỉ khi transient; cấu hình **DLQ** trên queue (Spring Boot declaration hoặc broker policy).

## Spring Kafka — listener sketch

```java
@KafkaListener(topics = "${app.kafka.orders-topic}", groupId = "${app.kafka.consumer-group}")
public void consume(ConsumerRecord<String, String> record, Acknowledgment ack) {
  var event = parseAndValidate(record.value());
  orders.onOrderConfirmed(event.payload().orderId());
  ack.acknowledge();
}
```

Tắt `enable.auto.commit` khi dùng manual ack. Retry / DLQ: cấu hình `DefaultErrorHandler`, dead-letter topic, hoặc pattern team đã chốt.

## Publish sau commit — ý niệm outbox

1. Trong cùng transaction DB: `INSERT business_row` + `INSERT outbox (payload, status='PENDING')`.
2. Publisher job đọc `PENDING`, gửi broker, đánh dấu `SENT`.

Chi tiết triển khai xem `docs/architecture/08-transactions-and-consistency.md` và thư viện outbox team chọn.

## Testcontainers

Dùng `rabbitmq` / `kafka` / `localstack` module Testcontainers trong `@SpringBootTest` để kiểm tra publish → consume end-to-end.

**Last updated:** 2026-04-11
