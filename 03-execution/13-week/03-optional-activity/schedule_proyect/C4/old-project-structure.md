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