package com.example.demo.services;

import com.example.demo.form.PlaceForm;
import com.example.demo.models.Place;
import com.example.demo.models.PlaceImage;
import com.example.demo.repos.PlaceImageRepo;
import com.example.demo.repos.PlaceRepo;
import com.example.demo.repos.ReviewRepo;
import lombok.AllArgsConstructor;
import lombok.SneakyThrows;
import org.apache.tomcat.util.codec.binary.Base64;
import org.bson.types.Binary;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.List;

@Service
@AllArgsConstructor
public class PlaceService {
    private final PlaceRepo placeRepo;
    private final PlaceImageRepo placeImageRepo;
    private final ReviewRepo reviewRepo;

    public List<Place> allPlaces() {
        return placeRepo.findAll();
    }

    public void savePlace(PlaceForm placeForm, MultipartFile photo) {
        Place place = Place.builder()
                .name(placeForm.getName())
                .description(placeForm.getDescription())
                .build();
        getImage(photo, place);
        placeRepo.save(place);
    }

    public void updateRating(Place place) {
        int sum = 0;
        for (int i = 0; i < reviewRepo.findAllByPlace(place).size(); i++) {
            sum += reviewRepo.findAllByPlace(place).get(i).getStars();
        }
        place.setTotalRating((double) sum / reviewRepo.findAllByPlace(place).size());
        placeRepo.save(place);
    }

    public Place getById(Long id) {
        return placeRepo.findById(id).get();
    }

    @SneakyThrows
    public void getImage(MultipartFile file, Place place) {
        byte[] data = new byte[0];
        try {
            data = file.getBytes();
        } catch (IOException e) {
            e.printStackTrace();
        }
        if (data.length == 0) {
            throw new IllegalArgumentException();
        }
        Binary bData = new Binary(data);
        byte[] encodedImage = Base64.encodeBase64(bData.getData());
        String base64 = new String(encodedImage, StandardCharsets.UTF_8);

        PlaceImage image = PlaceImage.builder()
                .imageEncoded64(base64)
                .place(place)
                .build();

        placeImageRepo.save(image);
    }
}
