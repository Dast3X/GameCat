package com.gamecatalog.spring.controller;

import com.gamecatalog.spring.models.User;
import com.gamecatalog.spring.repos.UserRepository;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
@RequestMapping("/user")
public class UserController {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    /* Show user profile */
    @GetMapping("/profile/{id}")
    public String showUserProfile(@PathVariable Long id,
                                  Model model) {
        User user = userRepository.findById(id).orElse(null);
        if (user == null) {
            return "redirect:/";
        }
        model.addAttribute("userInfo", user);
        return "profile-info";
    }

    /* Edit information about the user */
    @GetMapping("/edit/{id}")
    public String editUserProfileForm(@PathVariable Long id,
                                      Model model) {
        User user = userRepository.findById(id).orElse(null);
        if (user == null) {
            return "redirect:/";
        }
        model.addAttribute("userInfo", user);
        return "profile-edit";
    }

    /* Save changes in DB */
    @PostMapping("/edit/{id}")
    public String updateUserProfile(@PathVariable("id") Long id,
                                    @ModelAttribute("user") User updated,
                                    Model model) {
        User user = userRepository.findById(id).orElse(null);
        if (updated.getUsername().isEmpty()) {
            model.addAttribute("error", "Username cannot be empty");
            return "redirect:/user/edit/" + id;
        }

        // encode and set new password if it's not empty
        if (updated.getPassword() != null && !updated.getPassword().isEmpty()) {
            assert user != null;
            user.setPassword(passwordEncoder.encode(updated.getPassword()));
        }

        // update other fields
        assert user != null;
        user.setAvatar(updated.getAvatar());
        user.setUsername(updated.getUsername());
        user.setEmail(updated.getEmail());
        model.addAttribute("saved", "saved");
        userRepository.save(user);
        return "redirect:/user/profile/" + id;
    }

    /* Delete yourself from DB (Forced logout) */
    @GetMapping("/delete/{id}")
    public String deleteUser(@PathVariable("id") Long id, HttpServletRequest request, HttpServletResponse response) {
        userRepository.deleteById(id);

        // logout after deletion
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null) {
            new SecurityContextLogoutHandler().logout(request, response, auth);
        }

        return "redirect:/login?logout";
    }
}
