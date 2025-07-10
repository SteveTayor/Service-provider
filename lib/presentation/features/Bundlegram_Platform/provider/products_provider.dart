import 'package:bundlegram/core/utils/platform_provider_enums.dart';
import 'package:bundlegram/data/models/products/get_all_products_response.dart';
import 'package:bundlegram/data/models/products/get_sub_products_response.dart';
import 'package:bundlegram/data/models/transaction/user_transactions_response.dart';
import 'package:bundlegram/data/repositories/api_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';
import 'package:bundlegram/core/utils/enums.dart';

/// Loaded saved token
final authTokenProvider = FutureProvider<String>((ref) async {
  final storage = ref.read(secureStorageHelperProvider);
  final token = await storage.getAuthToken();
  if (token == null) throw Exception('No auth token found');
  return token;
});

/// Main products provider that picks the right endpoint:
/// • Airtime & Data → GET /getProductByService/{serviceId}
/// • Others      → GET /getProductByType/{typeKey}
final productsProvider =
    FutureProvider.family<GetAllProductsResponse, PlatformProductType>(
  (ref, serviceType) async {
    final token = await ref.read(authTokenProvider.future);
    final bearer = 'Bearer $token';

    // Airtime & Data use SERVICE endpoint:
    if (serviceType == PlatformProductType.airtime) {
      final result = await ref
          .read(apiServiceProvider)
          .getProductByService(bearer, 'BUY_AIRTIME_001');

      return result.fold(
        (failure) {
          throw Exception(failure.properties.isNotEmpty
              ? failure.properties.first
              : 'Failed to fetch airtime products');
        },
        (data) => data,
      );
    }
    if (serviceType == PlatformProductType.mobileData) {
      return ref
          .read(apiServiceProvider)
          .getProductByService(bearer, 'DATA_PUR_01')
          .then((r) => r.getOrElse(() => throw Exception()));
    }

    // All other flows use TYPE endpoint:
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

    return ref
        .read(apiServiceProvider)
        .getProductByType(bearer, typeKey)
        .then((r) => r.getOrElse(() => throw Exception()));
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
    return result.getOrElse(() => throw Exception());
  },
);

final subProductsByCategoryProvider = FutureProvider.family<
    GetAllSubProductsResponse, (int productId, String category)>(
  (ref, tuple) async {
    final token = await ref.read(authTokenProvider.future);
    final bearer = 'Bearer $token';
    final result = await ref
        .read(apiServiceProvider)
        .getSubProductByCategory(bearer, tuple.$1, tuple.$2);
    return result.getOrElse(
        () => throw Exception('Failed to fetch sub-products by category'));
  },
);

/// Fetch history → GET /userTransactions/{typeKey}
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
    return result.getOrElse(() => throw Exception());
  },
);
