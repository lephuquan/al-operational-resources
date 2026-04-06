# Skill: Security Review

## Goal

Rà soát nhanh bảo mật: secret, injection, authz, data exposure.

## Checklist

- [ ] Secret / env không hardcode
- [ ] SQL injection: JPA parameterized / prepared
- [ ] XSS: nếu có HTML output
- [ ] Mass assignment: không bind field nhạy cảm
- [ ] IDOR: kiểm tra resource thuộc user đúng
- [ ] Log không chứa token/password
- [ ] Dependency vulnerabilities (`mvn dependency:check` nếu team dùng)
