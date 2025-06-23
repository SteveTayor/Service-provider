import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:bundlegram/core/error/failures.dart';

Future<Either<Failure, T>> handleApi<T>(Future<T> Function() call) async {
  try {
    final result = await call();
    return Right(result);
  } on DioException catch (e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      return const Left(NetworkFailure(['Connection timed out']));
    }

    if (e.response != null) {
      final statusCode = e.response!.statusCode;
      final message = e.response!.data['message'] ?? 'Unknown error';

      switch (statusCode) {
        case 400:
          return Left(ValidationFailure([message]));
        case 401:
          return const Left(AuthenticationFailure());
        case 403:
          return const Left(AuthorizationFailure());
        case 404:
          return Left(NotFoundFailure([message]));
        case 500:
        default:
          return Left(ServerFailure([message]));
      }
    }

    return const Left(UnknownFailure(['An unexpected error occurred']));
  } catch (e) {
    return const Left(UnknownFailure(['Unexpected error']));
  }
}
