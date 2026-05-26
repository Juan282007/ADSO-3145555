# 3. MVC (Model View Controller)

## Estructura

MVC
│
├── Model
│
├── View
│
└── Controller



## Aplicación en el Sistema

Model
│
├── Horario
├── Instructor
└── Ambiente

View
│
├── Dashboard
└── SchedulerUI

Controller
│
└── HorarioController

## How MVC (Model View Controller) Works

MVC is an architecture that separates the system into three main layers.
Each layer has a specific responsibility.

This helps organize the project and makes maintenance easier.

MVC
│
├── Model
├── View
└── Controller

# Model

The Model handles the data and business logic of the system.

Function:
It stores and manages the main information.

Examples in the system:

Schedule (Horario)
Instructor
Environment (Ambiente)

It is responsible for:

storing data
validations
processing business rules
interacting with database

The Model does not manage user interface.

# View

The View handles the user interface.

Function:
It shows information to the user.

Examples in the system:

Dashboard
SchedulerUI

It is responsible for:

displaying data
showing forms
buttons
tables
user interaction interface

The View does not contain business logic.

# Controller

The Controller acts as the middle layer between Model and View.

Function:
It receives user actions and coordinates the system.

Example:

HorarioController

It is responsible for:

receiving requests
processing user actions
calling Model
sending results to View

It connects data and interface.

How MVC Works in the System
Model
Model
│
├── Schedule
├── Instructor
└── Environment

Stores and manages system data.

View
View
│
├── Dashboard
└── SchedulerUI

Displays system information.

Controller
Controller
│
└── ScheduleController

Handles requests and communication.