package com.gamecatalog.spring.models;

import com.gamecatalog.spring.models.enums.Role;
import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Collection;
import java.util.HashSet;
import java.util.List;
import java.util.Set;


// This class is used to represent User objects
@Data
@Entity
@NoArgsConstructor
@Table(name = "users")
public class User implements UserDetails {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    private String username;

    private String password;

    private String email;

    private boolean active;

    private String avatar;
    
    private LocalDateTime registerDate;
    
    // user can have up to 2 roles
    @ElementCollection(targetClass = Role.class, fetch = FetchType.EAGER)
    @CollectionTable(name = "user_role", joinColumns = @JoinColumn(name = "user_id"))
    @Enumerated(EnumType.STRING)
    private Set<Role> roles = new HashSet<>();

    // user can have many games
    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    private List<Game> games;

    // user can have many comments
    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    private List<Comment> comments;

    // check if user is admin
    public boolean isAdmin() {
        return roles.contains(Role.ADMIN);
    }
    
    // check if user is active (not banned)
    public boolean isActive() {
        return active;
    }

    // set register date before persisting user
    @PrePersist
    private void init() {
        registerDate = LocalDateTime.now();
    }

    // format date to string
    public String formatDate(String format) {
        return registerDate.format(DateTimeFormatter.ofPattern(format));
    }

    // security - get user roles
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return getRoles();
    }
    
    // security - user is not expired
    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    // security - user is not locked
    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    // security - credentials are not expired
    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    // security - user is enabled
    @Override
    public boolean isEnabled() {
        return active;
    }

}
