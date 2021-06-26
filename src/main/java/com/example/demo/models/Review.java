package com.example.demo.models;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.time.LocalDate;

@Data
@Entity
@Table(name = "reviews")
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Review {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String reviewDescription;

    private double stars;

    @Builder.Default
    private LocalDate localDate = LocalDate.now();

    @ManyToOne
    private User user;

    @ManyToOne
    private Place place;
}
