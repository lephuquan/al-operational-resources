# Examples: Integrate Email Service

Snippet **không chứa mật khẩu**. Đổi host và property cho đúng provider.

## `application.yml` — SMTP (Spring Boot)

```yaml
spring:
  mail:
    host: ${MAIL_HOST:smtp.example.com}
    port: ${MAIL_PORT:587}
    username: ${MAIL_USERNAME:}
    password: ${MAIL_PASSWORD:}
    properties:
      mail:
        smtp:
          auth: true
          starttls:
            enable: true
```

## Gửi mail đơn giản với `JavaMailSender`

Cần `import org.springframework.beans.factory.annotation.Value;` và `jakarta.mail.*` / `MimeMessageHelper`.

```java
@Service
public class SmtpEmailAdapter implements OrderMailPort {

  private final JavaMailSender mailSender;
  private final String fromAddress;

  public SmtpEmailAdapter(JavaMailSender mailSender,
      @Value("${app.mail.from}") String fromAddress) {
    this.mailSender = mailSender;
    this.fromAddress = fromAddress;
  }

  @Override
  public void sendOrderConfirmation(String to, String subject, String textBody) {
    try {
      var message = mailSender.createMimeMessage();
      var helper = new MimeMessageHelper(message, StandardCharsets.UTF_8.name());
      helper.setFrom(fromAddress);
      helper.setTo(to);
      helper.setSubject(subject);
      helper.setText(textBody, false);
      mailSender.send(message);
    } catch (MessagingException e) {
      throw new IllegalStateException("Failed to send email", e); // or domain-specific wrapper
    }
  }
}
```

HTML: `helper.setText(html, true)` — chỉ khi HTML đã an toàn / đã escape biến động.

## Port (application layer)

```java
public interface OrderMailPort {
  void sendOrderConfirmation(String to, String subject, String textBody);
}
```

## Provider HTTP API

Gọi REST SendGrid/SES API bằng **`WebClient`** — làm theo `skills/integration/call-external-api/README.md` (timeout, auth header từ env).

## Async (gợi ý)

```java
@Async("mailExecutor")
public void sendOrderConfirmationAsync(...) { ... }
```

Khai báo `TaskExecutor` `mailExecutor` với pool giới hạn; hoặc publish message lên queue và consumer gửi mail.

**Last updated:** 2026-04-11
