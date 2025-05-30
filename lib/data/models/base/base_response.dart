import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

/// Base response model for API responses
@JsonSerializable(genericArgumentFactories: true)
class BaseResponse<T> {
  /// Constructor
  const BaseResponse({
    required this.success,
    required this.message,
    this.data,
    this.error,
  });

  /// Create response from JSON map
  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$BaseResponseFromJson(json, fromJsonT);

  /// Whether the request was successful
  final bool success;

  /// Response message
  final String message;

  /// Response data
  final T? data;

  /// Error details if request failed
  final String? error;

  /// Convert response to JSON map
  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$BaseResponseToJson(this, toJsonT);

  /// Create a copy of the response with some fields replaced
  BaseResponse<T> copyWith({
    bool? success,
    String? message,
    T? data,
    String? error,
  }) {
    return BaseResponse<T>(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }

  /// Convert response to string representation
  @override
  String toString() {
    return 'BaseResponse{success: $success, message: $message, data: $data, error: $error}';
  }

  /// Compare two responses for equality
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BaseResponse<T> &&
        other.success == success &&
        other.message == message &&
        other.data == data &&
        other.error == error;
  }

  /// Generate hash code for response
  @override
  int get hashCode {
    return success.hashCode ^
        message.hashCode ^
        data.hashCode ^
        error.hashCode;
  }
} 