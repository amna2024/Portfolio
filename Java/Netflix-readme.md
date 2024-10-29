# Netflix To-Do Application

This project is a **RESTful To-Do Application** designed to manage Netflix users and movies they want to track. It follows a structured architecture using **Spring Boot**, **MySQL**, and **DTOs** to provide a clean and efficient API for CRUD operations on users and movies.

## Table of Contents
- [Project Goal](#project-goal)
- [Setup and Dependencies](#setup-and-dependencies)
- [Database Configuration](#database-configuration)
- [Entities](#entities)
- [DTOs](#dtos)
- [Repositories](#repositories)
- [Services](#services)
- [Controllers](#controllers)
- [Testing with Postman](#testing-with-postman)
- [Summary of Each Component](#summary-of-each-component)

---

### Project Goal
The objective is to create a **RESTful application** that allows clients to manage **Netflix users** and **movies** they want to track, using CRUD (Create, Read, Update, Delete) operations. This application will expose endpoints for easy data manipulation.

---

### Setup and Dependencies
1. Generate a new **Spring Boot** project.
2. Add the following dependencies in `pom.xml`:
   - **Spring Web** for RESTful APIs
   - **Spring Data JPA** for database interaction
   - **MySQL Driver** to connect to MySQL
   - **Lombok** for simplified getter/setter generation

---

### Database Configuration
To connect to a MySQL database named `netflix`, add the following properties in `application.yml` or `application.properties`:

```yaml
spring:
  datasource:
    url: jdbc:mysql://localhost:3306/netflix
    username: root
    password: password
  jpa:
    hibernate:
      ddl-auto: update
    show-sql: true
