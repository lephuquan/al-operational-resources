# Examples: Implement Webhook Handler

Minh hoạ **Spring MVC**; thuật toán chữ ký phải **khớp 100%** tài liệu provider. Không dán secret thật.

## Controller — raw body + header signature (sketch)

```java
@RestController
@RequestMapping("/api/v1/webhooks")
public class PartnerWebhookController {

  private final WebhookSignatureVerifier verifier;
  private final WebhookIngestionService ingestion;

  @PostMapping(value = "/partner", consumes = MediaType.APPLICATION_JSON_VALUE)
  public ResponseEntity<Void> handle(
      @RequestHeader("X-Partner-Signature") String signatureHeader,
      @RequestBody byte[] rawBody) {

    if (!verifier.isValid(rawBody, signatureHeader)) {
      return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
    }
    ingestion.ingest(rawBody);
    return ResponseEntity.ok().build();
  }
}
```

Một số provider yêu cầu header dạng `t=timestamp,v1=hex` — parse theo spec, kiểm tra **skew thời gian** nếu có.

## HMAC-SHA256 verify (illustrative)

`java.util.HexFormat` (Java 17+); với bản JDK cũ dùng thư viện hex an toàn tương đương.

```java
public boolean isValid(byte[] body, String providedHexMac, byte[] secret) {
  try {
    Mac mac = Mac.getInstance("HmacSHA256");
    mac.init(new SecretKeySpec(secret, "HmacSHA256"));
    byte[] expected = mac.doFinal(body);
    byte[] provided = HexFormat.of().parseHex(providedHexMac); // or provider-specific encoding
    return MessageDigest.isEqual(expected, provided);
  } catch (GeneralSecurityException e) {
    throw new IllegalStateException(e);
  }
}
```

Đừng dùng `String.equals` cho MAC; strip prefix provider (ví dụ `v1=`) trước khi parse hex nếu spec yêu cầu.

## Idempotency — insert-first (SQL idea)

```sql
-- processed_webhook_events(provider, event_id) UNIQUE
INSERT INTO processed_webhook_events (provider, event_id, received_at)
VALUES ('partner', ?, NOW());
-- on duplicate key: return 200 without re-running business handlers
```

Triển khai trong service: bắt **duplicate key** → `Optional.empty()` / no-op và vẫn trả **200**.

## Content caching filter (when you must read body twice)

Nếu filter chain đọc body trước controller, bọc request bằng **`ContentCachingRequestWrapper`** trong filter **OncePerRequestFilter** và forward — chỉ khi thực sự cần; ưu tiên một lần đọc (`byte[]` như trên).

## WireMock — POST with header

```java
wm.stubFor(post(urlEqualTo("/api/v1/webhooks/partner"))
    .withHeader("X-Partner-Signature", matching(".*"))
    .willReturn(aResponse().withStatus(200)));
```

**Last updated:** 2026-04-11
