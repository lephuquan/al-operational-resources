package com.programming_with_al.al_operational_resources.common;

import java.util.Comparator;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindException;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.method.annotation.MethodArgumentTypeMismatchException;

import jakarta.validation.ConstraintViolationException;

@RestControllerAdvice
public class GlobalExceptionHandler {

	@ExceptionHandler(ResourceNotFoundException.class)
	public ResponseEntity<ApiErrorResponse> handleNotFound(ResourceNotFoundException ex) {
		return ResponseEntity.status(HttpStatus.NOT_FOUND)
				.body(ApiErrorResponse.of(ex.getCode(), ex.getMessage()));
	}

	@ExceptionHandler(ConflictException.class)
	public ResponseEntity<ApiErrorResponse> handleConflict(ConflictException ex) {
		return ResponseEntity.status(HttpStatus.CONFLICT)
				.body(ApiErrorResponse.of(ex.getCode(), ex.getMessage()));
	}

	@ExceptionHandler({ MethodArgumentNotValidException.class, BindException.class })
	public ResponseEntity<ApiErrorResponse> handleValidation(Exception ex) {
		final List<FieldError> fieldErrors = ex instanceof MethodArgumentNotValidException invalid
				? invalid.getBindingResult().getFieldErrors()
				: ((BindException) ex).getBindingResult().getFieldErrors();

		final List<ApiErrorResponse.ValidationDetail> details = fieldErrors.stream()
				.sorted(Comparator.comparing(FieldError::getField))
				.map(error -> new ApiErrorResponse.ValidationDetail(error.getField(), error.getDefaultMessage()))
				.toList();

		return ResponseEntity.badRequest()
				.body(ApiErrorResponse.of("COMMON_400_VALIDATION", "Validation failed", details));
	}

	@ExceptionHandler(MethodArgumentTypeMismatchException.class)
	public ResponseEntity<ApiErrorResponse> handleTypeMismatch(MethodArgumentTypeMismatchException ex) {
		final ApiErrorResponse.ValidationDetail detail = new ApiErrorResponse.ValidationDetail(
				ex.getName(),
				"Invalid value for parameter");
		return ResponseEntity.badRequest()
				.body(ApiErrorResponse.of("COMMON_400_VALIDATION", "Validation failed", List.of(detail)));
	}

	@ExceptionHandler(ConstraintViolationException.class)
	public ResponseEntity<ApiErrorResponse> handleConstraintViolation(ConstraintViolationException ex) {
		final List<ApiErrorResponse.ValidationDetail> details = ex.getConstraintViolations().stream()
				.map(violation -> new ApiErrorResponse.ValidationDetail(
						violation.getPropertyPath().toString(),
						violation.getMessage()))
				.toList();
		return ResponseEntity.badRequest()
				.body(ApiErrorResponse.of("COMMON_400_VALIDATION", "Validation failed", details));
	}
}

