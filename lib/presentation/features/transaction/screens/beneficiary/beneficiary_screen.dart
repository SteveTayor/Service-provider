import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/platform_provider_enums.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/provider/platform_product_provider.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/provider/products_provider.dart';
import 'package:bundlegram/presentation/general_widget/app_listtile.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// class AllBeneficiariesScreen extends ConsumerStatefulWidget {
//   const AllBeneficiariesScreen({
//     Key? key,
//     required this.serviceType,
//   }) : super(key: key);

//   final PlatformProductType serviceType;

//   @override
//   ConsumerState<AllBeneficiariesScreen> createState() =>
//       _AllBeneficiariesScreenState();
// }

// class _AllBeneficiariesScreenState
//     extends ConsumerState<AllBeneficiariesScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   final ScrollController _scrollController = ScrollController();
//   String _query = '';

//   @override
//   void initState() {
//     super.initState();
//     // to prefetch all beneficiaries when opening screen:
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       ref.read(beneficiariesProvider.future).catchError((_) {
//         // Optional:  ignore
//       });
//     });
//     _searchController.addListener(() {
//       setState(() {
//         _query = _searchController.text.trim();
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     _scrollController.dispose();
//     super.dispose();
//   }

//   bool _shouldShowForService() {
//     return widget.serviceType == PlatformProductType.airtime ||
//         widget.serviceType == PlatformProductType.mobileData;
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Guard: if user somehow opened this screen for non-airtime/data, show message
//     if (!_shouldShowForService()) {
//       return BundlegramScaffold(
//         appBar: BundlegramAppbar(titleText: 'Beneficiaries'),
//         body: Center(
//           child: Text(
//             'Beneficiaries are only available for Airtime & Mobile Data',
//             style: context.textTheme.bodySmall,
//             textAlign: TextAlign.center,
//           ),
//         ),
//       );
//     }

//     // Beneficiaries provider (expects FutureProvider<List<Beneficiary>>)
//     final beneficiariesAsync = ref.watch(beneficiariesProvider);

//     // platform notifier (to apply chosen beneficiary)
//     final notifier =
//         ref.read(platformProductProvider(widget.serviceType).notifier);

//     return BundlegramScaffold(
//       appBar: BundlegramAppbar(
//         titleText: 'Beneficiaries',
//         // No filter button (removed per your instruction)
//       ),
//       body: RefreshIndicator(
//         onRefresh: () async {
//           // re-fetch minimal beneficiaries
//           // If your provider is FutureProvider, forcing a refresh:
//           await ref.refresh(beneficiariesProvider.future);
//         },
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
//               child: AppTextField(
//                 controller: _searchController,
//                 decoration: const InputDecoration().search(),
//                 onChange: (value) {
//                   // local search - we already listen to controller; this keeps parity with ServiceHistoryScreen
//                   setState(() {
//                     _query = value.trim();
//                   });
//                 },
//               ),
//             ),
//             8.verticalSpace,
//             Expanded(
//               child: beneficiariesAsync.when(
//                 loading: () => const Center(child: CircularProgressIndicator()),
//                 error: (err, st) => Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         // show friendly message
//                         err.toString(),
//                         style: context.textTheme.bodySmall,
//                         textAlign: TextAlign.center,
//                       ),
//                       12.verticalSpace,
//                       ElevatedButton(
//                         onPressed: () => ref.refresh(beneficiariesProvider),
//                         child: const Text('Retry'),
//                       ),
//                     ],
//                   ),
//                 ),
//                 data: (list) {
//                   // filter locally based on _query (search bar)
//                   final filtered = _query.isEmpty
//                       ? list
//                       : list
//                           .where((b) =>
//                               (b.phoneNumber ?? '')
//                                   .toLowerCase()
//                                   .contains(_query.toLowerCase()) ||
//                               (b.network ?? '')
//                                   .toLowerCase()
//                                   .contains(_query.toLowerCase()))
//                           .toList();

//                   if (filtered.isEmpty) {
//                     return const Center(
//                         child:
//                             Text('No beneficiaries found')); // or Emptywidget
//                   }

//                   return ListView.separated(
//                     controller: _scrollController,
//                     padding:
//                         EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
//                     itemCount: filtered.length,
//                     separatorBuilder: (_, __) => Container(
//                       height: 1,
//                       color: AppColors.greyD0.withOpacity(0.3),
//                       margin: EdgeInsets.symmetric(vertical: 6.h),
//                     ),
//                     itemBuilder: (ctx, index) {
//                       final b = filtered[index];

//                       // Determine icon path using your notifier's normalizeAssetName
//                       final providerIcon = notifier.normalizeAssetName(
//                           b.network,
//                           serviceType: widget.serviceType);

//                       // Widget leading;
//                       // if (providerIcon != null &&
//                       //     providerIcon.endsWith('.svg')) {
//                       //   leading = CircleAvatar(
//                       //     radius: 18,
//                       //     backgroundColor: AppColors.white,
//                       //     child: ClipOval(
//                       //       child: Image.asset(
//                       //         providerIcon,
//                       //         fit: BoxFit.cover,
//                       //         width: 28,
//                       //         height: 28,
//                       //         errorBuilder: (_, __, ___) =>
//                       //             const Icon(Icons.device_unknown, size: 18),
//                       //       ),
//                       //     ),
//                       //   );
//                       // } else if (providerIcon != null &&
//                       //     providerIcon.isNotEmpty) {
//                       //   leading = CircleAvatar(
//                       //     radius: 18,
//                       //     backgroundColor: AppColors.white,
//                       //     child: ClipOval(
//                       //       child: Image.asset(
//                       //         providerIcon,
//                       //         fit: BoxFit.cover,
//                       //         width: 28,
//                       //         height: 28,
//                       //         errorBuilder: (_, __, ___) =>
//                       //             const Icon(Icons.device_unknown, size: 18),
//                       //       ),
//                       //     ),
//                       //   );
//                       // } else {
//                       //   leading = CircleAvatar(
//                       //     radius: 18,
//                       //     child: Text(
//                       //       (b.network?.substring(0, 1) ?? '?').toUpperCase(),
//                       //       style: context.textTheme.bodySmall,
//                       //     ),
//                       //   );
//                       // }

//                       // return ListTile(
//                       //   leading: leading,
//                       //   title: Text(b.phoneNumber!),
//                       //   subtitle: Text(b.network ?? ''),
//                       //   onTap: () async {
//                       //     // When user taps: apply beneficiary and close screen
//                       //     try {
//                       //       // pop first so UI returns to previous screen immediately
//                       //       Navigator.of(context).pop();

//                       //       // let the notifier apply the beneficiary (populate phone + auto-select product + fetch subproducts)
//                       //       await notifier.applyBeneficiary(context, b);
//                       //     } catch (e, st) {
//                       //       debugPrint('applyBeneficiary failed: $e');
//                       //     }
//                       //   },
//                       // );

//                       final providerNotifier = ref.read(
//                         platformProductProvider(widget.serviceType).notifier,
//                       );

//                       // normalize icon
//                       final brand = b.network ?? '';
//                       final iconName = notifier.normalizeAssetName(
//                         brand,
//                         serviceType: widget.serviceType,
//                       );

//                       final isSvg = iconName?.toLowerCase().endsWith('.svg');

//                       return AppListTile(
//                         assetPath: isSvg!
//                             ? iconName
//                             : null, // SVG path expected in assetPath
//                         imagePath:
//                             isSvg ? null : iconName, // PNG/JPG in imagePath
//                         title: b.phoneNumber ?? '',
//                         subtitle: brand,
//                         onPressed: () async {
//                           providerNotifier.setSelectedBeneficiary(b);
//                           await providerNotifier.applyBeneficiary(context, b);
//                           Navigator.of(context).pop(); // close screen
//                         },
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class AllBeneficiariesScreen extends ConsumerStatefulWidget {
  const AllBeneficiariesScreen({
    Key? key,
    required this.serviceType,
  }) : super(key: key);

  final PlatformProductType serviceType;

  @override
  ConsumerState<AllBeneficiariesScreen> createState() =>
      _AllBeneficiariesScreenState();
}

class _AllBeneficiariesScreenState
    extends ConsumerState<AllBeneficiariesScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String _query = '';
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    // to prefetch all beneficiaries when opening screen:
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(beneficiariesProvider.future).catchError((_) {
        // Optional:  ignore
      });
    });
    _searchController.addListener(() {
      setState(() {
        _query = _searchController.text.trim();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  bool _shouldShowForService() {
    return widget.serviceType == PlatformProductType.airtime ||
        widget.serviceType == PlatformProductType.mobileData;
  }

  Future<void> _handleRefresh() async {
    if (_isRefreshing) return;

    setState(() {
      _isRefreshing = true;
    });

    try {
      await ref.refresh(beneficiariesProvider.future);
    } finally {
      if (mounted) {
        setState(() {
          _isRefreshing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Guard: if user somehow opened this screen for non-airtime/data, show message
    if (!_shouldShowForService()) {
      return BundlegramScaffold(
        appBar: const BundlegramAppbar(titleText: 'Beneficiaries'),
        body: Center(
          child: Text(
            'Beneficiaries are only available for Airtime & Mobile Data',
            style: context.textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    // Beneficiaries provider (expects FutureProvider<List<Beneficiary>>)
    final beneficiariesAsync = ref.watch(beneficiariesProvider);

    // platform notifier (to apply chosen beneficiary)
    final notifier =
        ref.read(platformProductProvider(widget.serviceType).notifier);

    return BundlegramScaffold(
      appBar: const BundlegramAppbar(
        titleText: 'Beneficiaries',
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          // Prevent pull-to-refresh from triggering during normal scroll
          if (scrollInfo is ScrollUpdateNotification) {
            if (_scrollController.hasClients &&
                _scrollController.position.pixels > 0) {
              return false;
            }
          }
          return false;
        },
        child: CustomScrollView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            // Pull-to-refresh indicator
            SliverToBoxAdapter(
              child: _isRefreshing
                  ? Container(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(),
                    )
                  : const SizedBox.shrink(),
            ),

            // Search field
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.h),
                    child: AppTextField(
                      controller: _searchController,
                      decoration: const InputDecoration().search(),
                      onChange: (value) {
                        setState(() {
                          _query = value.trim();
                        });
                      },
                    ),
                  ),

                  /// Divider below search
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Divider(
                      color: AppColors.divider.withOpacity(.8),
                    ),
                  ),
                ],
              ),
            ),

            SliverToBoxAdapter(child: 8.verticalSpace),

            // Main content
            beneficiariesAsync.when(
              loading: () => const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (err, st) => SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        err.toString(),
                        style: context.textTheme.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                      12.verticalSpace,
                      TextButton(
                        onPressed: () => ref.refresh(beneficiariesProvider),
                        child: Text(
                          'Retry',
                          style: context.textTheme.bodySmall?.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              data: (list) {
                // filter locally based on _query (search bar)
                final filtered = _query.isEmpty
                    ? list
                    : list
                        .where((b) =>
                            (b.phoneNumber ?? '')
                                .toLowerCase()
                                .contains(_query.toLowerCase()) ||
                            (b.network ?? '')
                                .toLowerCase()
                                .contains(_query.toLowerCase()))
                        .toList();

                if (filtered.isEmpty) {
                  return const SliverFillRemaining(
                    child: Center(child: Text('No beneficiaries found')),
                  );
                }

                return SliverPadding(
                  // padding:
                  //     EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
                  padding: EdgeInsets.fromLTRB(10.w, 12.h, 10.w, 80.h),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (ctx, index) {
                        final actualIndex = index ~/ 2;

                        // Separator
                        if (index.isOdd) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Container(
                              height: 1,
                              color: AppColors.greyD0.withOpacity(0.1),
                              margin: EdgeInsets.symmetric(vertical: 6.h),
                            ),
                          );
                        }

                        final b = filtered[actualIndex];

                        // Determine icon path using your notifier's normalizeAssetName
                        // final providerIcon = notifier.normalizeAssetName(
                        //     b.network,
                        //     serviceType: widget.serviceType);

                        // Widget leading;
                        // if (providerIcon != null &&
                        //     providerIcon.endsWith('.svg')) {
                        //   leading = CircleAvatar(
                        //     radius: 18,
                        //     backgroundColor: AppColors.white,
                        //     child: ClipOval(
                        //       child: Image.asset(
                        //         providerIcon,
                        //         fit: BoxFit.cover,
                        //         width: 28,
                        //         height: 28,
                        //         errorBuilder: (_, __, ___) =>
                        //             const Icon(Icons.device_unknown, size: 18),
                        //       ),
                        //     ),
                        //   );
                        // } else if (providerIcon != null &&
                        //     providerIcon.isNotEmpty) {
                        //   leading = CircleAvatar(
                        //     radius: 18,
                        //     backgroundColor: AppColors.white,
                        //     child: ClipOval(
                        //       child: Image.asset(
                        //         providerIcon,
                        //         fit: BoxFit.cover,
                        //         width: 28,
                        //         height: 28,
                        //         errorBuilder: (_, __, ___) =>
                        //             const Icon(Icons.device_unknown, size: 18),
                        //       ),
                        //     ),
                        //   );
                        // } else {
                        //   leading = CircleAvatar(
                        //     radius: 18,
                        //     child: Text(
                        //       (b.network?.substring(0, 1) ?? '?').toUpperCase(),
                        //       style: context.textTheme.bodySmall,
                        //     ),
                        //   );
                        // }

                        final providerNotifier = ref.read(
                          platformProductProvider(widget.serviceType).notifier,
                        );

                        // normalize icon
                        final brand = b.network ?? '';
                        debugPrint('Beneficiary brand: $brand');
                        final iconName = notifier.normalizeAssetName(
                          brand,
                          serviceType: widget.serviceType,
                        );

                        final isSvg = iconName?.toLowerCase().endsWith('.svg');

                        return AppListTile(
                          assetPath: isSvg!
                              ? iconName
                              : null, // SVG path expected in assetPath
                          imagePath:
                              isSvg ? null : iconName, // PNG/JPG in imagePath
                          title: b.phoneNumber ?? '',
                          subtitle: brand,
                          showSubtitle: true,
                          onPressed: () async {
                            providerNotifier.setSelectedBeneficiary(b);
                            await providerNotifier.applyBeneficiary(context, b);
                            Navigator.of(context).pop(); // close screen
                          },
                        );
                      },
                      childCount: filtered.length * 2 - 1,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
