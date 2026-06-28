package com.techmart.api.service;

import com.techmart.core.dto.ProductDTO;
import com.techmart.core.dto.ProductFilterDTO;
import com.techmart.core.dto.ProductSuggestionDTO;

import java.util.List;

public interface ProductService {
    List<ProductDTO> findLatestProducts(int limit);
    public List<ProductDTO> search(ProductFilterDTO filter);
    List<ProductDTO> findAll();
    public long countSearch(ProductFilterDTO filter);
    List<ProductSuggestionDTO> findSuggestions(String keyword);
}
