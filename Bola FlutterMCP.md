# Bola FlutterMCP

## 1. 📁 `lib/` Directory Overview

| Folder                | Purpose & Patterns                                                                                  |
|-----------------------|----------------------------------------------------------------------------------------------------|
| `core/`               | Global app logic: providers, routing, error handling, config, extensions, and utilities.           |
| `data/`               | Data layer: models, remote/local datasources, repository implementations.                          |
| `domain/`             | Business logic: entities, usecases, repository interfaces.                                         |
| `gen/`                | Generated code/assets (e.g., fonts, assets).                                                       |
| `l10n/`               | Localization: ARB files and Dart localization setup.                                               |
| `bootstrap.dart`      | App initialization entrypoint.                                                                     |
| `main_*.dart`         | Environment-specific entrypoints (development, production, staging).                               |

**Key Patterns:**
- Strict separation of concerns between layers.
- Riverpod is used for state management and dependency injection.
- GoRouter is used for navigation.
- Constants, enums, and utility functions are centralized in `core/`.
- All features and shared logic are modularized for scalability.

---

## 2. ⚙️ Layer Responsibilities

### `core/`
- **Purpose:** Global, cross-cutting concerns and foundational app logic.
- **Contents:**  
  - `providers/`:  
    - Global providers for app state, loading, error, environment, etc.
    - Example: `core/providers/core_providers.dart` (contains providers like `storageProvider`, `environmentProvider`, `loadingProvider`, `errorProvider`, `appInitializedProvider`)
  - `router/`:  
    - App routing setup using GoRouter.
    - Route constants and route guards.
    - Example: `core/router/app_router.dart`, `core/router/route_constants.dart`
  - `config/`:  
    - App-wide constants, environment configs, interceptors.
    - Example: `core/config/constants.dart`
  - `error/`:  
    - Failure and error handling classes.
    - Example: `core/error/failure.dart`, `core/error/app_error.dart`
  - `utils/`:  
    - Shared utilities (themes, styles, validators, logger, enums).
    - Example: `core/utils/theme_utils.dart`, `core/utils/validators.dart`, `core/utils/logger.dart`, `core/utils/enums.dart`
  - `extensions/`:  
    - Extension methods for widgets, context, strings, etc.
    - Example: `core/extensions/context_extensions.dart`, `core/extensions/string_extensions.dart`

**Key Patterns:**  
- Centralize all global logic and utilities here.
- No business/domain logic or data layer code in `core/`.
- Use Riverpod for all global providers.
- GoRouter setup and navigation helpers live here.
- All constants, enums, and utility functions are placed in their respective subfolders.

---

### File & Folder Naming
- **Files:** `snake_case.dart`
- **Folders:** `snake_case/`
- **Classes:** `PascalCase`
- **Providers:** Suffix with `_provider.dart` (see `core/providers/` for global providers)
- **Entities/Models:** Suffix with `_entity.dart` / `_model.dart`
- **Repositories:**  
  - Interface: `i_{{feature}}_repository.dart`
  - Implementation: `{{feature}}_repository.dart` (data layer)
- **Usecases:** Suffix with `_usecase.dart`
- **Constants/Enums:** Suffix with `_constants.dart` / `_enums.dart` (see `core/config/` and `core/utils/`)
- **Router:** Place all routing logic and route constants in `core/router/`
- **Error Handling:** All errors/failures are defined in `core/error/`
- **Extensions:** In `core/extensions/`
- **Utilities:** In `core/utils/`

### Organization
- **Constants:** Centralized in `core/config/constants.dart`.
- **Extensions:** In `core/extensions/`.
- **Utilities:** In `core/utils/`.
- **Providers:** In `core/providers/` for global, or feature-specific in their respective modules.
- **Error Handling:** All errors/failures are defined in `core/error/`.
- **Routing:** All routing logic and route constants are in `core/router/`.

### `data/`
- **Purpose:** Handles all data operations and external communication.
- **Contents:**  
  - `models/`: Data models (DTOs) for API and storage.
  - `datasources/`:  
    - `remote/`: API clients, endpoints, remote data logic.
    - `local/`: Local storage helpers (e.g., secure storage).
  - `repositories/`: Concrete implementations of domain repository interfaces.

