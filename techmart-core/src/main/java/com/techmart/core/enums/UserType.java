package com.techmart.core.enums;

public enum UserType {
    ADMIN(1L),
    USER(2L);

    private final Long id;

    UserType(Long id){
        this.id = id;
    }

    public Long getId() {
        return this.id;
    }
}
