import 'package:bundlegram/core/error/failures.dart';

/// OTP was submitted but does not match what was sent.
class InvalidOtpFailure extends Failure {
  const InvalidOtpFailure([super.properties]);
}

/// OTP was submitted after its validity window elapsed.
class ExpiredOtpFailure extends Failure {
  const ExpiredOtpFailure([super.properties]);
}

/// The selected network has no active Airtime-to-Cash configuration.
class NoActiveConfigFailure extends Failure {
  const NoActiveConfigFailure([super.properties]);
}
