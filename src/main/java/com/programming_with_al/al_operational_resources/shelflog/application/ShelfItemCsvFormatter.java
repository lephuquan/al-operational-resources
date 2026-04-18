package com.programming_with_al.al_operational_resources.shelflog.application;

import java.nio.charset.StandardCharsets;
import java.util.List;

import com.programming_with_al.al_operational_resources.shelflog.persistence.ShelfItemEntity;

/**
 * Builds UTF-8 CSV (no BOM) for shelf item rows. Comma delimiter; spreadsheet-safe for formula injection.
 */
public final class ShelfItemCsvFormatter {

	private static final List<String> HEADER = List.of(
			"id", "title", "category", "quantity", "notes", "createdAt", "updatedAt");

	private ShelfItemCsvFormatter() {
	}

	public static byte[] toCsvUtf8Bytes(List<ShelfItemEntity> rows) {
		final StringBuilder sb = new StringBuilder();
		sb.append(String.join(",", HEADER)).append('\n');
		for (ShelfItemEntity e : rows) {
			sb.append(csvCell(e.getId() != null ? e.getId().toString() : "")).append(',');
			sb.append(csvCell(e.getTitle())).append(',');
			sb.append(csvCell(e.getCategory() != null ? e.getCategory().name() : "")).append(',');
			sb.append(csvCell(e.getQuantity() != null ? e.getQuantity().toString() : "")).append(',');
			sb.append(csvCell(e.getNotes())).append(',');
			sb.append(csvCell(e.getCreatedAt() != null ? e.getCreatedAt().toString() : "")).append(',');
			sb.append(csvCell(e.getUpdatedAt() != null ? e.getUpdatedAt().toString() : ""));
			sb.append('\n');
		}
		return sb.toString().getBytes(StandardCharsets.UTF_8);
	}

	static String csvCell(String raw) {
		if (raw == null) {
			return "";
		}
		String v = raw;
		if (!v.isEmpty()) {
			final char c = v.charAt(0);
			if (c == '=' || c == '+' || c == '-' || c == '@') {
				v = "'" + v;
			}
		}
		return escapeCsvField(v);
	}

	private static String escapeCsvField(String v) {
		final boolean needQuotes = v.contains(",") || v.contains("\"") || v.contains("\n") || v.contains("\r");
		if (needQuotes) {
			return "\"" + v.replace("\"", "\"\"") + "\"";
		}
		return v;
	}
}
