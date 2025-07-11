import 'package:bundlegram/core/utils/platform_provider_enums.dart';

extension PlatformProductTypeExt on PlatformProductType {
  bool get hasSubProducts {
    switch (this) {
      case PlatformProductType.mobileData:
      case PlatformProductType.cableTv:
      case PlatformProductType.internetServices:
      case PlatformProductType.ePinVoucher:
        return true;
      default:
        return false;
    }
  }

  String get title {
    switch (this) {
      case PlatformProductType.mobileData:
        return 'Mobile Data';
      case PlatformProductType.airtime:
        return 'Airtime';
      case PlatformProductType.betting:
        return 'Betting';
      case PlatformProductType.cableTv:
        return 'Cable TV';
      case PlatformProductType.electricity:
        return 'Electricity';
      case PlatformProductType.education:
        return 'Education';
      case PlatformProductType.internetServices:
        return 'Internet Services';
      case PlatformProductType.ePinVoucher:
        return 'E-Pin Voucher';
      case PlatformProductType.bulkEPin:
        return 'Bulk E-Pin';
    }
  }
}
