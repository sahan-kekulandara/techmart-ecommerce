package com.techmart.ejb.service;

import com.techmart.api.service.ProductService;
import com.techmart.core.dto.ProductDTO;
import com.techmart.core.dto.ProductFilterDTO;
import com.techmart.core.dto.ProductSuggestionDTO;
import com.techmart.core.entity.Product;
import com.techmart.core.mapper.ProductMapper;
import com.techmart.ejb.repository.ProductRepository;
import jakarta.ejb.EJB;
import jakarta.ejb.Stateless;
import jakarta.inject.Inject;

import java.util.List;
import java.util.stream.Collectors;

@Stateless
public class ProductServiceBean implements ProductService {

    @EJB
    private ProductRepository repository;

    @Inject
    private ProductMapper productMapper;

    @Override
    public List<ProductDTO> findLatestProducts(int limit) {
        return repository.findLatestProducts(limit).stream()
                .map(productMapper::toDTO)
                .collect(Collectors.toList());
    }

    @Override
    public List<ProductDTO> search(ProductFilterDTO filter) {
        return repository.search(filter).stream()
                .map(productMapper::toDTO)
                .collect(Collectors.toList());
    }

    @Override
    public long countSearch(ProductFilterDTO filter) {
        return repository.countSearch(filter);
    }

    @Override
    public List<ProductSuggestionDTO> findSuggestions(String keyword) {
        return repository.searchSuggestions(keyword).stream()
                .map(productMapper::toSuggestionDTO)
                .collect(Collectors.toList());
    }

    @Override
    public List<ProductDTO> findAll() {
        return repository.findAll().stream()
                .map(productMapper::toDTO)
                .collect(Collectors.toList());
    }
}