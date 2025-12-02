

| Sauce Screen | Recipe Screen |
|--------|---------|
| ![Screen Recording 2025-12-02 at 16 43 14](https://github.com/user-attachments/assets/56d7815c-3b09-4518-8316-e6ce6e0a35a0) | ![Screen Recording 2025-12-02 at 16 45 48](https://github.com/user-attachments/assets/0b266c63-f839-4e8a-a855-d9d7f766da38) |

# MiseTrack

A modern iOS application for managing sauce inventory and recipes, built with SwiftUI and Firebase.

## Overview

MiseTrack helps culinary professionals track sauce batches, manage recipes, and monitor inventory expiration. The app uses Firebase for backend services and implements a clean, modular architecture designed for testability and maintainability.

## Architecture

### Modular Package Structure

The project is organized into local Swift packages with clear separation of concerns:

```
Packages/
├── Base/
│   └── Models/              # Domain entities (Sauce, Recipe, Ingredient)
├── Infrastructure/
│   ├── FirebaseServices/    # Firebase integration layer
│   ├── DataServices/        # Repository protocols and implementations
│   └── ConfigServices/      # Remote configuration management
└── Features/                # Feature services
    ├── RecipeServices/      
    ├── SauceServices/       
```

### Key Architectural Patterns

**Repository Pattern**: Data access is abstracted through protocol-based repositories, making it easy to swap implementations or add new data sources.

**Dependency Injection**: Services and dependencies are injected through a ServiceContainer, making the dependency graph explicit and testable.

**Protocol-Oriented Design**: Core services are defined as protocols (`SauceRepositoryProtocol`, `ConfigProviderProtocol`), allowing for easy mocking in tests and future implementation swaps.

**MVVM with SwiftUI**: ViewModels marked with `@MainActor` handle business logic and state, while Views remain purely presentational.

## Implemented Features

### ✅ Sauce Management
- [x] View list of all sauce batches
- [x] Create new sauce batches with recipe association
- [x] Track quantity and units (grams/milliliters)
- [x] Automatic expiration calculation based on batch date
- [x] Delete sauce batches
- [x] Visual indicators for expired sauces

### ✅ Recipe Management
- [x] Browse recipe catalog
- [x] View recipe details with ingredients and instructions
- [x] Create new recipes with multiple ingredients
- [x] Dynamic ingredient list management
- [x] Support for multi-line instructions
- [x] Edit existing recipes

### ✅ Technical Features
- [x] Offline-enabled architecture with Firestore persistence
- [x] Remote configuration management
- [ ] Comprehensive logging system using OSLog
- [x] Type-safe unit system preventing measurement errors
- [x] Async/await for modern concurrency
- [x] SwiftUI with NavigationStack for modern navigation patterns

### Requirements
Built with: 
 - Xcode 26.1
 - Swift 6
 - Firebase


### Active Development
This project is under active development. The architecture is stabilizing, but breaking changes may occur as we refine patterns and add features. The core data models and service layer are relatively stable, while UI and advanced features are evolving.


