package com.gamecatalog.spring.repos;

import com.gamecatalog.spring.models.Comment;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

// This interface is used to perform CRUD operations on Comment objects
public interface CommentRepository extends JpaRepository<Comment, Long> {

    // find all comments by game id
    List<Comment> findAllByGameId(Long id);
}
