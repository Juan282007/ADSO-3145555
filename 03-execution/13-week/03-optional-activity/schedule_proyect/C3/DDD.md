4. DDD (Domain Driven Design)

## Estructura

DDD
│
├── Domain
│   ├── Entities
│   ├── ValueObjects
│   ├── Aggregates
│   ├── RepositoryInterfaces
│   └── DomainServices
│
├── Application
│   ├── UseCases
│   ├── DTOs
│   └── Interfaces
│
├── Infrastructure
│   ├── Persistence
│   ├── Security
│   ├── ExternalServices
│   └── Repositories
│
└── Presentation
    ├── Controllers
    └── Views

## How DDD (Domain Driven Design) Structure Works

DDD organizes the project around the business domain.
The main goal is to separate business rules from technical implementation.

It divides the system into layers.

# Domain

This is the core of the system.

It contains the main business logic and rules.

Entities

Represents main business objects.

Examples:

User
Product
Schedule

Function:
Stores identity and behavior of important objects.

ValueObjects

Objects without unique identity.

Examples:

Address
Price
Email

Function:
Stores values that describe entities.

They are usually immutable.

Aggregates

Groups related entities.

Function:
Controls consistency between related objects.

Example:
Order → OrderItems

It acts as a single business unit.

RepositoryInterfaces

Defines contracts for data access.

Examples:

save()
findById()
delete()

Function:
Keeps Domain independent from database implementation.

DomainServices

Contains business rules that do not belong to a single entity.

Function:
Handles complex domain logic.

Example:
Schedule conflict validation.

# Application

Manages application behavior.

It connects Domain with external layers.

UseCases

Defines system actions.

Examples:

CreateUser
RegisterProduct
AssignSchedule

Function:
Executes business operations.

It coordinates domain logic.

DTOs

Transfers data between layers.

Function:
Moves only required data.

Improves organization and security.

Interfaces

Defines communication contracts.

Function:
Allows Application layer to interact with Infrastructure or Presentation.

# Infrastructure

Handles technical implementation.

It supports Domain and Application.

Persistence

Manages database connection.

Function:
Stores and retrieves data.

Security

Handles authentication and authorization.

Examples:

JWT
login
token validation
ExternalServices

Connects with outside systems.

Examples:

Email API
Payment gateway
Notifications
Repositories

Implements RepositoryInterfaces.

Function:
Contains real database logic.

# Presentation

This is the user interaction layer.

Controllers

Receives requests.

Examples:

GET
POST
PUT
DELETE

Function:
Calls Application use cases.

Views

Displays data to the user.

Examples:

frontend screens
web pages
UI

Function:
Shows system output.