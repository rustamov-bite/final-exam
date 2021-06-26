package com.example.demo.controllers;

import com.example.demo.form.PlaceForm;
import com.example.demo.models.Place;
import com.example.demo.models.PlaceImage;
import com.example.demo.models.User;
import com.example.demo.repos.PlaceImageRepo;
import com.example.demo.services.PlaceService;
import com.example.demo.services.ReviewService;
import com.example.demo.services.UserService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.security.Principal;
import java.util.Optional;

@Controller
@AllArgsConstructor
public class PlaceController {
    private final PlaceService placeService;
    private final PlaceImageRepo placeImageRepo;
    private final UserService userService;
    private final ReviewService reviewService;

    @GetMapping("/")
    public String mainPage(Model model, Principal principal) {
        if (principal != null) {
            Optional<User> user = userService.getUserByEmail(principal.getName());
            model.addAttribute("user", user.get());
        }
        model.addAttribute("places", placeService.allPlaces());
        model.addAttribute("photos", placeImageRepo.findAll());
        return "mainPage";
    }

    @GetMapping("/places/precise")
    public String precisePage(@RequestParam Long id, Model model, Principal principal) {
        Optional<User> user = userService.getUserByEmail(principal.getName());
        if (user.isPresent()) {
            model.addAttribute("user", user.get());
        } else {
            model.addAttribute("user", null);
        }
        model.addAttribute("photos", placeImageRepo.findAllByPlace(placeService.getById(id)));
        model.addAttribute("place", placeService.getById(id));
        model.addAttribute("reviews", reviewService.getReviewByPlace(placeService.getById(id)));
        return "precisePage";
    }

    @GetMapping("/places/addNewPlace")
    public String addNewPlace(Model model, Principal principal) {
        Optional<User> user = userService.getUserByEmail(principal.getName());
        if (user.isPresent()) {
            model.addAttribute("user", user.get());
        } else {
            model.addAttribute("user", null);
        }
        model.addAttribute("placeForm", new PlaceForm());
        return "addPlace";
    }

    @PostMapping("/places/addNewPlace")
    public String addNewPlacePost(Model model, PlaceForm placeForm, @RequestPart("file") MultipartFile file) {
        placeService.savePlace(placeForm, file);
        model.addAttribute("places", placeService.allPlaces());
        model.addAttribute("photos", placeImageRepo.findAll());
        return "redirect:/";
    }

    @PostMapping("/places/uploadPhoto")
    public String uploadPhoto(@RequestParam Long id, @RequestPart("file") MultipartFile file) {
        Place place = placeService.getById(id);
        placeService.getImage(file, place);
        return "redirect:/";
    }
}
