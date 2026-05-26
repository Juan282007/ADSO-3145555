1. all project

## Estructura

AllProject/
│
├── Entity/
│   ├── Security/
│   └── Inventory/
│
├── IRepository/
│   ├── Security/
│   └── Inventory/
│
├── IService/
│   ├── Security/
│   └── Inventory/
│
├── Service/
│   ├── Security/
│   └── Inventory/
│
├── Controller/
│   ├── Security/
│   └── Inventory/
│
├── DTO/
│   ├── Security/
│   └── Inventory/
│
├── IDTO/
│   ├── Security/
│   └── Inventory/
│
└── Utils/
    ├── JWT/
    └── ProcessSchedule/

## How All Project Structure Works

This architecture works by separating the system into layers. Each layer has a specific responsibility and communicates with the next one.

# Entity

Stores the main models of the system.

It represents database tables.

Example:

User
Product
Role

Function:
It defines the structure of the data used in the project.

# IRepository

Contains repository interfaces.

Function:
It defines database operations such as:

save()
findById()
delete()
update()

It acts as the connection between the system and the database.

# IService

Contains service interfaces.

Function:
It defines what business operations the system can perform.

Example:

createUser()
getProducts()
updateStock()

It works as a contract for the service layer.

4. Service

Contains the implementation of business logic.

Function:
This is where the main processing happens:

validations
calculations
business rules
data processing

It receives data from Controller and communicates with Repository.

# Controller

Handles requests from the frontend or API.

Function:
It receives user actions like:

GET
POST
PUT
DELETE

Then sends data to Service and returns a response.

It works as the entry point of the system.

# DTO

Data Transfer Object.

Function:
It transfers only necessary data between layers.

Example:
A User entity may contain password, but DTO only sends:

name
email

This improves security and organization.

# IDTO

Contains interfaces related to DTO transformation.

Function:
It defines how entities are converted into DTOs.

It helps keep data transformation organized.

# Utils

Contains reusable utilities.

Examples:

JWT → authentication and token validation
ProcessSchedule → scheduled tasks
helpers
common methods

Function:
Supports the system with reusable tools.