package com.gamecatalog.spring.exception;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.view.RedirectView;

// This controller is used to redirect to main page when user tries to access non-existing page
@Controller
public class NotFoundController {

    // redirect to main page
    @RequestMapping("/**")
    public RedirectView redirectToMainPage() {
        return new RedirectView("/");
    }
}
