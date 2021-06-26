package com.example.demo.repos;

import com.example.demo.models.Place;
import com.example.demo.models.PlaceImage;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PlaceImageRepo extends JpaRepository<PlaceImage, Long> {
    List<PlaceImage> findAll();
    List<PlaceImage> findAllByPlace(Place place);
}
