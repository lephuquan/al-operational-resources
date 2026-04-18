package com.programming_with_al.al_operational_resources.common;

/**
 * Thrown when a CSV export would exceed the configured catalogue row limit for the current filter.
 */
public class ExportTooLargeException extends RuntimeException {

	public static final String CODE = "SHELF_413_EXPORT";

	public ExportTooLargeException(String message) {
		super(message);
	}

	public String getCode() {
		return CODE;
	}
}
