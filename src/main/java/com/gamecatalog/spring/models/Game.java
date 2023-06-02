package com.gamecatalog.spring.models;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;


// This class is used to represent Game objects
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

    // one game can have many comments
    @OneToMany(mappedBy = "game", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Comment> comments;

    // many games can be posted by one user
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    // set register date before persisting game
    @PrePersist
    private void init() {
        postDate = LocalDateTime.now();
    }

    // format post date
    public String formatDate(String filter) {
        return postDate.format(DateTimeFormatter.ofPattern(filter));
    }

    // check if game has trailer
    public boolean hasTrailer() {
        return (trailerUrl != null);
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
