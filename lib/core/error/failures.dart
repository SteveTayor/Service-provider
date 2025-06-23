import 'package:equatable/equatable.dart';

/// Base failure class for all failures in the application
abstract class Failure extends Equatable {
  /// Constructor
  const Failure([this.properties = const <dynamic>[]]);

  /// Properties to be used in equality comparison
  final List<dynamic> properties;

  @override
  List<Object?> get props => properties;
}

/// Server failure
class ServerFailure extends Failure {
  const ServerFailure([super.properties]);
}

/// Cache failure
class CacheFailure extends Failure {
  const CacheFailure([super.properties]);
}

/// Network failure
class NetworkFailure extends Failure {
  const NetworkFailure([super.properties]);
}

/// Validation failure
class ValidationFailure extends Failure {
  const ValidationFailure([super.properties]);
}

/// Authentication failure
class AuthenticationFailure extends Failure {
  const AuthenticationFailure([super.properties]);
}

/// Authorization failure
class AuthorizationFailure extends Failure {
  const AuthorizationFailure([super.properties]);
}

/// Not found failure
class NotFoundFailure extends Failure {
  const NotFoundFailure([super.properties]);
}

/// Unknown failure
class UnknownFailure extends Failure {
  const UnknownFailure([super.properties]);
}
