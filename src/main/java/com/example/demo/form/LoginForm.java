package com.example.demo.form;

import lombok.Data;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

@Data
public class LoginForm {
    @NotBlank
    @Email
    private String email;

    @Size(min = 4, max = 8, message = "Password should be from 4 to 8.")
    private String password;
}
