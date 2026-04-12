# Checklist: Dockerize Service

Dùng trước khi merge Dockerfile / compose liên quan. Không ghi secret vào MR.

## Build & run

- [ ] `docker build` thành công từ **đúng build context** đã ghi trong `docs/setup/` (nếu có).
- [ ] Container start được với **`SPRING_PROFILES_ACTIVE`** (hoặc default đã thống nhất).
- [ ] App lắng nghe đúng port đã `EXPOSE` và khớp `server.port` (hoặc map port khi run).

## Image hardening

- [ ] Process chạy dưới user **non-root**.
- [ ] `ENTRYPOINT` dạng **exec** (`["java", ...]`), không chỉ shell string nếu tránh được.
- [ ] Không có password, token, private key trong **Dockerfile**, **ARG**, **ENV**, hoặc file copy vào image.

## Context & size

- [ ] Có **`.dockerignore`** (loại `target/`, `.git`, IDE, local env files).
- [ ] Base image tag **có kiểm soát** (không `latest` tuỳ tiện cho prod nếu team có quy định).

## Health & ops

- [ ] **HEALTHCHECK** hoặc tài liệu probe (K8s) khớp endpoint Actuator team dùng (`/actuator/health`, liveness/readiness).
- [ ] Log ra **stdout/stderr** phù hợp với stack thu log (xem skill configure-logging).

## Docs

- [ ] `docs/setup/` có dòng về: cách build image, tên biến env cần inject, port mặc định.

**Last updated:** 2026-04-11
