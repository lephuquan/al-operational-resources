# Skill: Configure Environment

## Goal

Spring profiles: `dev`, `staging`, `prod`; secret qua env; không commit `.env` prod.

## Steps

1. `application-{profile}.yml` tách config; secret chỉ env/secret manager.
2. `@ConfigurationProperties` với validation.
3. Feature flags: `if`/`@ConditionalOnProperty` có tài liệu.
4. Document biến bắt buộc trong README team (không secret).
