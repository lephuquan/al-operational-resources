# Skill: Review Project Architecture

## Goal

Đánh giá nhanh kiến trúc repo: layering, coupling, testability, và đề xuất cải tiến có thứ tự ưu tiên.

## Steps

1. Đọc `docs/architecture/02-system-overview.md` và `docs/architecture/04-folder-structure.md`.
2. Quét package: controller có business logic không; service có gọi DB trực tiếp lộn xộn không.
3. Kiểm tra cross-cutting: security, exception handling, logging.
4. Đánh giá test pyramid: unit vs integration coverage.
5. Liệt kê 3 điểm mạnh + 3 rủi ro + 3 hành động theo P0/P1/P2.

## Output

- Báo cáo ngắn (bullet) — không refactor lớn trừ khi có plan.
