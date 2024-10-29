# Netflix Application - Java Project Documentation

**Task:** Developed a Netflix-inspired application in Java using Spring Boot, with a MySQL database for user and movie management functionalities.  
**Details:** The application includes CRUD operations for managing **Users** and **Movies**, along with **DTOs** for data transfer, RESTful API endpoints, and a layered architecture consisting of **Entities**, **Repositories**, **Services**, **Controllers**, and **DTOs**. 

---

## Overview
The Netflix application project allows for the management of movies and users, enabling functionalities such as adding new movies, updating user details, and deleting records. 

## Project Architecture

### 1. Database - MySQL (Database Name: `netflix`)
   - **Tables:** 
     - **Users:** Contains information about Netflix users (username, email, etc.).
     - **Movies:** Contains information about available movies (title, genre, release year, etc.).

### 2. Entities
   - **User Entity:** Represents the `User` table with fields such as `username`, `email`, etc.
   - **Movie Entity:** Represents the `Movie` table with fields such as `title`, `genre`, and `release year`.

### 3. DTOs (Data Transfer Objects)
   - **UserDTO:** Simplified version of the User entity, tailored for transferring data to/from clients.
   - **MovieDTO:** Simplified version of the Movie entity for data transfer.

### 4. Repositories
   - **UserRepository:** Manages User CRUD operations with the database.
   - **MovieRepository:** Manages Movie CRUD operations with the database.

### 5. Services
   - **UserService:** Business logic for user-related operations (e.g., creating a user, updating details).
   - **MovieService:** Business logic for movie-related operations (e.g., adding a new movie, updating movie details).

### 6. Controllers
   - **UserController:** Defines RESTful endpoints for managing users.
     - **Endpoints:** 
       - `POST /api/users`: Create a new user.
       - `GET /api/users`: Retrieve all users.
       - `PUT /api/users/update`: Update a user's information.
       - `DELETE /api/users/delete/{username}`: Delete a user by username.
   - **MovieController:** Defines RESTful endpoints for managing movies.
     - **Endpoints:**
       - `POST /api/movies`: Add a new movie.
       - `GET /api/movies`: Retrieve all movies.
       - `PUT /api/movies/update`: Update movie details.
       - `DELETE /api/movies/delete/{id}`: Delete a movie by ID.

---

## Project Setup & Configuration

1. **Database Configuration**: 
   - Update `application.yml`:
     ```yaml
     spring:
       datasource:
         url: jdbc:mysql://localhost:3306/netflix
         username: root
         password: your_password
       jpa:
         hibernate:
           ddl-auto: update
         show-sql: true
       server:
         port: 8080
     ```

2. **Postman Testing**:
   - Use **JSON format** for requests.
   - Example request for creating a movie:
     ```json
     {
       "title": "Inception",
       "genre": "Sci-Fi",
       "releaseYear": 2010
     }
     ```

---

## Summary

This Netflix application uses a layered architecture with a structured approach to managing database operations for users and movies. The project demonstrates a strong grasp of Java Spring Boot, MySQL, and RESTful web services, with a focus on modular and reusable code practices.
