import 'package:json_annotation/json_annotation.dart';

/// Base model class for all data models
abstract class BaseModel<T> {
  /// Convert model to JSON map
  Map<String, dynamic> toJson();

  /// Create model from JSON map
  static T fromJson<T>(Map<String, dynamic> json) {
    throw UnimplementedError('fromJson() has not been implemented.');
  }

  /// Create a copy of the model with some fields replaced
  T copyWith();

  /// Convert model to string representation
  @override
  String toString() {
    return toJson().toString();
  }

  /// Compare two models for equality
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BaseModel && toString() == other.toString();
  }

  /// Generate hash code for model
  @override
  int get hashCode => toString().hashCode;
} 