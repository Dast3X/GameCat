package com.gamecatalog.spring.controller;

import com.gamecatalog.spring.models.User;
import com.gamecatalog.spring.models.enums.Role;
import com.gamecatalog.spring.repos.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
@RequestMapping("/registration")
@RequiredArgsConstructor
public class RegistrationController {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    /* Show register form */
    @GetMapping
    public String registrationForm() {
        return "registration";
    }

    /* Register user in DB */
    @PostMapping
    public String registerUser(@RequestParam("username") String username,
                               @RequestParam("password") String password,
                               @RequestParam("email") String email,
                               Model model) {
        if (username.isEmpty() || password.isEmpty() || email.isEmpty()) {
            return "redirect:/registration";
        }
        if (userRepository.existsByUsername(username) && userRepository.existsByEmail(email)) {
            model.addAttribute("existsEmail", "Email " + email + " is taken");
            model.addAttribute("existsUsername", "Username " + username + " is taken");
            return "registration";
        }
        if (userRepository.existsByUsername(username)) {
            model.addAttribute("existsUsername", "Username " + username + " is taken");
            return "registration";
        }
        if (userRepository.existsByEmail(email)) {
            model.addAttribute("existsEmail", "Email " + email + " is taken");
            return "registration";
        }
        if (username.length() < 3 || username.length() > 20) {
            model.addAttribute("usernameLength", "Username must be between 3 and 20 characters");
            return "registration";
        }
        User user = new User();
        user.setUsername(username);
        user.setPassword(passwordEncoder.encode(password));
        user.setEmail(email);
        user.setActive(true);
        user.getRoles().add(Role.USER);
        userRepository.save(user);
        return "redirect:/login";
    }
}