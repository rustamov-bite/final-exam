package com.example.demo.services;

import com.example.demo.models.Place;
import com.example.demo.models.Review;
import com.example.demo.models.User;
import com.example.demo.repos.ReviewRepo;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@AllArgsConstructor
public class ReviewService {
    private final ReviewRepo reviewRepo;

    public List<Review> getReviewByPlace(Place place) {
        return reviewRepo.findAllByPlace(place);
    }

    public void saveReview(Place place, String description, int stars, User user) {
        Review review = Review.builder()
                .user(user)
                .place(place)
                .reviewDescription(description)
                .stars(stars)
                .build();
        reviewRepo.save(review);
    }
}
