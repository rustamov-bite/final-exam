package com.example.demo.services;

import com.example.demo.configs.SecurityConfig;
import com.example.demo.form.RegisterForm;
import com.example.demo.models.User;
import com.example.demo.repos.UserRepo;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@AllArgsConstructor
public class UserService {
    private final UserRepo userRepo;

    public void registerUser(RegisterForm registerForm) {
        User user = User.builder()
                .email(registerForm.getEmail())
                .name(registerForm.getName())
                .password(SecurityConfig.encoder().encode(registerForm.getPassword()))
                .build();
        userRepo.save(user);
    }

    public Optional<User> getUserByEmail(String email) {
        return userRepo.findUserByEmail(email);
    }
}
