import 'package:bundlegram/data/models/promo/get_allpromo_response.dart';
import 'package:bundlegram/presentation/features/promo/model/promo_model.dart';

extension PromoMapper on Promo {
  PromoModel toPromoModel() {
    return PromoModel(
      id: id?.toString() ?? "",
      code: code ?? "",
      title: code ?? "Promo",
      description:
          "Get ₦${bonusAmount ?? "0"} bonus in your promo wallet as a welcome gift",
      amount: double.tryParse(bonusAmount ?? "0") ?? 0.0,
      isClaimed: (redeemedCount ?? 0) > 0,
      backgroundColor: '#EEF3FF',
      textColor: '#C9DAFF',
    );
  }
}
