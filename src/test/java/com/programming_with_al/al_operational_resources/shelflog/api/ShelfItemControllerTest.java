package com.programming_with_al.al_operational_resources.shelflog.api;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.delete;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.put;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.util.UUID;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.programming_with_al.al_operational_resources.shelflog.persistence.ShelfItemRepository;

@SpringBootTest
@AutoConfigureMockMvc
@SuppressWarnings("null")
class ShelfItemControllerTest {

	@Autowired
	private MockMvc mockMvc;

	@Autowired
	private ObjectMapper objectMapper;

	@Autowired
	private ShelfItemRepository repository;

	@BeforeEach
	void setUp() {
		repository.deleteAll();
	}

	@Test
	void create_returns201() throws Exception {
		mockMvc.perform(post("/api/v1/shelf-items")
				.contentType(MediaType.APPLICATION_JSON)
				.content(validRequest("Desk lamp", "HOBBY", 2, "for reading").toString()))
				.andExpect(status().isCreated())
				.andExpect(jsonPath("$.id").isString())
				.andExpect(jsonPath("$.title").value("Desk lamp"))
				.andExpect(jsonPath("$.category").value("HOBBY"))
				.andExpect(jsonPath("$.quantity").value(2))
				.andExpect(jsonPath("$.createdAt").isString())
				.andExpect(jsonPath("$.updatedAt").isString());
	}

	@Test
	void get_found_and_notFound() throws Exception {
		final UUID id = createItem("Notebook", "OFFICE", 3, "A5");

		mockMvc.perform(get("/api/v1/shelf-items/{id}", id))
				.andExpect(status().isOk())
				.andExpect(jsonPath("$.id").value(id.toString()))
				.andExpect(jsonPath("$.title").value("Notebook"));

		mockMvc.perform(get("/api/v1/shelf-items/{id}", UUID.randomUUID()))
				.andExpect(status().isNotFound())
				.andExpect(jsonPath("$.success").value(false))
				.andExpect(jsonPath("$.error.code").value("SHELF_404"));
	}

	@Test
	void put_updates_fields() throws Exception {
		final UUID id = createItem("Old title", "KITCHEN", 1, "old notes");

		mockMvc.perform(put("/api/v1/shelf-items/{id}", id)
				.contentType(MediaType.APPLICATION_JSON)
				.content(validRequest("New title", "HOBBY", 5, "new notes").toString()))
				.andExpect(status().isOk())
				.andExpect(jsonPath("$.id").value(id.toString()))
				.andExpect(jsonPath("$.title").value("New title"))
				.andExpect(jsonPath("$.category").value("HOBBY"))
				.andExpect(jsonPath("$.quantity").value(5))
				.andExpect(jsonPath("$.notes").value("new notes"));

		mockMvc.perform(put("/api/v1/shelf-items/{id}", UUID.randomUUID())
				.contentType(MediaType.APPLICATION_JSON)
				.content(validRequest("X", "OTHER", 1, null).toString()))
				.andExpect(status().isNotFound());
	}

	@Test
	void delete_then_get_404() throws Exception {
		final UUID id = createItem("To delete", "OTHER", 1, null);

		mockMvc.perform(delete("/api/v1/shelf-items/{id}", id))
				.andExpect(status().isNoContent());

		mockMvc.perform(get("/api/v1/shelf-items/{id}", id))
				.andExpect(status().isNotFound())
				.andExpect(jsonPath("$.error.code").value("SHELF_404"));
	}

	@Test
	void list_pagination_and_category() throws Exception {
		createItem("A", "HOBBY", 1, null);
		createItem("B", "HOBBY", 2, null);
		createItem("C", "OFFICE", 3, null);

		mockMvc.perform(get("/api/v1/shelf-items")
				.param("page", "0")
				.param("size", "1")
				.param("category", "HOBBY"))
				.andExpect(status().isOk())
				.andExpect(jsonPath("$.page").value(0))
				.andExpect(jsonPath("$.size").value(1))
				.andExpect(jsonPath("$.totalElements").value(2))
				.andExpect(jsonPath("$.content.length()").value(1))
				.andExpect(jsonPath("$.content[0].category").value("HOBBY"));
	}

	@Test
	void validation_errors() throws Exception {
		mockMvc.perform(post("/api/v1/shelf-items")
				.contentType(MediaType.APPLICATION_JSON)
				.content(validRequest("  ", "HOBBY", 1000, null).toString()))
				.andExpect(status().isBadRequest())
				.andExpect(jsonPath("$.success").value(false))
				.andExpect(jsonPath("$.error.code").value("COMMON_400_VALIDATION"))
				.andExpect(jsonPath("$.error.details").isArray());

		mockMvc.perform(get("/api/v1/shelf-items")
				.param("size", "101"))
				.andExpect(status().isBadRequest())
				.andExpect(jsonPath("$.error.code").value("COMMON_400_VALIDATION"));
	}

	private UUID createItem(String title, String category, int quantity, String notes) throws Exception {
		final MvcResult result = mockMvc.perform(post("/api/v1/shelf-items")
				.contentType(MediaType.APPLICATION_JSON)
				.content(validRequest(title, category, quantity, notes).toString()))
				.andExpect(status().isCreated())
				.andReturn();

		final JsonNode jsonNode = objectMapper.readTree(result.getResponse().getContentAsString());
		return UUID.fromString(jsonNode.get("id").asText());
	}

	private ObjectNode validRequest(String title, String category, int quantity, String notes) {
		final ObjectNode body = objectMapper.createObjectNode();
		body.put("title", title);
		body.put("category", category);
		body.put("quantity", quantity);
		if (notes != null) {
			body.put("notes", notes);
		}
		return body;
	}
}

