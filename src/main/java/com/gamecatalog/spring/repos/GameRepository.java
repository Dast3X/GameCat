package com.gamecatalog.spring.repos;

import com.gamecatalog.spring.models.Game;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDateTime;
import java.util.List;

public interface GameRepository extends JpaRepository<Game, Long> {
    List<Game> findByTitleStartingWithIgnoreCaseAndPostDateBetween(
            String title,
            LocalDateTime startTime,
            LocalDateTime endTime);

    List<Game> findByTitleStartingWithIgnoreCaseAndTrailerUrlIsNotNull(String title);

    List<Game> findByTitleStartingWithIgnoreCaseAndTrailerUrlIsNull(String title);

    List<Game> findByTitleStartingWithIgnoreCase(String filter);

    List<Game> findByTitleStartingWithIgnoreCaseAndTrailerUrlIsNotNullAndPostDateBetween(
            String title,
            LocalDateTime startTime,
            LocalDateTime endTime);

    List<Game> findByTitleStartingWithIgnoreCaseAndTrailerUrlIsNullAndPostDateBetween(
            String title,
            LocalDateTime startTime,
            LocalDateTime endTime);
}
