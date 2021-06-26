package com.example.demo.form;

import lombok.Data;
import javax.validation.constraints.NotBlank;

@Data
public class PlaceForm {
    @NotBlank
    private String name;

    @NotBlank
    private String description = "";
}
