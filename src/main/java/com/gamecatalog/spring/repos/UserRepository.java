package com.gamecatalog.spring.repos;

import com.gamecatalog.spring.models.User;
import com.gamecatalog.spring.models.enums.Role;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Set;

public interface UserRepository extends JpaRepository<User, Long> {
    User findByUsername(String username);

    boolean existsByUsername(String username);

    boolean existsByEmail(String email);

    List<User> findByUsernameStartingWith(String username);

    List<User> findByUsernameStartingWithAndActive(String username, boolean active);

    List<User> findByUsernameStartingWithAndRolesContaining(String username, Role role);

    List<User> findByUsernameStartingWithAndRolesNotContains(String username, Role role);
}
