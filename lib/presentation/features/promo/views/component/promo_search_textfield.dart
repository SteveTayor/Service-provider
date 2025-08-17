import 'package:bundlegram/presentation/features/promo/provider/promo_provider.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PromoInputSection extends ConsumerWidget {
  const PromoInputSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final promoState = ref.watch(promoProvider);

    return Container(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: AppTextField(
                  hintText: 'Enter promo code',
                  controller: TextEditingController(text: promoState.promoCode),
                  onChange: (value) {
                    ref.read(promoProvider.notifier).updatePromoCode(value);
                  },
                  borderRadius: 8,
                  height: 52.h,
                ),
              ),
              12.horizontalSpace,
              BundlegramButton(
                text: 'Claim',
                // height: 45.h,
                width: 94.w,
                isLoading: promoState.isLoading,
                onPressed: promoState.promoCode.isNotEmpty
                    ? () => ref.read(promoProvider.notifier).claimPromoByCode()
                    : null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
