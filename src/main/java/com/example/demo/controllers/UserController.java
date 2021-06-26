package com.example.demo.controllers;

import com.example.demo.exception.UserAlreadyRegisteredException;
import com.example.demo.form.LoginForm;
import com.example.demo.form.RegisterForm;
import com.example.demo.services.UserService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindException;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/users")
@AllArgsConstructor
public class UserController {
    private final UserService userService;

    @GetMapping("/login")
    public String loginPage(@RequestParam(required = false, defaultValue = "false") Boolean error, Model model) {
        model.addAttribute("error", error);
        model.addAttribute("form", new LoginForm());
        return "login";
    }

    @GetMapping("/registration")
    public String addUser(Model model) {
        if (!model.containsAttribute("form")) {
            model.addAttribute("form", new RegisterForm());
        }
        return "register";
    }

    @PostMapping("/registration")
    public String registerUser(@Validated RegisterForm form, BindingResult bindingResult) throws BindException {
        if (bindingResult.hasFieldErrors()) {
            throw new BindException(bindingResult);
        }
        if (userService.getUserByEmail(form.getEmail()).isPresent()) {
            throw new UserAlreadyRegisteredException();
        }
        userService.registerUser(form);
        return "redirect:/users/login";
    }
}
