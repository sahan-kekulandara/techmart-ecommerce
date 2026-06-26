package com.techmart.core.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ProductPageDTO {
    private static final long serialVersionUID = 1L;

    private List<ProductDTO> products;
    private int currentPage;
    private int pageSize;
    private long totalItems;
    private int totalPages;
}
