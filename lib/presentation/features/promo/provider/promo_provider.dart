import 'package:bundlegram/presentation/features/promo/model/promo_model.dart';
import 'package:bundlegram/presentation/features/promo/model/promo_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PromoNotifier extends StateNotifier<PromoState> {
  PromoNotifier() : super(const PromoState()) {
    _loadInitialData();
  }

  void _loadInitialData() {
    // Mock data - replace with API call
    final List<PromoModel> mockPromos = [
      // const PromoModel(
      //   id: '1',
      //   code: 'LOYALTY2500',
      //   title: 'We are giving ₦2500 free bonus to our loyal customers',
      //   description: 'Just hit ₦50,000 spend this month!',
      //   amount: 2500,
      //   backgroundColor: '#EEF3FF',
      //   textColor: '#C9DAFF',
      // ),
      // const PromoModel(
      //   id: '2',
      //   code: 'WELCOME5000',
      //   title: 'Get ₦5000 free in your promo wallet as a welcome gift',
      //   description: 'Your first wallet top-up is all it takes!',
      //   amount: 5000,
      //   isClaimed: true,
      //   backgroundColor: '#EEF3FF',
      //   textColor: '#C9DAFF',
      // ),
    ];

    state = state.copyWith(availablePromos: mockPromos);
  }

  void updatePromoCode(String code) {
    state = state.copyWith(promoCode: code);
  }

  Future<void> claimPromo(String promoCode) async {
    state = state.copyWith(isLoading: true);

    try {
      // TODO: Implement API call
      // final result = await _promoService.claimPromo(promoCode);

      // Mock delay
      await Future.delayed(const Duration(seconds: 1));

      // Update state with claimed promo
      final updatedPromos = state.availablePromos.map((promo) {
        if (promo.code == promoCode) {
          return promo.copyWith(isClaimed: true);
        }
        return promo;
      }).toList();

      state = state.copyWith(
        availablePromos: updatedPromos,
        isLoading: false,
        totalRewards: state.totalRewards + 2500, // Mock reward
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> claimPromoByCode() async {
    if (state.promoCode.isEmpty) return;
    await claimPromo(state.promoCode);
  }
}

final promoProvider =
    StateNotifierProvider.autoDispose<PromoNotifier, PromoState>((ref) {
  return PromoNotifier();
});
