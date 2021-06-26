package com.example.demo.models;

import lombok.*;

import javax.persistence.*;

@Data
@Entity
@Table(name = "place_images")
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class PlaceImage {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Lob
    private String imageEncoded64;

    @ManyToOne(cascade = CascadeType.ALL)
    private Place place;
}
