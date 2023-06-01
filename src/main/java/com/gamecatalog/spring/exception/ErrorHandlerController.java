package com.gamecatalog.spring.exception;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.RequestMapping;

public class ErrorHandlerController implements ErrorController {

    // Handle error requests (404, 403, etc.) and redirect to error page
    @RequestMapping("/error")
    public String handleError(HttpServletRequest request) {
        // Get error status code from request object
        Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
        if (status != null) {
            // Convert status code to integer and check if it's 403
            int statusCode = Integer.parseInt(status.toString());
            if (statusCode == HttpStatus.FORBIDDEN.value()) {
                return "error";
            }
        }
        return "error";
    }

}
