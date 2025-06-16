import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/enums.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/data/platform_data.dart';
import 'package:bundlegram/presentation/general_widget/app_listtile.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ChoosebillerWidget extends StatefulWidget {
  ChoosebillerWidget({
    super.key,
    this.onProviderSelected,
    required this.serviceType,
  });

  final Function(String, String)? onProviderSelected;
  final PlatformProductType serviceType;

  @override
  State<ChoosebillerWidget> createState() => _ChoosebillerWidgetState();
}

class _ChoosebillerWidgetState extends State<ChoosebillerWidget> {
  String? _selectedProviderImage;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onProviderSelected(String imagePath, String provider) {
    setState(() {
      _selectedProviderImage = imagePath;
    });
    widget.onProviderSelected?.call(imagePath, provider);
    context.pop();
  }

  List<Widget> _filterProviders(List<Widget> providers) {
    final query = _searchController.text.toLowerCase();
    if (query.isEmpty) return providers;
    return providers.where((widget) {
      final tile = widget as AppListTile;
      return tile.title.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: context.symmetricPadding(20, 0),
            child: AppTextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: (widget.serviceType == PlatformProductType.airtime ||
                        widget.serviceType == PlatformProductType.mobileData)
                    ? 'Search for biller'
                    : 'Search for provider',
              ).search(),
              onChange: (value) {
                setState(() {}); // Trigger rebuild to filter providers
              },
            ),
          ),
          30.verticalSpace,
          _buildProviderList(context),
        ],
      ),
    );
  }

  Widget _buildProviderList(BuildContext context) {
    List<Widget> providerWidgets = _getProviderWidgets(widget.serviceType);
    final filteredWidgets = _filterProviders(providerWidgets);
    return SizedBox(
      height: (widget.serviceType == PlatformProductType.betting) ? 500 : null,
      child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: filteredWidgets.length,
        itemBuilder: (context, index) {
          final tile = filteredWidgets[index] as AppListTile;
          final imagePath = tile.imagePath ?? tile.assetPath;
          if (imagePath != null) {
            return GestureDetector(
              onTap: () {
                final provider = (widget.serviceType ==
                            PlatformProductType.mobileData ||
                        widget.serviceType == PlatformProductType.airtime)
                    ? tile.title.toLowerCase().split(' ')[0]
                    : (widget.serviceType == PlatformProductType.ePinVoucher)
                        ? tile.title.split(' ')[0] + ' Voucher'
                        : tile.title;
                debugPrint('The title tile is: ${tile.title}');
                debugPrint('The selected image provider is: $imagePath');
                _onProviderSelected(imagePath, provider);
              },
              child: AppListTile(
                assetPath: tile.assetPath,
                imagePath: tile.imagePath,
                title: tile.title,
                subtitle: tile.subtitle,
                showSubtitle: tile.showSubtitle,
                isSelected: imagePath == _selectedProviderImage,
              ).withContainer(
                padding: context.symmetricPadding(0, 16.h),
                margin: context.symmetricPadding(20.w, 8.h),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  List<Widget> _getProviderWidgets(PlatformProductType type) {
    switch (type) {
      case PlatformProductType.airtime:
      case PlatformProductType.mobileData:
      case PlatformProductType.ePinVoucher:
      case PlatformProductType.bulkEPin:
        return PlatFormData.serviceProviderWidget;
      case PlatformProductType.education:
        return PlatFormData.educationProviderWidget;
      case PlatformProductType.betting:
        return PlatFormData.bettingProviders;
      case PlatformProductType.cableTv:
        return PlatFormData.cableTvProviderWidget;
      case PlatformProductType.internetServices:
        return PlatFormData.internetServiceProviderWidget;
      case PlatformProductType.electricity:
        return PlatFormData.electricityProviderWidget;
      default:
        return [];
    }
  }
}
