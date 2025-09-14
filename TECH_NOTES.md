# TECH_NOTES.md

## Architecture Overview

This app is a cross-platform business contact manager built with Flutter.  
The structure is modular to keep things clean and easy to extend later on:

- **Models** → Data classes that describe business entities (e.g. `business_model.dart`).
- **Services** → Handle networking and local caching (`network_service.dart`, `cache_service.dart`).
- **Views** → Screens are grouped by feature (dashboard, details, etc.) so the project stays organized as it grows.
- **Widgets** → Reusable UI components (e.g. `card_widget.dart`) to avoid repeating the same UI code.

---

## Key Trade-offs

- **State Management** → Provider is already integrated, which keeps things simple and scalable for now. For even bigger apps, Riverpod or Bloc could be considered, but Provider fits the current scope well.
- **Local Caching** → SharedPreferences is being used to persist results locally. It works fine for basic key-value storage, but Hive would have been a stronger choice for handling structured JSON and offering better performance.
- **Error Handling** → Current error handling is lightweight. A production-grade version would include retries, logging, and more user-friendly messages.
- **Testing** → Only basic widget tests are included at the moment. Adding more unit and integration tests would improve confidence in the codebase.

---

## If There Was More Time

- **Persistence** → Replace SharedPreferences with Hive for richer JSON storage and more robust offline support.
- **UI/UX Polish** → Add loading states, animations, and general design improvements.
- **Networking** → Improve error handling with retry logic and resilience for spotty connections.
- **Testing** → Broaden test coverage to include more scenarios and integration flows.
- **CI/CD** → Set up automated builds and test pipelines for smoother development.

---

These notes give a quick overview of how things are structured today, along with what could be added next.  
For details, check the codebase or reach out to the author.
