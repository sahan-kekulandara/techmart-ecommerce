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
import java.util.stream.Collectors;

@Stateless
public class CategoryServiceBean
        implements CategoryService {

    @EJB
    private CategoryRepository repository;

    @Inject
    private CategoryMapper categoryMapper;

    @Override
    public List<CategoryDTO> findAll() {
        return repository.findAll()
                .stream()
                .map(categoryMapper::toDTO).collect(Collectors.toList());
    }
}