import 'package:flutter/foundation.dart';
import 'package:riverpod/riverpod.dart';

@immutable
abstract class BaseAsyncNotifier<T> extends AsyncNotifier<T> {
  @protected
  Future<T> handleError(Future<T> Function() cb) async {
    try {
      return await cb();
    } catch (error, stackTrace) {
      debugPrint('Error: $error');
      debugPrint('StackTrace: $stackTrace');
      // You can add custom error handling here
      rethrow;
    }
  }
} 