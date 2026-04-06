# Skill: Analyze Application Logs

## Goal

Đọc log để tìm pattern: grep, Loki/ELK, correlation id.

## Steps

1. Filter theo time range + service + level ERROR.
2. Group theo exception message / endpoint.
3. Join với deploy timeline; xác định regression.
4. Không export log chứa secret vào ticket công khai.
