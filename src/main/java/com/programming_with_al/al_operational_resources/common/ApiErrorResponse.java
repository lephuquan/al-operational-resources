package com.programming_with_al.al_operational_resources.common;

import java.util.List;

public record ApiErrorResponse(
		boolean success,
		ErrorBody error) {

	public static ApiErrorResponse of(String code, String message) {
		return new ApiErrorResponse(false, new ErrorBody(code, message, null));
	}

	public static ApiErrorResponse of(String code, String message, List<ValidationDetail> details) {
		return new ApiErrorResponse(false, new ErrorBody(code, message, details));
	}

	public record ErrorBody(
			String code,
			String message,
			Object details) {
	}

	public record ValidationDetail(
			String field,
			String reason) {
	}
}

