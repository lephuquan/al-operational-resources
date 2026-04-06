# Skill: API Error Response Format

## Goal

Đồng bộ envelope lỗi với `success: false`, `error.code`, `error.message`, optional `details`.

## Steps

1. DTO error response khớp `docs/api/response-format.md`.
2. `message` thân thiện user; `details` chỉ khi an toàn.
3. Không trả internal class name / SQL trong message.
4. i18n: optional message key (nếu team có).
