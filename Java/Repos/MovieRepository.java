package com.example.todo_application.repositories;

import com.example.todo_application.model.Movie;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;


@Repository
public interface MovieRepository extends CrudRepository<Movie, String> {
}

