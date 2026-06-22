package com.techmart.core.enums;

public enum UserStatusType {
    ACTIVE(1L),
    INACTIVE(2L),
    VERIFIED(3L),
    UNVERIFIED(4L);

    private final Long id;

    UserStatusType(Long id) {
        this.id = id;
    }

    public Long getId() {
        return this.id;
    }
}