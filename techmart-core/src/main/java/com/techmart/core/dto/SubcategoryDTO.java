package com.techmart.core.dto;

import com.techmart.core.entity.Category;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class SubcategoryDTO implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;
    private String subcategory;
    private CategoryDTO category;
}
