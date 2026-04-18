# Examples: API Error Response Format

JSON khớp **`docs/api/03-response-format.md`** và **`05-error-handling.md`**. Không dán secret hay lỗi thật từ prod.

## Generic domain / server error

```json
{
  "success": false,
  "error": {
    "code": "ORDER_001",
    "message": "Requested operation cannot be completed",
    "details": null
  }
}
```

## Validation (`details` as array)

```json
{
  "success": false,
  "error": {
    "code": "COMMON_400_VALIDATION",
    "message": "Validation failed",
    "details": [
      { "field": "email", "reason": "must be a valid email address" },
      { "field": "quantity", "reason": "must be greater than 0" }
    ]
  }
}
```

## Java — response wrapper (illustrative)

```java
public record ApiErrorBody(String code, String message, Object details) {}

public record ApiErrorResponse(boolean success, ApiErrorBody error) {
  public static ApiErrorResponse of(String code, String message, Object details) {
    return new ApiErrorResponse(false, new ApiErrorBody(code, message, details));
  }
}
```

Handler returns `ResponseEntity<ApiErrorResponse>` with the appropriate HTTP status.

## Spring — `ResponseEntity` sketch

```java
return ResponseEntity
    .status(HttpStatus.NOT_FOUND)
    .body(ApiErrorResponse.of("ORDER_404", "Order not found", null));
```

**Last updated:** 2026-04-11