### `domain/`
- **Purpose:** Pure business logic, independent of frameworks.
- **Contents:**  
  - `entities/`: Core business entities (immutable, often using Freezed).
  - `usecases/`: Application-specific business logic (e.g., authentication flows).
  - `repositories/`: Abstract repository interfaces (contracts for data access).

### `gen/`
- **Purpose:** Generated code (e.g., asset and font references).

### `l10n/`
- **Purpose:** Localization support (ARB files, localization Dart code).

---

## 3. 🧠 State Management and Routing

### State Management
- **Library:** [Riverpod](https://riverpod.dev/)
- **Usage:**
  - All providers are defined using `Provider`, `StateProvider`, or custom Riverpod annotations.
  - Global providers (e.g., `storageProvider`, `environmentProvider`, `loadingProvider`, `errorProvider`, `appInitializedProvider`) are defined in `core/providers/core_providers.dart`.
  - Dependency injection is handled via Riverpod, including for repositories and usecases.

### Routing
- **Library:** [GoRouter](https://pub.dev/packages/go_router)
- **Setup:**
  - Centralized in `core/router/app_router.dart`.
  - All routes are defined as `GoRoute` objects, using constants from `route_constants.dart`.
  - Route guards and error handling are supported.
  - Navigation is performed using context extensions (`context.go`, `context.push`) and route constants.

---

## 4. 🧩 Presentation Layer

- Only shared widgets that are used across multiple features are included here.
- The `presentation/general_widget/` directory contains reusable UI components (e.g., buttons, dialogs, loaders, etc.) that are not feature-specific.
- All other presentation logic (screens, feature-specific widgets, providers) is excluded from this protocol.

**Example:**
### Template
```dart
// presentation/general_widget/custom_button.dart
class CustomButton extends StatelessWidget {
  // ...
}
```

### Template
```dart
// presentation/general_widget/loading_indicator.dart
class LoadingIndicator extends StatelessWidget {
  // ...
}
```

---

## 5. 📄 Code Style Guide

### Class & Method Conventions
- **Entities:** Immutable, use Freezed for data classes.
- **Models:** Extend Equatable for value comparison.
- **Repositories:**  
  - Domain layer: Abstract, no dependencies.
  - Data layer: Implements domain interface, depends on datasources.
- **Usecases:** Pure functions, no framework dependencies.
- **Providers:** Use Riverpod annotations for DI and state.

### Blueprint
```dart
// domain/entities/user_entity.dart
@freezed
class UserEntity with _$UserEntity {
  const factory UserEntity({
    required String id,
    required String email,
    required String name,
    String? photoUrl,
    @Default(false) bool isEmailVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _UserEntity;

  factory UserEntity.fromJson(Map<String, dynamic> json) => _$UserEntityFromJson(json);
}
```

### Template
```dart
// data/models/user_model.dart
class UserModel extends Equatable {
  const UserModel({required this.id, required this.name, required this.email});
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'] as String,
    name: json['name'] as String,
    email: json['email'] as String,
  );
  // ...
}
```

---

## 6. 🛠️ Tools & Packages

- **State Management:** Riverpod (`flutter_riverpod`, `riverpod_annotation`)
- **Routing:** GoRouter
- **Networking:** Dio
- **Immutability/Data Classes:** Freezed, Equatable
- **Local Storage:** Hive, Secure Storage
- **Code Generation:** build_runner, Freezed, Riverpod Generator

---

## 7. 🔗 Layer Relationships

- **Domain** depends only on itself (entities, usecases, repository interfaces).
- **Data** implements domain repositories, depends on external packages (Dio, Hive, etc.).
- **Core** provides global utilities, config, and app-wide providers.
- **Presentation** (excluded here) depends on domain and core, never directly on data.

---

**This protocol file should be referenced for all future code generation, feature scaffolding, and architectural decisions. All new code must adhere to these conventions and structure.**

---

## 8. 🧰 Utilities (`core/utils/`)

The `core/utils/` directory contains all shared utility functions, helpers, and stateless logic that are used throughout the app. Utilities are strictly non-feature-specific and should not depend on presentation, data, or domain layers.

**Typical Categories & Example Files:**
- **Theme & Style Helpers:**
  - `theme_utils.dart` (e.g., color schemes, text styles)
  - `spacing_utils.dart` (e.g., padding, margin constants)
- **Validation:**
  - `validators.dart` (e.g., email, password, phone validation)
- **Logging:**
  - `logger.dart` (centralized logging functions)
- **Enums & Mappers:**
  - `enums.dart` (shared enums)
  - `enum_mappers.dart` (enum-to-string, string-to-enum helpers)
- **Date & Time:**
  - `date_utils.dart` (formatting, parsing, difference calculations)
- **String & Number Helpers:**
  - `string_utils.dart` (case conversion, trimming, masking)
  - `number_utils.dart` (formatting, parsing, rounding)
- **Device & Platform:**
  - `device_utils.dart` (platform checks, device info)
- **Other Common Utilities:**
  - `debounce_throttle.dart` (debounce/throttle logic)
  - `collection_utils.dart` (list, map, set helpers)
  - `async_utils.dart` (delays, retries, futures)

**Guidelines:**
- Utilities must be stateless and reusable across the app.
- Do not import feature, data, or domain code in utils.
- Prefer pure functions and static helpers.
- Add new utility files as new cross-cutting needs arise.
- Keep utility files focused and well-documented.

**Reference:**
- All new shared logic that does not fit in providers, config, or error should be considered for `core/utils/`.
- See also the "File & Folder Naming" and "Organization" sections for naming conventions.

---

## 9. 🗂️ Providers (`core/providers/`)

The `core/providers/` directory contains all global Riverpod providers and dependency injection logic that is not feature-specific. Providers here manage app-wide state, environment, error, and loading logic.

**Typical Contents & Example Files:**
- `core_providers.dart` (main entry for global providers)
- `environment_provider.dart` (environment config provider)
- `loading_provider.dart` (global loading state)
- `error_provider.dart` (global error state)
- `app_initialized_provider.dart` (app bootstrapping state)

**Guidelines:**
- Use Riverpod for all providers.
- Only global, cross-cutting providers belong here; feature-specific providers go in their respective modules.
- Providers should be stateless or manage only global state.
- Keep provider files focused and well-documented.

---

## 10. 🧭 Router (`core/router/`)

The `core/router/` directory contains all navigation and routing logic for the app, using GoRouter. This includes route definitions, route constants, guards, and error handling for navigation.

**Typical Contents & Example Files:**
- `app_router.dart` (main GoRouter setup)
- `route_constants.dart` (all route names/paths)
- `route_guards.dart` (auth guards, etc.)
- `router_utils.dart` (navigation helpers)

**Guidelines:**
- All navigation logic and route definitions must be centralized here.
- Use constants for all route names/paths.
- Implement route guards for authentication, onboarding, etc.
- Use context extensions for navigation convenience.

---

## 11. ⚙️ Config (`core/config/`)

The `core/config/` directory contains all app-wide configuration, constants, and environment-specific settings.

**Typical Contents & Example Files:**
- `constants.dart` (app-wide constants)
- `env.dart` (environment variable access)
- `interceptors.dart` (Dio or HTTP interceptors)
- `flavor_config.dart` (flavor/environment setup)

**Guidelines:**
- Centralize all constants and config here.
- Do not place feature-specific config in this folder.
- Use strongly-typed classes for environment and flavor configs.

---

## 12. 🚨 Error Handling (`core/error/`)

The `core/error/` directory contains all error, failure, and exception classes used throughout the app. This ensures consistent error handling and messaging.

**Typical Contents & Example Files:**
- `failure.dart` (base failure class)
- `app_error.dart` (app-specific error types)
- `error_utils.dart` (error mapping, formatting)
- `network_exceptions.dart` (network error types)

**Guidelines:**
- All error/failure types must be defined here.
- Use sealed classes or enums for error categories.
- Provide utilities for mapping and displaying errors.

---

## 13. 🧩 Extensions (`core/extensions/`)

The `core/extensions/` directory contains extension methods for Dart and Flutter types, widgets, BuildContext, and more. These are used to add convenience methods and helpers throughout the app.

**Typical Contents & Example Files:**
- `context_extensions.dart` (navigation, theme, media query helpers)
- `string_extensions.dart` (string manipulation, validation)
- `widget_extensions.dart` (widget helpers)
- `date_extensions.dart` (date/time formatting)

**Guidelines:**
- Extensions must be stateless and reusable.
- Only add extensions that are used in multiple places.
- Keep extension files focused by type or domain.

---

## 14. 📦 Project Template for Reuse

This section provides a ready-to-copy template for structuring a new Flutter project following the Bola FlutterMCP architecture. Use this as a starting point for any new project that requires clear separation of concerns, modularity, and best practices.

### Directory Structure (Template)
```plaintext
lib/
├── core/
│   ├── config/
│   │   ├── constants.dart
│   │   ├── env.dart
│   │   ├── interceptors.dart
│   │   └── flavor_config.dart
│   ├── error/
│   │   ├── failure.dart
│   │   ├── app_error.dart
│   │   ├── error_utils.dart
│   │   └── network_exceptions.dart
│   ├── extensions/
│   │   ├── context_extensions.dart
│   │   ├── string_extensions.dart
│   │   ├── widget_extensions.dart
│   │   └── date_extensions.dart
│   ├── providers/
│   │   ├── core_providers.dart
│   │   ├── environment_provider.dart
│   │   ├── loading_provider.dart
│   │   ├── error_provider.dart
│   │   └── app_initialized_provider.dart
│   ├── router/
│   │   ├── app_router.dart
│   │   ├── route_constants.dart
│   │   ├── route_guards.dart
│   │   └── router_utils.dart
│   └── utils/
│       ├── theme_utils.dart
│       ├── spacing_utils.dart
│       ├── validators.dart
│       ├── logger.dart
│       ├── enums.dart
│       ├── enum_mappers.dart
│       ├── date_utils.dart
│       ├── string_utils.dart
│       ├── number_utils.dart
│       ├── device_utils.dart
│       ├── debounce_throttle.dart
│       ├── collection_utils.dart
│       └── async_utils.dart
```

### File Templates for Each File in `core/config/`

#### core/config/constants.dart
##### Template
```dart
// core/config/constants.dart
class AppConstants {
  static const String appName = 'MyApp';
  static const int defaultTimeout = 30;
  // Add more constants as needed
}
```

#### core/config/env.dart
##### Template
```dart
// core/config/env.dart
class Env {
  static const String apiBaseUrl = String.fromEnvironment('API_BASE_URL', defaultValue: 'https://api.example.com');
  static const bool isProduction = bool.fromEnvironment('DART_DEFINE_IS_PRODUCTION', defaultValue: false);
}
```

#### core/config/interceptors.dart
##### Template
```dart
// core/config/interceptors.dart
import 'package:dio/dio.dart';
class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('Request: \\${options.method} \\${options.path}');
    super.onRequest(options, handler);
  }
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('Response: \\${response.statusCode}');
    super.onResponse(response, handler);
  }
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print('Error: \\${err.message}');
    super.onError(err, handler);
  }
}
```

#### core/config/flavor_config.dart
##### Template
```dart
// core/config/flavor_config.dart
enum Flavor { development, staging, production }

class FlavorConfig {
  final Flavor flavor;
  final String apiBaseUrl;
  static FlavorConfig? _instance;

  factory FlavorConfig({required Flavor flavor, required String apiBaseUrl}) {
    _instance = FlavorConfig._internal(flavor, apiBaseUrl);
    return _instance!;
  }

  FlavorConfig._internal(this.flavor, this.apiBaseUrl);

  static FlavorConfig get instance => _instance!;
}
```

---

### (The rest of the file templates for core/error, core/extensions, core/providers, core/router, core/utils remain unchanged)

---

**How to Use:**
- Copy the directory structure and templates above into your new project.
- Follow the naming and organization conventions for all new code.
- Reference this section and the rest of this protocol file for best practices and architectural decisions.

--- 