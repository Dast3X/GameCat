package com.gamecatalog.spring.repos;

import com.gamecatalog.spring.models.Game;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDateTime;
import java.util.List;

// This interface is used to perform CRUD operations on Game objects
public interface GameRepository extends JpaRepository<Game, Long> {
    
    // find all games with title starting with given string and having given post date between given dates
    List<Game> findByTitleStartingWithIgnoreCaseAndPostDateBetween(
            String title,
            LocalDateTime startTime,
            LocalDateTime endTime);

    // find all games with title starting with given string and having given trailer url 
    List<Game> findByTitleStartingWithIgnoreCaseAndTrailerUrlIsNotNull(String title);

    // find all games with title starting with given string and not having given trailer url
    List<Game> findByTitleStartingWithIgnoreCaseAndTrailerUrlIsNull(String title);

    // find all games with title starting with given string
    List<Game> findByTitleStartingWithIgnoreCase(String filter);

    /*   
        find all games with title starting with given string and having given post date between given dates and having 
        given trailer url
    */
    List<Game> findByTitleStartingWithIgnoreCaseAndTrailerUrlIsNotNullAndPostDateBetween(
            String title,
            LocalDateTime startTime,
            LocalDateTime endTime);

    /*    
        find all games with title starting with given string and having given post date between given dates and not 
        having given trailer url
    */
    List<Game> findByTitleStartingWithIgnoreCaseAndTrailerUrlIsNullAndPostDateBetween(
            String title,
            LocalDateTime startTime,
            LocalDateTime endTime);
}
