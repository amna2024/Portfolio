package com.example.todo_application.services;
import com.example.todo_application.model.User;
import com.example.todo_application.repositories.UserRepository;

import org.springframework.stereotype.Service;

@Service
public class UserService {

    private final UserRepository repository;


    public UserService(UserRepository repository) {
        this.repository = repository;
    }


    public void createUser(User user) {
        repository.save(user);
    }

    public Iterable<User> readAll() {
        var users = repository.findAll();
        return users;
    }


    public void updateUser(User user) {
        // Logic to update a user
    }

    public void deletebyUser(String user) {
        // Logic to delete a user by identifier
    }
}
