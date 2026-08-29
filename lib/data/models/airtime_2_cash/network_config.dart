import 'package:equatable/equatable.dart';

/// Represents a telco network as configured for the Airtime-to-Cash feature.
///
/// Availability is expressed as data (`isAvailable`, `hasActiveConfig`)
/// rather than being branched on in the UI via `if (network == Network.glo)`.
/// This lets the mock (and later the real API) simply flip a flag to
/// simulate an unconfigured network instead of the UI needing to know
/// which specific networks are supported.
class NetworkConfig extends Equatable {
  const NetworkConfig({
    required this.id,
    required this.name,
    required this.logoAsset,
    required this.isAvailable,
    required this.hasActiveConfig,
    required this.supportsInstantConversion,
    required this.conversionRatePercent,
    required this.minAmount,
    required this.maxAmount,
    required this.dailyLimit,
    required this.shareCode,
  });

  /// Stable identifier, e.g. 'mtn', 'airtel', 'glo', '9mobile'.
  final String id;

  final String name;

  /// SVG asset path, e.g. `Assets.svgs.mtnnw`.
  final String logoAsset;

  /// Whether this network can be selected at all in the flow.
  final bool isAvailable;

  /// Whether this network has an active Airtime-to-Cash configuration.
  /// When false, the UI should show the "No Active Airtime 2 Cash Config"
  /// state and offer "Go to Manual" instead of the instant flow.
  final bool hasActiveConfig;

  /// Whether the instant (automated) conversion flow is supported.
  final bool supportsInstantConversion;

  /// Conversion rate as a whole-number percentage, e.g. 83 for 83%.
  final int conversionRatePercent;

  final double minAmount;
  final double maxAmount;
  final double dailyLimit;

  /// The USSD/dial code used to set or reset the airtime share PIN,
  /// shown in the "What is Airtime Share PIN?" info dialog.
  final String shareCode;

  /// Whether the user can proceed with the instant flow for this network.
  bool get canUseInstantFlow =>
      isAvailable && hasActiveConfig && supportsInstantConversion;

  NetworkConfig copyWith({
    bool? isAvailable,
    bool? hasActiveConfig,
    bool? supportsInstantConversion,
  }) {
    return NetworkConfig(
      id: id,
      name: name,
      logoAsset: logoAsset,
      isAvailable: isAvailable ?? this.isAvailable,
      hasActiveConfig: hasActiveConfig ?? this.hasActiveConfig,
      supportsInstantConversion:
          supportsInstantConversion ?? this.supportsInstantConversion,
      conversionRatePercent: conversionRatePercent,
      minAmount: minAmount,
      maxAmount: maxAmount,
      dailyLimit: dailyLimit,
      shareCode: shareCode,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        logoAsset,
        isAvailable,
        hasActiveConfig,
        supportsInstantConversion,
        conversionRatePercent,
        minAmount,
        maxAmount,
        dailyLimit,
        shareCode,
      ];
}
