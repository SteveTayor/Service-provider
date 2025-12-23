import 'package:bundlegram/presentation/responsives/responsive_provider.dart';
import 'package:flutter/widgets.dart';

extension ResponsiveContext on BuildContext {
  ResponsiveInfo get responsive => ResponsiveInfo.fromContext(this);

  // Quick access helpers
  bool get isPhone => responsive.isPhone;
  bool get isTablet => responsive.isTablet;
  bool get isDesktop => responsive.isDesktop;
  bool get isLandscape => responsive.isLandscape;
  bool get isPortrait => responsive.isPortrait;

  // Sizing helpers
  double rSpacing(double base) => responsive.spacing(base);
  double rText(double base) => responsive.textSize(base);
  double rIcon({double base = 24}) => responsive.iconSize(base: base);

  EdgeInsets rPadding({
    double? all,
    double? horizontal,
    double? vertical,
    double? left,
    double? right,
    double? top,
    double? bottom,
  }) =>
      responsive.padding(
        all: all,
        horizontal: horizontal,
        vertical: vertical,
        left: left,
        right: right,
        top: top,
        bottom: bottom,
      );
}

extension ResponsiveTextExtension on Text {
  Text responsive(BuildContext context, {double? fontSize}) {
    final responsive = context.responsive;
    final currentStyle = style ?? const TextStyle();

    return Text(
      data ?? '',
      style: currentStyle.copyWith(
        fontSize: fontSize != null
            ? responsive.textSize(fontSize)
            : currentStyle.fontSize != null
                ? responsive.textSize(currentStyle.fontSize!)
                : null,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
