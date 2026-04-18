package com.programming_with_al.al_operational_resources.shelflog.api;

import static org.assertj.core.api.Assertions.assertThat;
import static org.hamcrest.Matchers.allOf;
import static org.hamcrest.Matchers.containsString;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.header;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.Timeout;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;

import org.springframework.http.HttpHeaders;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.programming_with_al.al_operational_resources.shelflog.application.ShelfItemService;
import com.programming_with_al.al_operational_resources.shelflog.persistence.ShelfCategory;
import com.programming_with_al.al_operational_resources.shelflog.persistence.ShelfItemEntity;
import com.programming_with_al.al_operational_resources.shelflog.persistence.ShelfItemRepository;

@SpringBootTest
@AutoConfigureMockMvc
@SuppressWarnings("null")
class ShelfItemExportControllerTest {

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
	void export_returnsCsvWithDisposition() throws Exception {
		createItem("Desk", "HOBBY", 2, "n1");
		createItem("Chair", "OFFICE", 1, null);

		mockMvc.perform(get("/api/v1/shelf-items/export"))
				.andExpect(status().isOk())
				.andExpect(header().string("Content-Type", "text/csv;charset=UTF-8"))
				.andExpect(header().string(HttpHeaders.CONTENT_DISPOSITION,
						allOf(containsString("attachment"), containsString("shelf-items-"), containsString(".csv"))));
	}

	@Test
	void export_csvFormatAndHeader() throws Exception {
		createItem("Only", "KITCHEN", 0, null);

		final MvcResult result = mockMvc.perform(get("/api/v1/shelf-items/export"))
				.andExpect(status().isOk())
				.andReturn();

		final String body = result.getResponse().getContentAsString(StandardCharsets.UTF_8);
		assertThat(body).startsWith("id,title,category,quantity,notes,createdAt,updatedAt\n");
		assertThat(body).contains("Only");
		assertThat(body).contains("KITCHEN");
		final byte[] raw = result.getResponse().getContentAsByteArray();
		final boolean utf8Bom = raw.length >= 3 && raw[0] == (byte) 0xEF && raw[1] == (byte) 0xBB && raw[2] == (byte) 0xBF;
		assertThat(utf8Bom).as("CSV must not start with UTF-8 BOM").isFalse();
	}

	@Test
	void export_respectsCategoryAndPagination() throws Exception {
		createItem("A", "HOBBY", 1, null);
		createItem("B", "HOBBY", 2, null);
		createItem("C", "OFFICE", 3, null);

		final String body = mockMvc.perform(get("/api/v1/shelf-items/export")
				.param("page", "0")
				.param("size", "1")
				.param("category", "HOBBY"))
				.andExpect(status().isOk())
				.andReturn()
				.getResponse()
				.getContentAsString(StandardCharsets.UTF_8);

		final long lineCount = body.lines().count();
		assertThat(lineCount).isEqualTo(2L);
		assertThat(body).contains("HOBBY");
		assertThat(body).doesNotContain("OFFICE");
	}

	@Test
	@Timeout(180)
	void export_exceedsCap_returns413() throws Exception {
		final List<ShelfItemEntity> batch = new ArrayList<>();
		for (int i = 0; i < ShelfItemService.MAX_EXPORT_MATCHING_ROWS + 1; i++) {
			final ShelfItemEntity e = new ShelfItemEntity();
			e.setTitle("bulk-" + i);
			e.setCategory(ShelfCategory.OTHER);
			e.setQuantity(0);
			e.setNotes(null);
			batch.add(e);
		}
		repository.saveAll(batch);

		mockMvc.perform(get("/api/v1/shelf-items/export").param("page", "0").param("size", "10"))
				.andExpect(status().isPayloadTooLarge())
				.andExpect(jsonPath("$.success").value(false))
				.andExpect(jsonPath("$.error.code").value("SHELF_413_EXPORT"));
	}

	@Test
	void export_escapesFormulaPrefix() throws Exception {
		createItem("=SUM(1)", "HOBBY", 1, null);

		final String body = mockMvc.perform(get("/api/v1/shelf-items/export"))
				.andExpect(status().isOk())
				.andReturn()
				.getResponse()
				.getContentAsString(StandardCharsets.UTF_8);

		assertThat(body).contains("'=SUM(1)");
	}

	@Test
	void export_invalidSize_returns400() throws Exception {
		mockMvc.perform(get("/api/v1/shelf-items/export").param("size", "101"))
				.andExpect(status().isBadRequest())
				.andExpect(jsonPath("$.error.code").value("COMMON_400_VALIDATION"));
	}

	private void createItem(String title, String category, int quantity, String notes) throws Exception {
		final ObjectNode body = objectMapper.createObjectNode();
		body.put("title", title);
		body.put("category", category);
		body.put("quantity", quantity);
		if (notes != null) {
			body.put("notes", notes);
		}
		mockMvc.perform(post("/api/v1/shelf-items")
				.contentType(MediaType.APPLICATION_JSON)
				.content(body.toString()))
				.andExpect(status().isCreated());
	}
}
