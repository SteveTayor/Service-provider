import 'package:bundlegram/presentation/features/promo/provider/promo_provider.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PromoInputSection extends ConsumerStatefulWidget {
  const PromoInputSection({super.key});

  @override
  ConsumerState<PromoInputSection> createState() => _PromoInputSectionState();
}

class _PromoInputSectionState extends ConsumerState<PromoInputSection> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final state = ref.read(promoProvider);
    _controller = TextEditingController(text: state.promoCode);
  }

  @override
  void didUpdateWidget(covariant PromoInputSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    final state = ref.read(promoProvider);
    if (_controller.text != state.promoCode) {
      _controller.text = state.promoCode;
    }
  }

  @override
  Widget build(BuildContext context) {
    final promoState = ref.watch(promoProvider);

    return Container(
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          Expanded(
            child: AppTextField(
              hintText: 'Enter promo code',
              controller: _controller,
              onChange: (value) {
                ref.read(promoProvider.notifier).updatePromoCode(value);
              },
              borderRadius: 8,
            ),
          ),
          12.horizontalSpace,
          BundlegramButton(
            text: 'Claim',
            height: 42.h,
            width: 94.w,
            isLoading: promoState.isLoading,
            isEnabled: promoState.promoCode.isNotEmpty,
            onPressed: promoState.promoCode.isNotEmpty
                ? () => ref
                    .read(promoProvider.notifier)
                    .claimPromo(promoState.promoCode, context)
                : null,
          ),
        ],
      ),
    );
  }
}
