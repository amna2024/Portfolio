package com.example.todo_application.controllers;

import com.example.todo_application.dto.UserDTO;
import com.example.todo_application.model.User;
import com.example.todo_application.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.ArrayList;

@RestController
@RequestMapping("/api/users")
public class UserController {

    @Autowired
    private UserService service;

    @GetMapping
    public Iterable<UserDTO> getUsers() {
        var users = service.readAll();
        return convertToDTO(users);
    }

    @PostMapping
    public ResponseEntity<String> createUser(@RequestBody UserDTO userDTO) {
        try {

            User user = convertToUser(userDTO);
            service.createUser(user);
            return new ResponseEntity<>("User created", HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>("User cannot be created", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    } // <-- Added missing closing brace here

    @PutMapping("/update")
    public ResponseEntity<String> updateUser(@RequestBody UserDTO userDTO) { // <-- Removed the semicolon after updateUser
        try {
            User user = convertToUser(userDTO);
            service.updateUser(user);
            return new ResponseEntity<>("User was updated!", HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>("User could not be updated!", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @DeleteMapping("/delete/{user}")
    public ResponseEntity<String> deletebyUser(@PathVariable String user) { // <-- Removed the semicolon after deletebyUser
        try {
            service.deletebyUser(user);
            return new ResponseEntity<>("User deleted!", HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>("There was an error", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // Conversion methods
    private User convertToUser(UserDTO userDTO) {
        User user = new User();
        user.setId(userDTO.getId()); // Map fields from DTO to Entity
        user.setName(userDTO.getName());
        user.setPassword(userDTO.getPassword());
        return user;
    }

    private List<UserDTO> convertToDTO(Iterable<User> users) {
        List<UserDTO> userDTOs = new ArrayList<>();
        for (User user : users) {
            UserDTO userDTO = new UserDTO();
            userDTO.setId(user.getId()); // Map fields from Entity to DTO
            userDTO.setName(user.getName());
            userDTO.setPassword(user.getPassword());
            userDTOs.add(userDTO);
        }
        return userDTOs;
    }
}
