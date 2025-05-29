import 'package:equatable/equatable.dart';

/// Base failure class for all failures in the application
abstract class Failure extends Equatable {
  /// Constructor
  const Failure([this.properties = const <dynamic>[]]);

  /// Properties to be used in equality comparison
  final List<dynamic> properties;

  @override
  List<Object?> get props => [properties];
}

/// Server failure
class ServerFailure extends Failure {
  /// Constructor
  const ServerFailure([super.properties]);
}

/// Cache failure
class CacheFailure extends Failure {
  /// Constructor
  const CacheFailure([super.properties]);
}

/// Network failure
class NetworkFailure extends Failure {
  /// Constructor
  const NetworkFailure([super.properties]);
}

/// Validation failure
class ValidationFailure extends Failure {
  /// Constructor
  const ValidationFailure([super.properties]);
}

/// Authentication failure
class AuthenticationFailure extends Failure {
  /// Constructor
  const AuthenticationFailure([super.properties]);
}

/// Authorization failure
class AuthorizationFailure extends Failure {
  /// Constructor
  const AuthorizationFailure([super.properties]);
}

/// Not found failure
class NotFoundFailure extends Failure {
  /// Constructor
  const NotFoundFailure([super.properties]);
}

/// Unknown failure
class UnknownFailure extends Failure {
  /// Constructor
  const UnknownFailure([super.properties]);
} 