package com.techmart.core.dto;

import com.techmart.core.entity.Category;
import com.techmart.core.entity.ProductStatus;
import com.techmart.core.entity.Subcategory;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ProductDTO implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;
    private String title;
    private String description;
    private Double price;
    private int qty;
    private Timestamp createdAt;
    private SubcategoryDTO subcategory;
    private ProductStatusDTO productStatus;
    private List<ProductImageDTO> images;
}
