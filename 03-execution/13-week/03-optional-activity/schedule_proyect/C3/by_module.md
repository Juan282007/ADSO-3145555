2. By module 

## Estructura

ByModule
│
├── Security
│   ├── Entity
│   ├── IRepository
│   ├── IService
│   ├── Service
│   ├── Controller
│   ├── DTO
│   ├── IDTO
│   └── Utils
│       └── JWT
│
├── Inventory
│   ├── Entity
│   ├── IRepository
│   ├── IService
│   ├── Service
│   ├── Controller
│   ├── DTO
│   ├── IDTO
│   └── Utils
│       └── ProcessInventory
│
├── Schedule
│   ├── Entity
│   ├── IRepository
│   ├── IService
│   ├── Service
│   ├── Controller
│   ├── DTO
│   ├── IDTO
│   └── Utils
│       └── ConflictValidator
│
└── Observation
    ├── Entity
    ├── IRepository
    ├── IService
    ├── Service
    ├── Controller
    ├── DTO
    └── IDTO

## How By Module Structure Works

This architecture organizes the project by modules.
Each module is independent and contains its own layers.

Instead of grouping by type (all Controllers together, all Services together), it groups by business functionality.

# Security Module

Handles authentication and access control.

Contains:

Entity
Repository
Service
Controller
DTO
Utils

Function:
Manages:

users
roles
permissions
login
JWT authentication

It works independently from other modules.

# Inventory Module

Handles product and stock management.

Contains:

Entity
Repository
Service
Controller
DTO
Utils

Function:
Manages:

products
stock
inventory movement
updates
availability

Everything related to inventory stays inside this module.

# Schedule Module

Handles scheduling logic.

Contains:

Entity
Repository
Service
Controller
DTO
Utils

Function:
Manages:

schedules
time slots
availability
validations
conflict checking

Example:
ConflictValidator checks if two schedules overlap.

# Observation Module

Handles notes or observations.

Contains:

Entity
Repository
Service
Controller
DTO

Function:
Manages:

comments
reports
observations
records
tracking information

This module stores and processes related data separately.

# How Each Module Works Internally

Every module has the same internal structure:

Entity

Defines database models.

Example:

User
Product
Schedule
IRepository

Defines database operations.

Examples:

save()
findAll()
delete()
IService

Defines business contracts.

Examples:

createUser()
updateStock()
validateSchedule()
Service

Contains business logic.

Handles:

validations
calculations
processing
business rules
Controller

Receives requests from frontend or API.

Examples:

GET
POST
PUT
DELETE

Then calls Service.

# DTO

Transfers only necessary data.

Helps keep responses clean and secure.

# IDTO

Defines DTO conversion rules.

Helps transform Entities into DTOs.

# Utils

Stores reusable tools specific to the module.

Examples:

JWT
ProcessInventory
ConflictValidator