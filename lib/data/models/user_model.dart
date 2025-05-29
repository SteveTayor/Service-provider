import 'package:equatable/equatable.dart';

/// Represents a user in the system.
class UserModel extends Equatable {

  /// Creates a [UserModel] instance.
  const UserModel({
    required this.id,
    required this.name,
    required this.email,
  });

  /// Creates a [UserModel] from a JSON map.
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] as String,
        name: json['name'] as String,
        email: json['email'] as String,
      );
  /// Unique identifier for the user.
  final String id;

  /// The user's full name.
  final String name;

  /// The user's email address.
  final String email;

  /// Converts the [UserModel] to a JSON map.
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
      };

  /// Returns a copy of this user with updated fields.
  UserModel copyWith({String? id, String? name, String? email}) => UserModel(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
      );

  @override
  List<Object?> get props => [id, name, email];
} 