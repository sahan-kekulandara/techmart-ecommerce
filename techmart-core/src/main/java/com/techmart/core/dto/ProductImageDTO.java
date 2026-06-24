package com.techmart.core.dto;

import com.techmart.core.entity.Product;
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
public class ProductImageDTO implements Serializable {

    private Integer id;
    private Product product;
    private String imagePath;
    private Boolean isPrimary = false;
}