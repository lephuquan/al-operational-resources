package com.programming_with_al.al_operational_resources.common;

public class ResourceNotFoundException extends RuntimeException {

	private final String code;

	public ResourceNotFoundException(String code, String message) {
		super(message);
		this.code = code;
	}

	public String getCode() {
		return code;
	}
}

