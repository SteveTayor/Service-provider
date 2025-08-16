import 'package:bundlegram/presentation/features/promo/model/promo_model.dart';

class PromoState {
  final String promoCode;
  final double totalRewards;
  final List<PromoModel> availablePromos;
  final bool isLoading;
  final String? error;

  const PromoState({
    this.promoCode = '',
    this.totalRewards = 5000.00,
    this.availablePromos = const [],
    this.isLoading = false,
    this.error,
  });

  PromoState copyWith({
    String? promoCode,
    double? totalRewards,
    List<PromoModel>? availablePromos,
    bool? isLoading,
    String? error,
  }) {
    return PromoState(
      promoCode: promoCode ?? this.promoCode,
      totalRewards: totalRewards ?? this.totalRewards,
      availablePromos: availablePromos ?? this.availablePromos,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
