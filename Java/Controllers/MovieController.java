package com.example.todo_application.controllers;

import com.example.todo_application.dto.MovieDTO;
import com.example.todo_application.services.MovieService; // Import the MovieService
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import com.example.todo_application.model.Movie;


@RestController
@RequestMapping("/api/movies") // Mapping for movie-related requests
public class MovieController {

    @Autowired
    private MovieService service; // Inject the MovieService

    @GetMapping
    public Iterable<Movie> getMovies() {

        return service.readAll(); // Retrieve all movies
    }

    @PostMapping
    public ResponseEntity<String> createMovie(@RequestBody MovieDTO movieDto) {
        try {

            Movie movie = movieDto;
            service.createMovie(movie); // Create a new movie
            return new ResponseEntity<>("Movie created", HttpStatus.OK); // Return 201 Created status
        } catch (Exception e) {
            return new ResponseEntity<>("Movie cannot be created", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PutMapping("/update")
    public ResponseEntity<String> updateMovie(@RequestBody MovieDTO movieDto) {
        try {
            Movie movie = movieDto;
            service.updateMovie(movie); // Update the movie
            return new ResponseEntity<>("Movie was updated!", HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>("Movie could not be updated!", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @DeleteMapping("/delete/{id}") // Using id for the path variable
    public ResponseEntity<String> deleteMovie(@PathVariable String id) {
        try {

            service.deleteMovie(id); // Delete the movie by ID
            return new ResponseEntity<>("Movie deleted!", HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>("There was an error", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
