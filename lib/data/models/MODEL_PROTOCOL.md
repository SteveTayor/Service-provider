# Model Context Protocol

This protocol defines the conventions and best practices for defining, managing, and using data models in this project. It is designed to be reusable across projects for consistency and maintainability.

---

## 1. Model Structure & Location
- **Directory:** Place all model classes in `lib/data/models/`.
- **File Naming:** Use snake_case for filenames (e.g., `user_model.dart`).
- **Class Naming:** Use PascalCase for class names (e.g., `UserModel`).

## 2. Model Definition
- **Fields:** Prefer `final` fields for immutability.
- **Constructor:** Use named parameters and `const` constructors when possible.
- **Serialization:** Every model must implement:
  - `factory ModelName.fromJson(Map<String, dynamic> json)`
  - `Map<String, dynamic> toJson()`
- **Equatability:** Use the `equatable` package or override `==` and `hashCode` for value comparison.

### Example
```dart
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String name;
  final String email;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] as String,
        name: json['name'] as String,
        email: json['email'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
      };

  @override
  List<Object?> get props => [id, name, email];
}
```

## 3. Model Usage Protocol
- **Immutability:** Prefer immutable models for safety and predictability.
- **Copying:** If mutability is needed, provide a `copyWith` method.
- **Validation:** Add static or instance methods for validation if needed.

## 4. Model Integration
- **Repositories:** Models should be the primary data structure exchanged between repositories and the rest of the app.
- **Domain Layer:** If using Clean Architecture, convert models to domain entities as needed.

## 5. Testing
- **Unit Tests:** Each model should have a corresponding test file in `test/data/models/` to verify serialization, deserialization, and equality.

## 6. Documentation
- **Doc Comments:** Every model and its fields should have Dart doc comments explaining their purpose.

---

## How to Use in Another Project
1. Copy this protocol and example to your new project.
2. Set up the folder structure (`lib/data/models/`).
3. Follow the conventions for every new model.
4. Share this protocol as a markdown file (`MODEL_PROTOCOL.md`) in your repo for team reference. 