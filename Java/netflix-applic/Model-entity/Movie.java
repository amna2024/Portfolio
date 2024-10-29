package com.example.todo_application.model;

import jakarta.persistence.*; // Import JPA annotations

@Entity // Indicates that this class is an entity
public class Movie {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID) // Use UUID as the primary key
    private String id;

    private String title; // Movie title
    private String genre; // Movie genre
    private int releaseYear; // Year of release

    // Default constructor
    public Movie() {
    }

    // Getters and Setters
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    public int getReleaseYear() {
        return releaseYear;
    }

    public void setReleaseYear(int releaseYear) {
        this.releaseYear = releaseYear;
    }
}
