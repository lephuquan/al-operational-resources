# Examples: Call External API

Snippet **không chứa secret**. Đổi tên package, property prefix, và path cho đúng dự án.

## `application.yml` (tên biến / URL — không ghi giá trị secret)

```yaml
app:
  partner-api:
    base-url: ${PARTNER_API_BASE_URL:https://api.example.com}
    connect-timeout: 2s
    response-timeout: 5s
```

## `@ConfigurationProperties` (sketch)

```java
@ConfigurationProperties(prefix = "app.partner-api")
public record PartnerApiProperties(
    URI baseUrl,
    Duration connectTimeout,
    Duration responseTimeout
) {}
```

## `WebClient` bean with timeouts and buffer cap

```java
@Configuration
public class PartnerApiConfig {

  @Bean
  public WebClient partnerWebClient(PartnerApiProperties props) {
    var httpClient = HttpClient.create()
        .responseTimeout(props.responseTimeout())
        .option(ChannelOption.CONNECT_TIMEOUT_MILLIS,
            (int) props.connectTimeout().toMillis());

    var strategies = ExchangeStrategies.builder()
        .codecs(c -> c.defaultCodecs().maxInMemorySize(2 * 1024 * 1024))
        .build();

    return WebClient.builder()
        .baseUrl(props.baseUrl().toString())
        .clientConnector(new ReactorClientHttpConnector(httpClient))
        .exchangeStrategies(strategies)
        .build();
  }
}
```

Imports: `io.netty.channel.ChannelOption`, `reactor.netty.http.client.HttpClient`, `org.springframework.http.client.reactive.ReactorClientHttpConnector`, `org.springframework.web.reactive.function.client.ExchangeStrategies`, `org.springframework.web.reactive.function.client.WebClient`.

## Auth header from env (sketch)

```java
@Component
public class PartnerApiClient {
  private final WebClient webClient;
  private final String apiKey; // from @Value("${PARTNER_API_KEY}") — never log

  public PartnerApiClient(WebClient partnerWebClient,
      @Value("${PARTNER_API_KEY}") String apiKey) {
    this.webClient = partnerWebClient;
    this.apiKey = apiKey;
  }

  // use .header("X-Api-Key", apiKey) per integration doc
}
```

## WireMock — JUnit 5 (sketch)

```java
@ExtendWith(SpringExtension.class)
@SpringBootTest(webEnvironment = RANDOM_PORT)
class PartnerApiClientIT {

  @RegisterExtension
  static WireMockExtension wm = WireMockExtension.newInstance()
      .options(wireMockConfig().dynamicPort())
      .build();

  @Test
  void returnsBody() {
    wm.stubFor(get(urlEqualTo("/v1/resource"))
        .willReturn(aResponse().withStatus(200)
            .withHeader("Content-Type", "application/json")
            .withBody("{\"id\":\"1\"}")));
    // inject base URL pointing to wm.getPort(), call client, assert
  }
}
```

Point `PartnerApiProperties.baseUrl` to `http://localhost:<wiremock port>` in test `@TestConfiguration` or dynamic property.

**Last updated:** 2026-04-11
