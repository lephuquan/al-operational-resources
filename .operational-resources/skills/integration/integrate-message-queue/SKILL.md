# Skill: Integrate Message Queue

## Goal

Tích hợp queue (RabbitMQ/Kafka/SQS): producer/consumer, retry DLQ, schema message.

## Steps

1. Định nghĩa format message (JSON + version field).
2. Producer: serialize + correlation id; handle send failure.
3. Consumer: idempotent processing; ack sau khi xử lý thành công (hoặc theo semantics).
4. DLQ: poison message không làm loop vô hạn.
5. Observability: lag, consumer lag, error rate.
