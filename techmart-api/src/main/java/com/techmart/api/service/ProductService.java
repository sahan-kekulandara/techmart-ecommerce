package com.techmart.api.service;

import com.techmart.core.dto.ProductDTO;

import java.util.List;

public interface ProductService {
    List<ProductDTO> findLatestProducts(int limit);
}
