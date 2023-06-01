package com.gamecatalog.spring.controller;

import com.gamecatalog.spring.models.Comment;
import com.gamecatalog.spring.models.Game;
import com.gamecatalog.spring.models.User;
import com.gamecatalog.spring.repos.CommentRepository;
import com.gamecatalog.spring.repos.GameRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Comparator;
import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/game")
public class GameController {
    private final GameRepository gameRepository;
    private final CommentRepository commentRepository;

    /* Show add game form */
    @GetMapping("/add")
    public String showAddForm() {
        return "game-add";
    }

    /* Save game into DB */
    @PostMapping("/add")
    public String createGame(
            @AuthenticationPrincipal User user,
            @ModelAttribute("game") Game game) {
        if (game.getTrailerUrl().equals(""))
            game.setTrailerUrl(null);
        game.setUser(user);
        gameRepository.save(game);
        return "redirect:/";
    }

    /* Get info of certain game */
    @GetMapping("/info/{id}")
    public String infoGame(
            @PathVariable("id") String id,
            Model model) {
        Long gameId;
        try {
            gameId = Long.parseLong(id);
        } catch (NumberFormatException e) {
            return "redirect:/";
        }

        Game game = gameRepository.findById(gameId).orElse(null);
        if (game == null) {
            return "redirect:/";
        }
        List<Comment> comments = commentRepository.findAllByGameId(gameId);
        comments.sort(Comparator.comparing(Comment::getPostDate).reversed());
        model.addAttribute("comments", comments);
        model.addAttribute("game", game);
        return "game-info";
    }

    /* Delete game from DB*/
    @PostMapping("/delete/{id}")
    public String deleteGame(@PathVariable Long id) {
        gameRepository.deleteById(id);
        return "redirect:/";
    }

    @GetMapping("/edit/{id}")
    public String editGame(@PathVariable Long id,
                           Model model) {
        Game game = gameRepository.findById(id).orElse(null);
        model.addAttribute("game", game);
        return "game-edit";
    }

    @PostMapping("/edit/{id}")
    public String updateGame(@PathVariable Long id,
                             @ModelAttribute("game") Game updated) {
        Game old = gameRepository.findById(id).orElse(null);
        assert old != null;
        updated.setUser(old.getUser());
        updated.setPostDate(old.getPostDate());
        gameRepository.save(updated);
        return "redirect:/game/info/" + id;
    }

}
