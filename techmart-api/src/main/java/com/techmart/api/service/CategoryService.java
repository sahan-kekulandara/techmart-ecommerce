package com.techmart.api.service;

import com.techmart.core.dto.CategoryDTO;

import java.util.List;

public interface CategoryService {
    List<CategoryDTO> findAll();
}