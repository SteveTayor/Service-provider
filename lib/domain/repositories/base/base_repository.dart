import 'package:dartz/dartz.dart';

import 'package:bundlegram/core/error/failures.dart';

/// Base repository interface for all repositories
abstract class BaseRepository<T> {
  /// Get a single item by ID
  Future<Either<Failure, T>> getById(String id);

  /// Get all items
  Future<Either<Failure, List<T>>> getAll();

  /// Create a new item
  Future<Either<Failure, T>> create(T item);

  /// Update an existing item
  Future<Either<Failure, T>> update(T item);

  /// Delete an item by ID
  Future<Either<Failure, bool>> delete(String id);
} 