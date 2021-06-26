package com.example.demo.controllers;

import com.example.demo.models.Place;
import com.example.demo.models.User;
import com.example.demo.repos.PlaceImageRepo;
import com.example.demo.services.PlaceService;
import com.example.demo.services.ReviewService;
import com.example.demo.services.UserService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.security.Principal;
import java.util.Optional;

@Controller
@RequestMapping("/reviews")
@AllArgsConstructor
public class ReviewController {
    private final ReviewService reviewService;
    private final PlaceService placeService;
    private final UserService userService;
    private final PlaceImageRepo placeImageRepo;

    @PostMapping("/add")
    public String addReview(@RequestParam Long placeId, String description, Integer stars, Principal principal, Model model) {
        Optional<User> user = userService.getUserByEmail(principal.getName());
        if (user.isPresent()) {
            model.addAttribute("user", user.get());
        } else {
            model.addAttribute("user", null);
        }
        Place place = placeService.getById(placeId);
        reviewService.saveReview(place, description, stars, user.get());
        placeService.updateRating(place);
        model.addAttribute("photos", placeImageRepo.findAllByPlace(placeService.getById(placeId)));
        model.addAttribute("place", place);
        model.addAttribute("reviews", reviewService.getReviewByPlace(placeService.getById(placeId)));
        return "precisePage";
    }
}
