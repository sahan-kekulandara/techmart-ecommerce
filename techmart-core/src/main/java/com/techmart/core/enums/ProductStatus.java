package com.techmart.core.enums;

public enum ProductStatus {
    ACTIVE(1L),
    INACTIVE(2L),
    OUT_OF_STOCK(3L);

    private final Long id;

    ProductStatus(Long id){
        this.id = id;
    }

    public Long getId() {
        return this.id;
    }
}
