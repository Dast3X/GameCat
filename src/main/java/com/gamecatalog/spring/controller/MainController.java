package com.gamecatalog.spring.controller;

import com.gamecatalog.spring.models.Game;
import com.gamecatalog.spring.repos.GameRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.DayOfWeek;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;


@RequiredArgsConstructor
@Controller
public class MainController {
    private final GameRepository gameRepository;

    /* Main page */
    @GetMapping("/")
    public String listGames(Model model) {

        model.addAttribute("sortedAlphaAsc", "none");
        model.addAttribute("sortedDateAsc", "none");
        model.addAttribute("games", gameRepository.findAll());
        return "main";
    }

    /* Filter by surname starting with method */
    @GetMapping("/filter")
    public String findGame(
            @RequestParam(required = false) String filter,
            @RequestParam(required = false) Boolean filterHasTrailer,
            @RequestParam(required = false) String filterTime,
            Model model) {

        List<Game> games;

        /* filter by filterHasTrailer, filterTime, filter */
        if (!filterTime.isEmpty()) {
            LocalDateTime startTime;
            LocalDateTime endTime = LocalDateTime.now();

            startTime = switch (filterTime) {
                case "Last Hour" -> endTime.minusHours(1);
                case "Today" -> endTime.with(LocalTime.MIN);
                case "This Week" -> endTime.with(DayOfWeek.MONDAY).with(LocalTime.MIN);
                case "This Month" -> endTime.withDayOfMonth(1).with(LocalTime.MIN);
                case "This Year" -> endTime.withDayOfYear(1).with(LocalTime.MIN);
                default -> null;
            };

            if (filterHasTrailer != null) {
                if (filterHasTrailer)
                    games = gameRepository.findByTitleStartingWithIgnoreCaseAndTrailerUrlIsNotNullAndPostDateBetween(filter, startTime, endTime);
                else
                    games = gameRepository.findByTitleStartingWithIgnoreCaseAndTrailerUrlIsNullAndPostDateBetween(filter, startTime, endTime);
            } else {
                if (startTime != null)
                    games = gameRepository.findByTitleStartingWithIgnoreCaseAndPostDateBetween(filter, startTime, endTime);
                else
                    games = gameRepository.findAll();
            }
        } else if (filterHasTrailer != null) {
            if (filterHasTrailer)
                games = gameRepository.findByTitleStartingWithIgnoreCaseAndTrailerUrlIsNotNull(filter);
            else
                games = gameRepository.findByTitleStartingWithIgnoreCaseAndTrailerUrlIsNull(filter);
        } else
            games = gameRepository.findByTitleStartingWithIgnoreCase(filter);

        model.addAttribute("filterHasTrailerMemorize", String.valueOf(filterHasTrailer));
        model.addAttribute("filterTimeMemorize", filterTime);
        model.addAttribute("games", games);
        model.addAttribute("filter", filter);
        return "main";
    }
}