package com.gamecatalog.spring.controller;

import com.gamecatalog.spring.models.Comment;
import com.gamecatalog.spring.models.Game;
import com.gamecatalog.spring.models.User;
import com.gamecatalog.spring.repos.CommentRepository;
import com.gamecatalog.spring.repos.GameRepository;
import com.gamecatalog.spring.repos.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequiredArgsConstructor
public class CommentController {
    private final UserRepository userRepository;
    private final GameRepository gameRepository;
    private final CommentRepository commentRepository;

    /* Comment creation request handler */
    @PostMapping("/game/info/{id}")
    public String createComment(@PathVariable Long id,
                                @RequestParam("userId") Long userId,
                                @RequestParam("comment") String text) {
        if (text == null || text.isEmpty())
            return "redirect:/game/info/" + id;
        Game game = gameRepository.findById(id).orElse(null);
        User user = userRepository.findById(userId).orElse(null);
        Comment comment = new Comment();
        comment.setText(text);
        comment.setUser(user);
        comment.setGame(game);
        commentRepository.save(comment);
        return "redirect:/game/info/" + id;
    }

    /* Comment deletion request handler */
    @PostMapping("/comment/delete")
    public String deleteComment(@RequestParam("commentId") Long commentId,
                                @RequestParam("gameId") Long gameId) {
        commentRepository.deleteById(commentId);
        return "redirect:/game/info/" + gameId;
    }

    /* Comment edition request handler */
    @PostMapping("/comment/edit")
    public String editComment(@RequestParam("commentId") Long commentId,
                              @RequestParam("gameId") Long gameId,
                              @RequestParam("text") String text) {
        Comment comment = commentRepository.findById(commentId).orElse(null);
        if (comment == null || text.isEmpty() || text == null)
            return "redirect:/game/info/" + gameId;
        comment.setText(text);
        commentRepository.save(comment);
        return "redirect:/game/info/" + gameId;
    }

}










