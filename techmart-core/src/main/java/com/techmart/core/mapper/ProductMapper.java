package com.techmart.core.mapper;

import com.techmart.core.dto.ProductDTO;
import com.techmart.core.dto.ProductImageDTO;
import com.techmart.core.dto.ProductSuggestionDTO;
import com.techmart.core.entity.Product;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;

import java.util.List;

@ApplicationScoped
public class ProductMapper {

    @Inject
    private SubcategoryMapper subcategoryMapper;

    @Inject
    private ProductStatusMapper productStatusMapper;

    public ProductDTO toDTO(Product entity) {
        if (entity == null) {
            return null;
        }

        ProductDTO dto = new ProductDTO();
        dto.setId(entity.getId());
        dto.setTitle(entity.getTitle());
        dto.setDescription(entity.getDescription());
        dto.setPrice(entity.getPrice());
        dto.setQty(entity.getQty());
        dto.setCreatedAt(entity.getCreatedAt());

        if (entity.getSubcategory() != null) {
            dto.setSubcategory(subcategoryMapper.toDTO(entity.getSubcategory()));
        }

        if (entity.getProductStatus() != null) {
            dto.setProductStatus(productStatusMapper.toDTO(entity.getProductStatus()));
        }

        if (entity.getImages() != null && !entity.getImages().isEmpty()) {
            List<ProductImageDTO> imageDTOs = entity.getImages().stream()
                    .map(img -> ProductImageDTO.builder()
                            .id(img.getId().intValue())
                            .product(dto)
                            .imagePath(img.getImagePath())
                            .isPrimary(img.getIsPrimary())
                            .build())
                    .collect(java.util.stream.Collectors.toList());

            dto.setImages(imageDTOs);
        }

        return dto;
    }

    public Product toEntity(ProductDTO dto) {
        if (dto == null) {
            return null;
        }

        Product entity = new Product();
        entity.setId(dto.getId());
        entity.setTitle(dto.getTitle());
        entity.setDescription(dto.getDescription());
        entity.setPrice(dto.getPrice());
        entity.setQty(dto.getQty());
        entity.setCreatedAt(dto.getCreatedAt());

        if (dto.getSubcategory() != null) {
            entity.setSubcategory(subcategoryMapper.toEntity(dto.getSubcategory()));
        }

        if (dto.getProductStatus() != null) {
            entity.setProductStatus(productStatusMapper.toEntity(dto.getProductStatus()));
        }

        return entity;
    }

    public ProductSuggestionDTO toSuggestionDTO(Product product) {
        if (product == null) {
            return null;
        }

        String primaryImagePath = product.getImages().stream()
                .filter(img -> Boolean.TRUE.equals(img.getIsPrimary()))
                .map(img -> img.getImagePath())
                .findFirst()
                .orElse(product.getImages().isEmpty() ? null : product.getImages().get(0).getImagePath());

        return ProductSuggestionDTO.builder()
                .id(product.getId())
                .title(product.getTitle())
                .image(primaryImagePath)
                .build();
    }
}