package com.gamecatalog.spring.repos;

import com.gamecatalog.spring.models.User;
import com.gamecatalog.spring.models.enums.Role;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;


// This interface is used to perform CRUD operations on User objects
public interface UserRepository extends JpaRepository<User, Long> {
    User findByUsername(String username);

    // check if user with given username exists
    boolean existsByUsername(String username);

    // check if user with given email exists
    boolean existsByEmail(String email);

    // find all users with username starting with given string
    List<User> findByUsernameStartingWith(String username);

    // find all users with username starting with given string and having given roles and active status 
    List<User> findByUsernameStartingWithAndActive(String username, boolean active);

    // find all users with username starting with given string and having given role
    List<User> findByUsernameStartingWithAndRolesContaining(String username, Role role);

    // find all users with username starting with given string and not having given role 
    List<User> findByUsernameStartingWithAndRolesNotContains(String username, Role role);
}
