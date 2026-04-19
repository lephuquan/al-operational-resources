# Coding Patterns (Spring Boot)

## Layered flow

- Controller nhận request → validate DTO → gọi service.
- Service chứa business logic và transaction.
- Repository chỉ persistence.

## Transaction

- `@Transactional` trên service method cho luồng ghi đa bước.
- Đọc kỹ propagation isolation (mặc định thường đủ).

## Error mapping

- Ném exception có mã domain (`OrderNotFoundException`) → map sang HTTP + `error.code` trong `@ControllerAdvice`.

## Testing

- Unit: mock repository/client.
- Slice: `@WebMvcTest` cho controller; `@DataJpaTest` cho repository khi cần.
