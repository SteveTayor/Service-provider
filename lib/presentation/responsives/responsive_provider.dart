import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'responsive_types.dart';

final responsiveInfoProvider = Provider.family<ResponsiveInfo, BuildContext>(
  (ref, context) => ResponsiveInfo.fromContext(context),
);

class ResponsiveInfo {
  final Size size;
  final DeviceType deviceType;
  final double scaleFactor;
  final Orientation orientation;
  final EdgeInsets safeArea;
  final double textScaleFactor;

  ResponsiveInfo._({
    required this.size,
    required this.deviceType,
    required this.scaleFactor,
    required this.orientation,
    required this.safeArea,
    required this.textScaleFactor,
  });

  factory ResponsiveInfo.fromContext(
    BuildContext context, {
    ResponsiveConfig config = const ResponsiveConfig(),
  }) {
    final mq = MediaQuery.of(context);
    final width = mq.size.width;
    final height = mq.size.height;

    // Determine device type
    DeviceType deviceType;
    if (width <= config.phoneMaxWidth) {
      deviceType = DeviceType.phone;
    } else if (width <= config.tabletMaxWidth) {
      deviceType = DeviceType.tablet;
    } else {
      deviceType = DeviceType.desktop;
    }

    // Calculate scale factor based on device type and orientation
    double scaleFactor;
    double textScaleFactor;

    switch (deviceType) {
      case DeviceType.phone:
        scaleFactor = 1.0;
        textScaleFactor = 1.0;
        break;
      case DeviceType.tablet:
        // Adjust for orientation on tablets
        if (mq.orientation == Orientation.landscape) {
          scaleFactor = (width / 900).clamp(1.0, 1.15);
          textScaleFactor = 0.97;
        } else {
          scaleFactor = (width / 700).clamp(0.95, 1.1);
          textScaleFactor = 0.97;
        }
        break;
      case DeviceType.desktop:
        scaleFactor = (width / 1200).clamp(1.1, 1.6);
        textScaleFactor = 1.0;
        break;
    }

    return ResponsiveInfo._(
      size: mq.size,
      deviceType: deviceType,
      scaleFactor: scaleFactor,
      orientation: mq.orientation,
      safeArea: mq.padding,
      textScaleFactor: textScaleFactor,
    );
  }

  // Device type checks
  bool get isPhone => deviceType == DeviceType.phone;
  bool get isTablet => deviceType == DeviceType.tablet;
  bool get isDesktop => deviceType == DeviceType.desktop;

  // Orientation checks
  bool get isLandscape => orientation == Orientation.landscape;
  bool get isPortrait => orientation == Orientation.portrait;

  // Screen size categories
  bool get isSmallScreen => size.width < 360;
  bool get isMediumScreen => size.width >= 360 && size.width < 768;
  bool get isLargeScreen => size.width >= 768;

  // Responsive sizing methods
  double spacing(double base) => base * scaleFactor;
  double textSize(double base) => base * scaleFactor;
  double iconSize({double base = 24}) => base * scaleFactor;
  double radiusSize(double base) => base * scaleFactor;

  EdgeInsets padding({
    double? all,
    double? horizontal,
    double? vertical,
    double? left,
    double? right,
    double? top,
    double? bottom,
  }) {
    return EdgeInsets.only(
      left: (left ?? horizontal ?? all ?? 0) * scaleFactor,
      right: (right ?? horizontal ?? all ?? 0) * scaleFactor,
      top: (top ?? vertical ?? all ?? 0) * scaleFactor,
      bottom: (bottom ?? vertical ?? all ?? 0) * scaleFactor,
    );
  }

  // Column count for grid layouts
  int get gridColumns {
    if (isPhone) return isPortrait ? 1 : 2;
    if (isTablet) return isPortrait ? 2 : 3;
    return isPortrait ? 3 : 4;
  }

  // Helper to get responsive value based on device
  T when<T>({
    required T phone,
    T? tablet,
    T? desktop,
  }) {
    if (isDesktop) return desktop ?? tablet ?? phone;
    if (isTablet) return tablet ?? phone;
    return phone;
  }
}
