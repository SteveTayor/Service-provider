/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/images/logo.png');

  /// File path: assets/images/walkthrough1.png
  AssetGenImage get walkthrough1 =>
      const AssetGenImage('assets/images/walkthrough1.png');

  /// File path: assets/images/walkthrough2.png
  AssetGenImage get walkthrough2 =>
      const AssetGenImage('assets/images/walkthrough2.png');

  /// File path: assets/images/walkthrough3.png
  AssetGenImage get walkthrough3 =>
      const AssetGenImage('assets/images/walkthrough3.png');

  /// List of all assets
  List<AssetGenImage> get values =>
      [logo, walkthrough1, walkthrough2, walkthrough3];
}

class $AssetsSvgsGen {
  const $AssetsSvgsGen();

  /// File path: assets/svgs/Successful illustration.svg
  String get successfulIllustration =>
      'assets/svgs/Successful illustration.svg';

  /// File path: assets/svgs/arrow-left.svg
  String get arrowLeft => 'assets/svgs/arrow-left.svg';

  /// File path: assets/svgs/close-circle.svg
  String get closeCircle => 'assets/svgs/close-circle.svg';

  /// File path: assets/svgs/eye.svg
  String get eye => 'assets/svgs/eye.svg';

  /// File path: assets/svgs/finger-cricle.svg
  String get fingerCricle => 'assets/svgs/finger-cricle.svg';

  /// File path: assets/svgs/tick-circle.svg
  String get tickCircle => 'assets/svgs/tick-circle.svg';

  /// List of all assets
  List<String> get values => [
        successfulIllustration,
        arrowLeft,
        closeCircle,
        eye,
        fingerCricle,
        tickCircle
      ];
}

class Assets {
  const Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsSvgsGen svgs = $AssetsSvgsGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
