package com.gamecatalog.spring.models;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

// This class is used to represent Comment objects
@Data
@Entity
@NoArgsConstructor
@Table(name = "comments")
public class Comment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String text;
    private LocalDateTime postDate;

    // many comments can be posted on one game
    @ManyToOne
    @JoinColumn(name = "game_id")
    private Game game;

    // many comments can be posted by one user
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    // set post date before persisting comment
    @PrePersist
    private void init() {
        postDate = LocalDateTime.now();
    }

    // format post date
    public String formatDate(String format) {
        return postDate.format(DateTimeFormatter.ofPattern(format));
    }

    // get author username
    public String getAuthor() {
        return user.getUsername();
    }

    // get author avatar
    public String getAuthorAvatar() {
        return user.getAvatar();
    }
}
