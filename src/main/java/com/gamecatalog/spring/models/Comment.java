package com.gamecatalog.spring.models;

import jakarta.persistence.*;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

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

    @ManyToOne
    @JoinColumn(name = "game_id")
    private Game game;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    @PrePersist
    private void init() {
        postDate = LocalDateTime.now();
    }

    public String formatDate(String format) {
        return postDate.format(DateTimeFormatter.ofPattern(format));
    }

    public String getAuthor() {
        return user.getUsername();
    }

    public String getAuthorAvatar() {
        return user.getAvatar();
    }
}
