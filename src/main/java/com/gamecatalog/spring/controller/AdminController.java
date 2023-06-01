package com.gamecatalog.spring.controller;

import com.gamecatalog.spring.models.User;
import com.gamecatalog.spring.models.enums.Role;
import com.gamecatalog.spring.repos.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Sort;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


import java.util.List;

@Controller
@RequestMapping("/admin")
@RequiredArgsConstructor
public class AdminController {
    private final UserRepository userRepository;

    /* Find user by username */
    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("/users/filter")
    public String findUser(
            @RequestParam(required = false) String filterBan,
            @RequestParam(required = false) String filterRole,
            @RequestParam(required = false) String filter,
            Model model) {
        List<User> users;

        // Find all users starting with filter
        if (!filterBan.isEmpty() && !filterRole.isEmpty())
            users = userRepository.findByUsernameStartingWith(filter);
        // Find all users starting with filter and filterBan
        else if (!filterBan.isEmpty()) {
            if (filterBan.contains("true"))
                users = userRepository.findByUsernameStartingWithAndActive(filter, false);
            else
                users = userRepository.findByUsernameStartingWithAndActive(filter, true);
        }
        // Find all users starting with filter and filterRole
        else if (!filterRole.isEmpty()) {
            if (filterRole.contains("ADMIN"))
                users = userRepository.findByUsernameStartingWithAndRolesContaining(filter, Role.ADMIN);
            else
                users = userRepository.findByUsernameStartingWithAndRolesNotContains(filter, Role.ADMIN);
        } else
            users = userRepository.findByUsernameStartingWith(filter);

        // Sort by date/alphabet asc by default to none
        model.addAttribute("sortedDateAsc", "none");
        model.addAttribute("sortedAlphaAsc", "none");

        // Memorize filterRole and filterBan
        model.addAttribute("filterRoleMemorize", filterRole);
        model.addAttribute("filterBanMemorize", filterBan);
        model.addAttribute("users", users);
        model.addAttribute("filter", filter);
        return "users-list";
    }

    /* List all user from DB*/
    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("/users")
    public String listUsers(Model model) {
        List<User> users = userRepository.findAll();

        // Sort by date/alphabet asc by default to none on first load of page (no sort param)
        model.addAttribute("sortedDateAsc", "none");
        model.addAttribute("sortedAlphaAsc", "none");
        model.addAttribute("users", users);
        return "users-list";
    }

    /* Delete user from DB */
    @PreAuthorize("hasAuthority('ADMIN')")
    @PostMapping("/users/delete")
    public String deleteUser(@RequestParam("userId") Long id) {
        userRepository.deleteById(id);
        return "redirect:/admin/users";
    }

    /* Ban user */
    @PreAuthorize("hasAuthority('ADMIN')")
    @PostMapping("/users/ban")
    public String banUser(@RequestParam("userId") Long id) {

        User user = userRepository.findById(id).orElse(null);
        if (user != null) {
            user.setActive(false);
            userRepository.save(user);
        }
        return "redirect:/admin/users";
    }

    /* Unban user */
    @PreAuthorize("hasAuthority('ADMIN')")
    @PostMapping("/users/unban")
    public String unbanUser(@RequestParam("userId") Long id) {
        User user = userRepository.findById(id).orElse(null);
        if (user != null) {
            user.setActive(true);
            userRepository.save(user);
        }
        return "redirect:/admin/users";
    }

    /* Grant admin */
    @PreAuthorize("hasAuthority('ADMIN')")
    @PostMapping("/users/grantAdmin")
    public String grantAdmin(@RequestParam("userId") Long id) {
        User user = userRepository.findById(id).orElse(null);
        if (user != null) {
            user.getRoles().add(Role.ADMIN);
            userRepository.save(user);
        }
        return "redirect:/admin/users";
    }

    /* Revoke admin */
    @PreAuthorize("hasAuthority('ADMIN')")
    @PostMapping("/users/revokeAdmin")
    public String revokeAdmin(@RequestParam("userId") Long id) {
        User user = userRepository.findById(id).orElse(null);
        if (user != null) {
            user.getRoles().remove(Role.ADMIN);
            userRepository.save(user);
        }
        return "redirect:/admin/users";
    }

    /* Sort username by Alphabet ASC */
    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("/users/sortByAlphabetAsc")
    public String sortByAlphabetAsc(Model model) {
        List<User> users = userRepository.findAll(Sort.by(Sort.Direction.ASC, "username"));

        model.addAttribute("sortedDateAsc", "none");
        model.addAttribute("users", users);
        model.addAttribute("sortedAlphaAsc", "true");
        return "users-list";
    }

    /* Sort username by Alphabet DESC */
    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("/users/sortByAlphabetDesc")
    public String sortByAlphabetDesc(Model model) {
        List<User> users = userRepository.findAll(Sort.by(Sort.Direction.DESC, "username"));

        model.addAttribute("sortedDateAsc", "none");
        model.addAttribute("users", users);
        model.addAttribute("sortedAlphaAsc", "false");
        return "users-list";
    }

    /* Sort by Register Date ASC */
    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("/users/sortByDateAsc")
    public String sortByDateAsc(Model model) {
        List<User> users = userRepository.findAll(Sort.by(Sort.Direction.ASC, "registerDate"));

        model.addAttribute("sortedAlphaAsc", "none");
        model.addAttribute("users", users);
        model.addAttribute("sortedDateAsc", "true");
        return "users-list";
    }

    /* Sort by Register Date DESC */
    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("/users/sortByDateDesc")
    public String sortByDateDesc(Model model) {
        List<User> users = userRepository.findAll(Sort.by(Sort.Direction.DESC, "registerDate"));

        model.addAttribute("sortedAlphaAsc", "none");
        model.addAttribute("users", users);
        model.addAttribute("sortedDateAsc", "false");
        return "users-list";
    }


}
