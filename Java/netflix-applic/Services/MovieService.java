package com.example.todo_application.services;
import com.example.todo_application.model.Movie;
import com.example.todo_application.repositories.MovieRepository;
import org.springframework.stereotype.Service;

@Service
public class MovieService {

    private final MovieRepository repository;

    public MovieService(MovieRepository repository) {
        this.repository = repository;
    }

    public void createMovie(Movie movie) {
        repository.save(movie);  // Save the movie entity to the database
    }

    public Iterable<Movie> readAll() {
        return repository.findAll();  // Retrieve all movies
    }

    public void updateMovie(Movie movie) {
        // Check if the movie exists before updating
        if (repository.existsById(movie.getId())) {
            repository.save(movie);  // Save will update the movie if it exists
        }
    }

    public void deleteMovie(String id) {
        if (repository.existsById(id)) {
            repository.deleteById(id);  // Delete the movie by its ID
        }
    }
}
