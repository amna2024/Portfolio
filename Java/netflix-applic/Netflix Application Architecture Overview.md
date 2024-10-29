# Netflix Application Architecture Overview

This architecture demonstrates how data flows through each layer of the application. The system is divided into distinct layers: client, controller, service, repository, and database, which together ensure efficient data handling and separation of concerns.

---

## Diagram Layout

### Frontend / Client

- **Purpose:** Displays the user interface and facilitates testing (e.g., via Postman).
- **Interaction:** Initiates requests for creating, retrieving, updating, and deleting movie and user data.

### Controller Layer (MovieController and UserController)

- **Purpose:** Acts as the entry point for HTTP requests from the client.
- **Interaction:**
  - Receives data from the client.
  - Passes data to the service layer for business logic processing.
  - Returns responses back to the client.
- **Example:** Handles a `POST /api/movies` request to create a new movie entry via `MovieController`.

### Service Layer (MovieService and UserService)

- **Purpose:** Manages business logic and coordinates data handling.
- **Interaction:**
  - Receives data from the controller.
  - Applies business rules and data validation.
  - Communicates with the repository layer to perform database operations.
- **Example:** `MovieService` processes movie creation logic before passing it to `MovieRepository` for database storage.

### Repository Layer (MovieRepository and UserRepository)

- **Purpose:** Interacts with the MySQL database to execute CRUD (Create, Read, Update, Delete) operations.
- **Interaction:**
  - Receives data requests from the service layer.
  - Executes database queries and returns the data to the service layer.
- **Example:** `UserRepository` retrieves all users upon a request from `UserService`.

### Database Layer (MySQL - Database name: `netflix`)

- **Purpose:** Stores `User` and `Movie` data within dedicated tables.
- **Interaction:**
  - Receives data for storage from repository queries.
  - Sends stored data back up through the repository, service, and controller layers to the client as needed.

---

This architecture ensures modularity, data integrity, and efficient handling of client requests across each layer, enhancing the application's maintainability and scalability.
