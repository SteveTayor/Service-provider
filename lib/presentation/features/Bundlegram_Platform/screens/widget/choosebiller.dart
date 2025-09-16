// import 'package:bundlegram/core/extensions/context_extensions.dart';
// import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
// import 'package:bundlegram/core/extensions/widget_extensions.dart';
// import 'package:bundlegram/core/utils/colors.dart';
// import 'package:bundlegram/core/utils/enums.dart';
// import 'package:bundlegram/presentation/features/Bundlegram_Platform/data/platform_data.dart';
// import 'package:bundlegram/presentation/general_widget/app_listtile.dart';
// import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';

// class ChoosebillerWidget extends StatefulWidget {
//   ChoosebillerWidget({
//     super.key,
//     this.onProviderSelected,
//     required this.serviceType,
//   });

//   final Function(String, String)? onProviderSelected;
//   final PlatformProductType serviceType;

//   @override
//   State<ChoosebillerWidget> createState() => _ChoosebillerWidgetState();
// }

// class _ChoosebillerWidgetState extends State<ChoosebillerWidget> {
//   String? _selectedProviderImage;
//   final TextEditingController _searchController = TextEditingController();

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   void _onProviderSelected(String imagePath, String provider) {
//     setState(() {
//       _selectedProviderImage = imagePath;
//     });
//     widget.onProviderSelected?.call(imagePath, provider);
//     context.pop();
//   }

//   List<Widget> _filterProviders(List<Widget> providers) {
//     final query = _searchController.text.toLowerCase();
//     if (query.isEmpty) return providers;
//     return providers.where((widget) {
//       final tile = widget as AppListTile;
//       return tile.title.toLowerCase().contains(query);
//     }).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: context.symmetricPadding(20, 0),
//             child: AppTextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 hintText: (widget.serviceType == PlatformProductType.airtime ||
//                         widget.serviceType == PlatformProductType.mobileData)
//                     ? 'Search for biller'
//                     : 'Search for provider',
//               ).search(),
//               onChange: (value) {
//                 setState(() {}); // Trigger rebuild to filter providers
//               },
//             ),
//           ),
//           30.verticalSpace,
//           _buildProviderList(context),
//         ],
//       ),
//     );
//   }

//   Widget _buildProviderList(BuildContext context) {
//     List<Widget> providerWidgets = _getProviderWidgets(widget.serviceType);
//     final filteredWidgets = _filterProviders(providerWidgets);
//     return SizedBox(
//       height: (widget.serviceType == PlatformProductType.betting) ? 500 : null,
//       child: ListView.builder(
//         shrinkWrap: true,
//         padding: EdgeInsets.zero,
//         itemCount: filteredWidgets.length,
//         itemBuilder: (context, index) {
//           final tile = filteredWidgets[index] as AppListTile;
//           final imagePath = tile.imagePath ?? tile.assetPath;
//           if (imagePath != null) {
//             return GestureDetector(
//               onTap: () {
//                 final provider = (widget.serviceType ==
//                             PlatformProductType.mobileData ||
//                         widget.serviceType == PlatformProductType.airtime)
//                     ? tile.title.toLowerCase().split(' ')[0]
//                     : (widget.serviceType == PlatformProductType.ePinVoucher)
//                         ? tile.title.split(' ')[0] + ' Voucher'
//                         : tile.title;
//                 debugPrint('The title tile is: ${tile.title}');
//                 debugPrint('The selected image provider is: $imagePath');
//                 _onProviderSelected(imagePath, provider);
//               },
//               child: AppListTile(
//                 assetPath: tile.assetPath,
//                 imagePath: tile.imagePath,
//                 title: tile.title,
//                 subtitle: tile.subtitle,
//                 showSubtitle: tile.showSubtitle,
//                 isSelected: imagePath == _selectedProviderImage,
//               ).withContainer(
//                 padding: context.symmetricPadding(0, 16.h),
//                 margin: context.symmetricPadding(20.w, 8.h),
//               ),
//             );
//           }
//           return const SizedBox.shrink();
//         },
//       ),
//     );
//   }

//   List<Widget> _getProviderWidgets(PlatformProductType type) {
//     switch (type) {
//       case PlatformProductType.airtime:
//       case PlatformProductType.mobileData:
//       case PlatformProductType.ePinVoucher:
//       case PlatformProductType.bulkEPin:
//         return PlatFormData.serviceProviderWidget;
//       case PlatformProductType.education:
//         return PlatFormData.educationProviderWidget;
//       case PlatformProductType.betting:
//         return PlatFormData.bettingProviders;
//       case PlatformProductType.cableTv:
//         return PlatFormData.cableTvProviderWidget;
//       case PlatformProductType.internetServices:
//         return PlatFormData.internetServiceProviderWidget;
//       case PlatformProductType.electricity:
//         return PlatFormData.electricityProviderWidget;
//       default:
//         return [];
//     }
//   }
// }

import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/enums.dart';
import 'package:bundlegram/core/utils/platform_provider_enums.dart';
import 'package:bundlegram/data/models/products/get_all_products_response.dart';
import 'package:bundlegram/data/models/products/get_sub_products_response.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/provider/platform_product_provider.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/provider/products_provider.dart';
import 'package:bundlegram/presentation/general_widget/app_listtile.dart';
import 'package:bundlegram/presentation/general_widget/app_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:go_router/go_router.dart';

class ChoosebillerWidget extends ConsumerWidget {
  final PlatformProductType serviceType;
  final void Function(
    String? imagePath,
    String name,
    int productId,
  ) onProviderSelected;

  const ChoosebillerWidget({
    super.key,
    required this.serviceType,
    required this.onProviderSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(platformProductProvider(serviceType));
    final productsAsync = ref.watch(productsProvider(serviceType));
    final notifier = ref.read(
        platformProductProvider(serviceType).notifier); // Define notifier here
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Choose Biller',
            style: context.textTheme.titleSmall!.copyWith(
              // fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
          24.verticalSpace,
          productsAsync.when(
            loading: () => const AppLoader(),
            error: (err, _) => Text(
              'Failed to load providers',
              style:
                  context.textTheme.bodySmall!.copyWith(color: AppColors.error),
            ),
            data: (resp) {
              if (serviceType == PlatformProductType.betting ||
                  serviceType == PlatformProductType.ePinVoucher) {
                final products = resp.data ?? [];
                if (products.isEmpty) {
                  return Text('No providers available',
                      style: context.textTheme.bodySmall);
                }

                // Only fetch subproducts for the first product (assuming betting only uses one)
                final productId = products.first.id!;

                if (productId == null) {
                  print('Error: First product ID is null');
                  return Text('Invalid product ID',
                      style: context.textTheme.bodySmall!
                          .copyWith(color: AppColors.error));
                }
                final subProductsAsync =
                    ref.watch(subProductsProvider(productId));

                return subProductsAsync.when(
                  data: (subResp) {
                    final items = subResp.data ?? [];
                    if (items.isEmpty) {
                      return Text('No providers available',
                          style: context.textTheme.bodySmall);
                    }

                    return SizedBox(
                      height: 450.h,
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: AlwaysScrollableScrollPhysics(),
                        itemCount: items.length,
                        separatorBuilder: (_, __) => 40.verticalSpace,
                        itemBuilder: (_, index) {
                          final item = items[index];
                          final name = item.subName ?? '';
                          final imagePath = ref
                              .read(
                                  platformProductProvider(serviceType).notifier)
                              .normalizeAssetName(name,
                                  serviceType: serviceType);
                          // Check if imagePath contains '.svg'
                          final isSvg =
                              imagePath?.toLowerCase().contains('.svg') ??
                                  false;

                          return AppListTile(
                            assetPath: isSvg
                                ? imagePath
                                : null, // Use imagePath as assetPath for SVGs
                            imagePath: isSvg
                                ? null
                                : imagePath, // Use imagePath for non-SVGs
                            subtitle: item.subName,
                            onPressed: () {
                              debugPrint(
                                  '[BETTING] onPressed -> tapped "$name"');

                              final notifier = ref.read(
                                  platformProductProvider(serviceType)
                                      .notifier);

                              final products = ref
                                      .read(productsProvider(serviceType))
                                      .value
                                      ?.data ??
                                  [];
                              debugPrint(
                                  '[BETTING] Products length = ${products.length}');

                              final product =
                                  products.isNotEmpty ? products.first : null;

                              if (product == null) {
                                debugPrint(
                                    '[BETTING] ❌ product is null, not continuing');
                                return;
                              }

                              debugPrint(
                                  '[BETTING] ✅ selecting productId=${product.id} name=${product.productName}');
                              notifier
                                ..selectProduct(product, imagePath ?? '')
                                ..selectSubProduct(item);

                              debugPrint(
                                  '[BETTING] calling onProviderSelected...');
                              // onProviderSelected(imagePath, name, product.id!);
                              // pass the subproduct id for betting
                              try {
                                onProviderSelected(
                                    imagePath, name, product.id!);
                              } catch (e, st) {
                                debugPrint(
                                    '[BETTING] onProviderSelected threw: $e');
                                debugPrintStack(stackTrace: st);
                              }

                              debugPrint('[BETTING] calling Navigator.pop...');
                              Navigator.of(context).pop();
                              debugPrint('[BETTING] ✅ pop called');
//                               final notifier = ref.read(
//                                   platformProductProvider(serviceType)
//                                       .notifier);

// // Manually select the first product (since betting has only one product)
//                               final products = ref
//                                       .read(productsProvider(serviceType))
//                                       .value
//                                       ?.data ??
//                                   [];
//                               final product =
//                                   products.isNotEmpty ? products.first : null;

//                               if (product != null) {
//                                 notifier
//                                   ..selectProduct(
//                                     product,
//                                     imagePath ?? '',
//                                   )
//                                   ..selectSubProduct(
//                                     item,
//                                   ); // ← this is what was missing

//                                 onProviderSelected(
//                                   imagePath,
//                                   name,
//                                   product.id!,
//                                 );

//                                 Navigator.of(context).pop();
                              // }
                            },
                            title: name,
                          );
                        },
                      ),
                    );
                  },
                  loading: () => const AppLoader(),
                  error: (_, __) => Text('Failed to load subproducts',
                      style: context.textTheme.bodySmall!
                          .copyWith(color: AppColors.error)),
                );
              }

              // For internetServices, filter products with subproducts
              if (serviceType == PlatformProductType.internetServices) {
                final products = (resp.data ?? [])
                    .where((p) => p.status == '1')
                    .toList(); // Define products here
                return FutureBuilder<List<Product>>(
                  future:
                      _filterProductsWithSubproducts(ref, products, notifier),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const AppLoader();
                    }
                    if (snapshot.hasError) {
                      return Text(
                        'Error loading providers',
                        style: context.textTheme.bodySmall!
                            .copyWith(color: AppColors.error),
                      );
                    }
                    final filteredProducts = snapshot.data ?? [];
                    if (filteredProducts.isEmpty) {
                      return Text(
                        'No providers with available plans',
                        style: context.textTheme.bodySmall,
                      );
                    }

                    return SizedBox(
                      height: 250.h,
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: filteredProducts.length,
                        separatorBuilder: (_, __) => 24.verticalSpace,
                        itemBuilder: (_, index) {
                          final item = filteredProducts[index];
                          final name = item.productName ?? '';
                          final imagePath = notifier.normalizeAssetName(name,
                              serviceType: serviceType);
                          final isSvg =
                              imagePath?.toLowerCase().contains('.svg') ??
                                  false;

                          return AppListTile(
                            assetPath: isSvg ? imagePath : null,
                            imagePath: isSvg ? null : imagePath,
                            subtitle: item.productName,
                            onPressed: () {
                              onProviderSelected(imagePath, name, item.id!);
                              Navigator.of(context).pop();
                            },
                            title: name,
                          );
                        },
                      ),
                    );
                  },
                );
              }

              // For all others
              final items =
                  (resp.data ?? []).where((p) => p.status == '1').toList();

              if (items.isEmpty) {
                return Text('No providers available',
                    style: context.textTheme.bodySmall);
              }

              return SizedBox(
                height: (serviceType == PlatformProductType.electricity)
                    ? 450.h
                    : null,
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: items.length,
                  separatorBuilder: (_, __) => 24.verticalSpace,
                  itemBuilder: (_, index) {
                    final item = items[index];
                    final name = item.productName ?? '';
                    final imagePath = ref
                        .read(platformProductProvider(serviceType).notifier)
                        .normalizeAssetName(name, serviceType: serviceType);

                    // Check if imagePath contains '.svg'
                    final isSvg =
                        imagePath?.toLowerCase().contains('.svg') ?? false;

                    return AppListTile(
                      assetPath: isSvg
                          ? imagePath
                          : null, // Use imagePath as assetPath for SVGs
                      imagePath: isSvg
                          ? null
                          : imagePath, // Use imagePath for non-SVGs

                      subtitle: item.productName,
                      onPressed: () {
                        onProviderSelected(imagePath, name, item.id!);
                        Navigator.of(context).pop();
                      },
                      title: name,
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<List<Product>> _filterProductsWithSubproducts(
    WidgetRef ref,
    List<Product> products,
    PlatformProductNotifier notifier,
  ) async {
    final filtered = <Product>[];
    for (var product in products) {
      if (await notifier.hasSubProducts(product.id!)) {
        filtered.add(product);
      }
    }
    return filtered;
  }
}
