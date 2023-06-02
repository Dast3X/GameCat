package com.gamecatalog.spring.models.enums;

import org.springframework.security.core.GrantedAuthority;

// This enum is used to define user roles
public enum Role implements GrantedAuthority {
    USER, ADMIN;

    // get authority of user role (USER or ADMIN) - used by Spring Security
    @Override
    public String getAuthority() {
        return name();
    }
}
