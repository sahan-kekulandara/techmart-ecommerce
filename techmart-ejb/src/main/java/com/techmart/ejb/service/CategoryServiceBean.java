package com.techmart.ejb.service;

import com.techmart.api.service.CategoryService;
import com.techmart.core.dto.CategoryDTO;
import com.techmart.core.entity.Category;
import com.techmart.core.mapper.CategoryMapper;
import com.techmart.ejb.repository.CategoryRepository;
import jakarta.ejb.EJB;
import jakarta.ejb.Stateless;
import jakarta.inject.Inject;

import java.util.ArrayList;
import java.util.List;

@Stateless
public class CategoryServiceBean
        implements CategoryService {

    @EJB
    private CategoryRepository repository;

    @Inject
    private CategoryMapper categoryMapper;

    @Override
    public List<CategoryDTO> findAll() {
        List<Category> categories = repository.findAll();
        List<CategoryDTO> dtos = new ArrayList<>();

        for (Category c : categories) {
            CategoryDTO dto = categoryMapper.toDTO(c);
            dtos.add(dto);
        }

        return dtos;
    }
}