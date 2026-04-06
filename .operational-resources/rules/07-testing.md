# 07 - Testing Strategy

- **Unit test**: logic quan trọng (service, domain, pure utils) — JUnit 5 + Mockito khi cần mock.
- **Integration test**: API / persistence — Spring Boot Test, `@SpringBootTest` hoặc slice tests (`@WebMvcTest`, `@DataJpaTest`) tùy phạm vi.
- **E2E**: flow quan trọng nếu team có công cụ (Playwright/Cypress cho web — áp dụng khi có UI).
- **Coverage**: mục tiêu **≥ 80%** cho **business logic** (không cố đạt số đẹp bằng test vô nghĩa).
- Tên test rõ hành vi, ví dụ: `shouldCreateOrderSuccessfullyWhenStockAvailable`.
