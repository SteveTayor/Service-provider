import 'package:bundlegram/core/error/error_sanitixed_users.dart';
import 'package:bundlegram/core/extensions/promo_wrapper_extension.dart';
import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/data/models/promo/redeem_promo_request.dart';
import 'package:bundlegram/data/repositories/api_services.dart';
import 'package:bundlegram/presentation/app.dart';
import 'package:bundlegram/presentation/features/promo/model/promo_model.dart';
import 'package:bundlegram/presentation/features/promo/model/promo_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

// class PromoNotifier extends StateNotifier<PromoState> {
//   PromoNotifier() : super(const PromoState()) {
//     _loadInitialData();
//   }

//   void _loadInitialData() {
//     // Mock data - replace with API call
//     final List<PromoModel> mockPromos = [
//       // const PromoModel(
//       //   id: '1',
//       //   code: 'LOYALTY2500',
//       //   title: 'We are giving â‚¦2500 free bonus to our loyal customers',
//       //   description: 'Just hit â‚¦50,000 spend this month!',
//       //   amount: 2500,
//       //   backgroundColor: '#EEF3FF',
//       //   textColor: '#C9DAFF',
//       // ),
//       // const PromoModel(
//       //   id: '2',
//       //   code: 'WELCOME5000',
//       //   title: 'Get â‚¦5000 free in your promo wallet as a welcome gift',
//       //   description: 'Your first wallet top-up is all it takes!',
//       //   amount: 5000,
//       //   isClaimed: true,
//       //   backgroundColor: '#EEF3FF',
//       //   textColor: '#C9DAFF',
//       // ),
//     ];

//     state = state.copyWith(availablePromos: mockPromos);
//   }

//   void updatePromoCode(String code) {
//     state = state.copyWith(promoCode: code);
//   }

//   Future<void> claimPromo(String promoCode) async {
//     state = state.copyWith(isLoading: true);

//     try {
//       // TODO: Implement API call
//       // final result = await _promoService.claimPromo(promoCode);

//       // Mock delay
//       await Future.delayed(const Duration(seconds: 1));

//       // Update state with claimed promo
//       final updatedPromos = state.availablePromos.map((promo) {
//         if (promo.code == promoCode) {
//           return promo.copyWith(isClaimed: true);
//         }
//         return promo;
//       }).toList();

//       state = state.copyWith(
//         availablePromos: updatedPromos,
//         isLoading: false,
//         totalRewards: state.totalRewards + 2500, // Mock reward
//       );
//     } catch (e) {
//       state = state.copyWith(
//         isLoading: false,
//         error: e.toString(),
//       );
//     }
//   }

//   Future<void> claimPromoByCode() async {
//     if (state.promoCode.isEmpty) return;
//     await claimPromo(state.promoCode);
//   }
// }

// final promoProvider =
//     StateNotifierProvider.autoDispose<PromoNotifier, PromoState>((ref) {
//   return PromoNotifier();
// });

import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';

class PromoNotifier extends StateNotifier<PromoState> {
  final Ref ref;
  final ApiService _api;

  PromoNotifier(this.ref, this._api) : super(const PromoState()) {
    // Fetch promos immediately when provider is instantiated
    Future.microtask(() => fetchPromos(navigatorKey.currentContext!));
  }
  Future<void> fetchPromos(BuildContext context) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final token = await ref.read(secureStorageHelperProvider).getAuthToken();
      if (token == null) {
        state = state.copyWith(isLoading: false, error: "No token found");
        return;
      }

      final result = await _api.getAllAvailablePromos(token);

      result.fold(
        (failure) {
          final userMsg = userFacingMessageFromFailure(failure);
          context.showErrorSnackBar(userMsg);
          state = state.copyWith(isLoading: false, error: userMsg);
        },
        (response) {
          // Parsing promos into model
          final promos = response.data?.promos ?? [];
          final promoModels = promos.map((p) => p.toPromoModel()).toList();

          // Optionally update rewards sum
          final totalRewards =
              promoModels.fold<double>(0, (sum, p) => sum + p.amount);
          state = state.copyWith(
            isLoading: false,
            availablePromos: promoModels,
          );
        },
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> claimPromo(String promoCode, BuildContext context) async {
    if (promoCode.isEmpty) {
      context.showErrorSnackBar("Enter a promo code");
      return;
    }

    state = state.copyWith(isLoading: true);

    try {
      final token = await ref.read(secureStorageHelperProvider).getAuthToken();
      if (token == null) {
        state = state.copyWith(isLoading: false, error: "No token found");
        return;
      }

      final result =
          await _api.redeemAPromo(token, RedeemAPromoRequest(code: promoCode));

      result.fold(
        (failure) {
          final userMsg = userFacingMessageFromFailure(failure);
          context.showErrorSnackBar(userMsg);
          state = state.copyWith(isLoading: false, error: userMsg);
        },
        (response) {
          // Successfully claimed
          context.showSuccessSnackBar("Promo $promoCode claimed!");
          state = state.copyWith(isLoading: false, promoCode: "");
        },
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void updatePromoCode(String code) {
    state = state.copyWith(promoCode: code);
  }
}

final promoProvider =
    StateNotifierProvider.autoDispose<PromoNotifier, PromoState>((ref) {
  final _api = ref.read(apiServiceProvider);
  return PromoNotifier(ref, _api);
});

