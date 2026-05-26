# 1. Old Project Structure (Tradicional por Capas)

## Estructura

txt
AllProject
│
├── Entity
│   ├── atributos
│   ├── constructor
│   ├── Getter
│   ├── setter
│   ├── relaciones
│   ├── validaciones
│   └── overrides (toString, equals)
│
├── IRepository
│   ├── save()
│   ├── update()
│   ├── delete()
│   ├── findById()
│   ├── findAll()
│   ├── exists()
│   ├── pagination()
│   └── filters()
│
├── IService
│   ├── create()
│   ├── update()
│   ├── delete()
│   ├── getById()
│   ├── getAll()
│   ├── validations()
│   ├── businessRules()
│   └── transaction()
│
├── Service
│   ├── implement IRepository
│   ├── business logic
│   ├── validations
│   ├── exception handling
│   ├── mapper DTO <-> Entity
│   ├── transaction management
│   └── response handling
│
├── Controller
│   ├── endpoints
│   ├── request mapping
│   ├── response entity
│   ├── validations
│   ├── exception handling
│   ├── authentication
│   ├── authorization
│   └── swagger documentation
│
├── DTO
│   ├── atributos
│   ├── constructor
│   ├── Getter
│   ├── setter
│   ├── validations
│   ├── requestDTO
│   └── responseDTO
│
├── IDTO
│   ├── entityToDTO()
│   ├── dtoToEntity()
│   ├── mapper()
│   ├── projections()
│   └── customResponse()
│
└── Utils
    ├── JWT
    ├── Encrypt
    ├── Constants
    ├── Helpers
    ├── Validators
    ├── Exceptions
    ├── Messages
    ├── DateUtils
    ├── Pagination
    └── Logger

## Old Project Structure (Traditional Layered Architecture)

This structure organizes the application by technical layers, where each folder has a specific responsibility in the system. The request usually flows from the controller to the service, then to the repository, and finally to the database.

How it works

# Entity

Contains the core domain objects of the application.

Defines attributes and properties
Includes constructors, getters, and setters
Handles relationships between entities
Applies basic validations
Overrides methods like toString() and equals()

This layer represents the data model of the system.

# IRepository

Defines the data access contracts.

Save data
Update records
Delete records
Search by ID
Retrieve all records
Check existence
Pagination support
Filtering operations

It separates database access logic from business logic.

# IService

Contains the service contracts.

Create operations
Update operations
Delete operations
Get by ID
Get all records
Define validations
Business rules
Transaction definitions

This acts as the abstraction between controllers and service implementations.

# Service

Implements the business logic of the application.

Implements repository usage
Executes validations
Applies business rules
Handles exceptions
Maps DTO ↔ Entity
Manages transactions
Formats responses

This is where the main application behavior is executed.

# Controller

Acts as the entry point of the application.

Defines endpoints
Maps HTTP requests
Handles responses
Validates input data
Exception handling
Authentication
Authorization
Swagger/API documentation

Controllers connect external requests with internal services.

# DTO

Represents Data Transfer Objects.

Stores request and response data
Constructors
Getters and setters
Validations
RequestDTO
ResponseDTO

Used to transfer data safely between layers.

# IDTO

Contains mapping logic between entities and DTOs.

entityToDTO()
dtoToEntity()
Mapping functions
Projections
Custom responses

Helps separate transformation logic from business logic.

# Utils

Contains shared reusable utilities.

JWT
Encryption
Constants
Helpers
Validators
Exceptions
Messages
Date utilities
Pagination
Logger

These components support multiple layers of the system.