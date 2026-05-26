5. Evolución a Microservicios


txt
Monolithic Modular
│
├── Security
├── Schedule
├── Instructor
├── Environment
├── Observation
└── Reports


---

## Evolución a Microservicios

txt
Microservices
│
├── Auth Service
├── Schedule Service
├── Instructor Service
├── Environment Service
├── Observation Service
└── Report Service

## How Evolution to Microservices Works

This architecture starts as a Monolithic Modular System and later evolves into Microservices.

At first, all modules exist inside one single application.
Later, each module becomes an independent service.

# Monolithic Modular

In this structure, the system is one application, but divided into modules.

Monolithic Modular
│
├── Security
├── Schedule
├── Instructor
├── Environment
├── Observation
└── Reports
How it works

All modules are inside the same project.

Each module has its own responsibility.

Examples:

Security → authentication and users
Schedule → schedules and time management
Instructor → instructor data
Environment → rooms or workspaces
Observation → notes and tracking
Reports → analytics and reports

All modules share:

same codebase
same deployment
same database (usually)

Function:
Keeps the project organized while still running as one system.

# Evolution to Microservices

As the system grows, each module can become an independent service.

Microservices
│
├── Auth Service
├── Schedule Service
├── Instructor Service
├── Environment Service
├── Observation Service
└── Report Service
How it works

Each service becomes a separate application.

Every microservice has:

its own logic
its own database
its own deployment
its own API
independent scaling

Services communicate using APIs or messaging.

# Auth Service

Handles authentication and security.

Function:
Manages:

login
JWT
users
roles
permissions

Works independently from other services.

# Schedule Service

Handles scheduling.

Function:
Manages:

schedules
time slots
availability
validations

Can scale separately if scheduling traffic increases.

# Instructor Service

Handles instructor information.

Function:
Manages:

instructor profiles
assignments
availability
data updates

Independent from scheduling or reports.

# Environment Service

Handles physical spaces.

Function:
Manages:

classrooms
environments
rooms
capacities
availability

Useful for location/resource management.

# Observation Service

Handles observations and records.

Function:
Manages:

comments
logs
notes
follow-up records

Separated from core scheduling logic.

# Report Service

Handles reports and analytics.

Function:
Manages:

statistics
reports
exports
analysis

Can process heavy tasks without affecting other services.