import 'package:bundlegram/presentation/features/promo/provider/promo_provider.dart';
import 'package:bundlegram/presentation/features/promo/views/component/available_promo.dart';
import 'package:bundlegram/presentation/features/promo/views/component/promo_outlook.dart';
import 'package:bundlegram/presentation/features/promo/views/component/promo_search_textfield.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PromoScreen extends ConsumerStatefulWidget {
  const PromoScreen({super.key});

  @override
  ConsumerState<PromoScreen> createState() => _PromoScreenState();
}

class _PromoScreenState extends ConsumerState<PromoScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(promoProvider.notifier).fetchPromos(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const BundlegramScaffold(
      appBar: BundlegramAppbar(
        titleText: 'Bundlegram promo',
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PromoInputSection(),
            PromoRewardsSection(),
            AvailablePromosSection(),
          ],
        ),
      ),
    );
  }
}

// Alternative implementation with AppAsyncBuilder (commented out for now)
/*
class PromoScreen extends ConsumerWidget {
  const PromoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final promoAsync = ref.watch(promoAsyncProvider);
    
    return BundlegramScaffold(
      appBar: const BundlegramAppbar(
        titleText: 'Bundlegram promo',
        showBackButton: true,
      ),
      body: AppAsyncBuilder<PromoState>(
        state: promoAsync,
        builder: (context, ref, promoState) {
          return const SingleChildScrollView(
            child: Column(
              children: [
                PromoInputSection(),
                PromoRewardsSection(),
                AvailablePromosSection(),
              ],
            ),
          );
        },
        onRetry: () => ref.refresh(promoAsyncProvider),
      ),
    );
  }
}
*/
