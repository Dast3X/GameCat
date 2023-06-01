package com.gamecatalog.spring.exception;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.view.RedirectView;

@Controller
public class NotFoundController {

    @RequestMapping("/**")
    public RedirectView redirectToMainPage() {
        return new RedirectView("/");
    }
}