package com.gamecatalog.spring.models;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.*;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;


@Data
@NoArgsConstructor
@Entity
@Table(name = "games")
public class Game {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    private String title;
    @Column(name = "description1", columnDefinition = "text")
    private String description1;
    @Column(name = "description2", columnDefinition = "text")
    private String description2;
    private String trailerUrl;
    private String previewImageUrl;
    private String imageUrl2;
    private String imageUrl3;
    private LocalDateTime postDate;


    @OneToMany(mappedBy = "game", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Comment> comments;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    @PrePersist
    private void init() {
        postDate = LocalDateTime.now();
    }

    public String formatDate(String filter) {
        return postDate.format(DateTimeFormatter.ofPattern(filter));
    }

    public boolean hasTrailer() {
        return (trailerUrl != null);
    }

    public String getAuthor() {
        return user.getUsername();
    }

    public String getAuthorAvatar() {
        return user.getAvatar();
    }
}
