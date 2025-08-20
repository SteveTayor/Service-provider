import 'package:bundlegram/core/utils/platform_provider_enums.dart';
import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';
import 'package:bundlegram/data/models/products/get_all_products_response.dart';
import 'package:bundlegram/data/models/products/get_sub_products_response.dart';
import 'package:bundlegram/data/models/transaction/user_transactions_response.dart';
import 'package:bundlegram/data/repositories/api_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Sanitizes backend or unexpected error messages to be safe for display.
/// - Strips HTML
/// - Collapses spaces
/// - Truncates overly long strings
String _sanitizeErrorMessage(dynamic rawMessage) {
  if (rawMessage == null) return 'An unexpected error occurred';

  String message = rawMessage.toString();

  // Remove HTML tags
  message = message.replaceAll(RegExp(r'<[^>]*>'), ' ').trim();

  // Collapse spaces and newlines
  message = message.replaceAll(RegExp(r'\s+'), ' ').trim();

  // Limit length to avoid huge snackbar overflow
  if (message.length > 200) {
    message = message.substring(0, 200) + '...';
  }

  return message.isEmpty ? 'An unexpected error occurred' : message;
}

/// Loaded saved token
final authTokenProvider = FutureProvider<String>((ref) async {
  final storage = ref.read(secureStorageHelperProvider);
  final token = await storage.getAuthToken();
  if (token == null) {
    throw Exception('No auth token found');
  }
  return token;
});

/// Main products provider that picks the right endpoint:
/// • Airtime & Data → GET /getProductByService/{serviceId}
/// • Others         → GET /getProductByType/{typeKey}
final productsProvider =
    FutureProvider.family<GetAllProductsResponse, PlatformProductType>(
  (ref, serviceType) async {
    final token = await ref.read(authTokenProvider.future);
    final bearer = 'Bearer $token';

    // Airtime uses SERVICE endpoint
    if (serviceType == PlatformProductType.airtime) {
      final result = await ref
          .read(apiServiceProvider)
          .getProductByService(bearer, 'BUY_AIRTIME_001');

      return result.fold(
        (failure) {
          // Always sanitize before throwing so UI never shows raw HTML or overly long text
          final safeMsg = failure.properties.isNotEmpty
              ? _sanitizeErrorMessage(failure.properties.first)
              : 'Failed to fetch airtime products';
          throw Exception(safeMsg);
        },
        (data) => data,
      );
    }

    // Mobile Data uses SERVICE endpoint
    if (serviceType == PlatformProductType.mobileData) {
      final result = await ref
          .read(apiServiceProvider)
          .getProductByService(bearer, 'DATA_PUR_01');

      return result.fold(
        (failure) {
          final safeMsg = failure.properties.isNotEmpty
              ? _sanitizeErrorMessage(failure.properties.first)
              : 'Failed to fetch mobile data products';
          throw Exception(safeMsg);
        },
        (data) => data,
      );
    }

    // All other flows use TYPE endpoint
    final typeKey = switch (serviceType) {
      PlatformProductType.betting => 'betting',
      PlatformProductType.cableTv => 'cable_tv',
      PlatformProductType.ePinVoucher => 'epin',
      PlatformProductType.bulkEPin => 'epin',
      PlatformProductType.electricity => 'electricity',
      PlatformProductType.education => 'education',
      PlatformProductType.internetServices => 'internet',
      _ => throw Exception('Unknown type'),
    };

    final result =
        await ref.read(apiServiceProvider).getProductByType(bearer, typeKey);

    return result.fold(
      (failure) {
        final safeMsg = failure.properties.isNotEmpty
            ? _sanitizeErrorMessage(failure.properties.first)
            : 'Failed to fetch products for $typeKey';
        throw Exception(safeMsg);
      },
      (data) => data,
    );
  },
);

/// Fetch sub-products
final subProductsProvider =
    FutureProvider.family<GetAllSubProductsResponse, int>(
  (ref, productId) async {
    final token = await ref.read(authTokenProvider.future);
    final bearer = 'Bearer $token';

    final result =
        await ref.read(apiServiceProvider).getSubProduct(bearer, productId);

    return result.fold(
      (failure) {
        final safeMsg = failure.properties.isNotEmpty
            ? _sanitizeErrorMessage(failure.properties.first)
            : 'Failed to fetch sub-products';
        throw Exception(safeMsg);
      },
      (data) => data,
    );
  },
);

/// Fetch sub-products by category
final subProductsByCategoryProvider = FutureProvider.family<
    GetAllSubProductsResponse, (int productId, String category)>(
  (ref, tuple) async {
    final token = await ref.read(authTokenProvider.future);
    final bearer = 'Bearer $token';

    final result = await ref
        .read(apiServiceProvider)
        .getSubProductByCategory(bearer, tuple.$1, tuple.$2);

    return result.fold(
      (failure) {
        final safeMsg = failure.properties.isNotEmpty
            ? _sanitizeErrorMessage(failure.properties.first)
            : 'Failed to fetch sub-products by category';
        throw Exception(safeMsg);
      },
      (data) => data,
    );
  },
);

/// Fetch transaction history → GET /userTransactions/{typeKey}
final transactionsProvider =
    FutureProvider.family<GetAllUserTransactionResponse, PlatformProductType>(
  (ref, serviceType) async {
    final token = await ref.read(authTokenProvider.future);
    final bearer = 'Bearer $token';

    // map enum → endpoint segment
    final historyKey = switch (serviceType) {
      PlatformProductType.airtime => 'airtime',
      PlatformProductType.mobileData => 'mobile_data',
      PlatformProductType.betting => 'betting',
      PlatformProductType.cableTv => 'cable_tv',
      PlatformProductType.electricity => 'electricity',
      PlatformProductType.education => 'education',
      PlatformProductType.internetServices => 'internet',
      PlatformProductType.ePinVoucher => 'epin',
      PlatformProductType.bulkEPin => 'epin',
      _ => throw Exception('Unknown type'),
    };

    final result = await ref
        .read(apiServiceProvider)
        .getTransactionsByType(bearer, historyKey);

    return result.fold(
      (failure) {
        final safeMsg = failure.properties.isNotEmpty
            ? _sanitizeErrorMessage(failure.properties.first)
            : 'Failed to fetch $historyKey transactions';
        throw Exception(safeMsg);
      },
      (data) => data,
    );
  },
);
