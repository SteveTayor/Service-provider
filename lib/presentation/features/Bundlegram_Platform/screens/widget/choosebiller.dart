import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/utils/enums.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/data/platform_data.dart';
import 'package:bundlegram/presentation/general_widget/app_listtile.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChoosebillerWidget extends StatelessWidget {
  const ChoosebillerWidget({
    super.key,
    this.onProviderSelected,
    this.imagePaths,
    required this.serviceType, // Add serviceType parameter
  });

  final Function(String, String)? onProviderSelected;
  final List<String>? imagePaths;
  final PlatformProductType? serviceType; // Required parameter

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: context.symmetricPadding(20, 0),
          child: AppTextField(
            hintText: 'Search for biller',
            decoration: const InputDecoration().search(),
          ),
        ),
        30.verticalSpace,
        _buildProviderList(context),
      ],
    );
  }

  Widget _buildProviderList(BuildContext context) {
    switch (serviceType) {
      case PlatformProductType.airtime:
      case PlatformProductType.mobileData:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
              List.generate(PlatFormData.serviceProviderWidget.length, (index) {
            final tile =
                PlatFormData.serviceProviderWidget[index] as AppListTile;
            final imagePath = tile.assetPath; //?? tile.assetPath;
            if (imagePaths == null ||
                (imagePath != null && imagePaths!.contains(imagePath))) {
              return GestureDetector(
                onTap: () {
                  final provider = tile.title
                      .toLowerCase()
                      .split(' ')[0]; // e.g., "mtn" from "MTN Nigeria"
                  onProviderSelected?.call(imagePath!, provider);
                  Navigator.pop(context);
                },
                child: tile.withContainer(
                  padding: context.symmetricPadding(0, 10.h),
                  margin: context.symmetricPadding(20.w, 8.h),
                ),
              );
            }
            return const SizedBox.shrink();
          }),
        );
      case PlatformProductType.education:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(PlatFormData.educationProviderWidget.length,
              (index) {
            final tile =
                PlatFormData.educationProviderWidget[index] as AppListTile;
            final imagePath = tile.assetPath; //?? tile.assetPath;
            if (imagePaths == null ||
                (imagePath != null && imagePaths!.contains(imagePath))) {
              return GestureDetector(
                onTap: () {
                  final provider = tile.title.toLowerCase().split(' ')[0];
                  onProviderSelected?.call(imagePath!, provider);
                  Navigator.pop(context);
                },
                child: tile.withContainer(
                  padding: context.symmetricPadding(0, 10.h),
                  margin: context.symmetricPadding(20.w, 8.h),
                ),
              );
            }
            return const SizedBox.shrink();
          }),
        );
      case PlatformProductType.betting:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
              List.generate(PlatFormData.bettingProviders.length, (index) {
            final tile = PlatFormData.bettingProviders[index] as AppListTile;
            final imagePath = tile.assetPath; // Assuming betting uses assetPath
            if (imagePaths == null ||
                (imagePath != null && imagePaths!.contains(imagePath))) {
              return GestureDetector(
                onTap: () {
                  final provider = tile.title.toLowerCase().split(' ')[0];
                  onProviderSelected?.call(imagePath!, provider);
                  Navigator.pop(context);
                },
                child: tile.withContainer(
                  padding: context.symmetricPadding(0, 10.h),
                  margin: context.symmetricPadding(20.w, 8.h),
                ),
              );
            }
            return const SizedBox.shrink();
          }),
        );
      case PlatformProductType.cableTv:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
              List.generate(PlatFormData.cableTvProviderWidget.length, (index) {
            final tile =
                PlatFormData.cableTvProviderWidget[index] as AppListTile;
            final imagePath = tile.assetPath;
            if (imagePaths == null ||
                (imagePath != null && imagePaths!.contains(imagePath))) {
              return GestureDetector(
                onTap: () {
                  final provider = tile.title.toLowerCase().split(' ')[0];
                  onProviderSelected?.call(imagePath!, provider);
                  Navigator.pop(context);
                },
                child: tile.withContainer(
                  padding: context.symmetricPadding(0, 10.h),
                  margin: context.symmetricPadding(20.w, 8.h),
                ),
              );
            }
            return const SizedBox.shrink();
          }),
        );
      case PlatformProductType.internetServices:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
              PlatFormData.internetServiceProviderWidget.length, (index) {
            final tile = PlatFormData.internetServiceProviderWidget[index]
                as AppListTile;
            final imagePath = tile.assetPath;
            if (imagePaths == null ||
                (imagePath != null && imagePaths!.contains(imagePath))) {
              return GestureDetector(
                onTap: () {
                  final provider = tile.title.toLowerCase().split(' ')[0];
                  onProviderSelected?.call(imagePath!, provider);
                  Navigator.pop(context);
                },
                child: tile.withContainer(
                  padding: context.symmetricPadding(0, 10.h),
                  margin: context.symmetricPadding(20.w, 8.h),
                ),
              );
            }
            return const SizedBox.shrink();
          }),
        );
      case PlatformProductType.electricity:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(PlatFormData.electricityProviderWidget.length,
              (index) {
            final tile =
                PlatFormData.electricityProviderWidget[index] as AppListTile;
            final imagePath = tile.assetPath;
            if (imagePaths == null ||
                (imagePath != null && imagePaths!.contains(imagePath))) {
              return GestureDetector(
                onTap: () {
                  final provider = tile.title.toLowerCase().split(' ')[0];
                  onProviderSelected?.call(imagePath!, provider);
                  Navigator.pop(context);
                },
                child: tile.withContainer(
                  padding: context.symmetricPadding(0, 10.h),
                  margin: context.symmetricPadding(20.w, 8.h),
                ),
              );
            }
            return const SizedBox.shrink();
          }),
        );
      default:
        return const SizedBox.shrink(); // Default case for unsupported types
    }
  }
}
