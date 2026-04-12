# Examples: Global Exception Handler

Minh hoạ **Spring MVC**; điều chỉnh package, tên type (`ApiErrorResponse`), và mapper domain cho đúng project. Không paste secret.

## `RestControllerAdvice` — validation + fallback (sketch)

```java
record ValidationDetail(String field, String reason) {}

@RestControllerAdvice
public class ApiExceptionHandler {

  @ExceptionHandler(MethodArgumentNotValidException.class)
  public ResponseEntity<ApiErrorResponse> handleValidation(MethodArgumentNotValidException ex) {
    var details = ex.getBindingResult().getFieldErrors().stream()
        .map(fe -> new ValidationDetail(fe.getField(), fe.getDefaultMessage()))
        .toList();
    var body = ApiErrorResponse.of("COMMON_400_VALIDATION", "Validation failed", details);
    return ResponseEntity.badRequest().body(body);
  }

  @ExceptionHandler(Exception.class)
  public ResponseEntity<ApiErrorResponse> handleAny(Exception ex) {
    // log.error("Unhandled", ex); + MDC correlation id
    var body = ApiErrorResponse.of("COMMON_500", "An unexpected error occurred", null);
    return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body);
  }
}
```

`ValidationDetail` should serialize to `field` + `reason` per `docs/api/05-error-handling.md`.

## `WebMvcTest` — assert envelope

```java
@WebMvcTest(controllers = OrderController.class)
@Import(ApiExceptionHandler.class)
class OrderControllerTest {

  @Autowired MockMvc mvc;

  @Test
  void validationReturns400Envelope() throws Exception {
    mvc.perform(post("/api/orders").contentType(MediaType.APPLICATION_JSON).content("{}"))
        .andExpect(status().isBadRequest())
        .andExpect(jsonPath("$.success").value(false))
        .andExpect(jsonPath("$.error.code").value("COMMON_400_VALIDATION"));
  }
}
```

Add `@MockBean` for services the controller needs.

## Optional: delegate to `ResponseEntityExceptionHandler`

Teams can extend Spring’s **`ResponseEntityExceptionHandler`** and override selected methods, then still map to **`ApiErrorResponse`**. Keep behavior aligned with **`03-response-format.md`** for all overridden endpoints.

**Last updated:** 2026-04-11
