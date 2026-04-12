# Examples: Map Exceptions to HTTP

Bảng và code minh hoạ; thay prefix module và mã cho đúng dự án.

## Documentation table (template)

Thêm vào `docs/knowledge-base/error-codes.md` hoặc mở rộng bảng trong `05-error-handling.md`:

| `error.code` | HTTP | When (trigger) |
|--------------|------|----------------|
| `ORDER_404` | 404 | Order id không tồn tại |
| `ORDER_409` | 409 | Order đã paid, không huỷ được |
| `PAYMENT_502` | 502 | Provider timeout / bad gateway |
| `COMMON_500` | 500 | Unexpected (fallback) |

## Java — domain exception carries status + code (sketch)

```java
public class DomainException extends RuntimeException {
  private final String errorCode;
  private final HttpStatus httpStatus;

  public DomainException(String errorCode, HttpStatus httpStatus, String safeMessage) {
    super(safeMessage);
    this.errorCode = errorCode;
    this.httpStatus = httpStatus;
  }

  public String getErrorCode() { return errorCode; }
  public HttpStatus getHttpStatus() { return httpStatus; }
}
```

Handler:

```java
@ExceptionHandler(DomainException.class)
public ResponseEntity<ApiErrorResponse> handleDomain(DomainException ex) {
  var body = ApiErrorResponse.of(ex.getErrorCode(), ex.getMessage(), null);
  return ResponseEntity.status(ex.getHttpStatus()).body(body);
}
```

## Java — enum registry (alternative)

```java
public enum OrderError {
  NOT_FOUND("ORDER_404", HttpStatus.NOT_FOUND, "Order not found"),
  ALREADY_PAID("ORDER_409", HttpStatus.CONFLICT, "Order already paid");

  private final String code;
  private final HttpStatus status;
  private final String message;

  OrderError(String code, HttpStatus status, String message) {
    this.code = code;
    this.status = status;
    this.message = message;
  }
  // getters …
}
```

Services throw a thin wrapper that references `OrderError`; handler maps enum → `ResponseEntity`.

**Last updated:** 2026-04-11
