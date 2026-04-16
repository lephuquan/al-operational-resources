package com.programming_with_al.al_operational_resources.demo.user.api;

import jakarta.validation.constraints.AssertTrue;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public record CreateUserRequest(
		@NotBlank @Email String email,
		@Size(max = 200) String name) {

	@AssertTrue(message = "name must not be blank when provided")
	public boolean isNameValid() {
		if (name == null) {
			return true;
		}
		return !name.trim().isEmpty();
	}
}
