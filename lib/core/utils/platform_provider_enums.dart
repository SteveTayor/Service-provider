enum PlatformProductType {
  mobileData,
  airtime,
  betting,
  electricity,
  education,
  cableTv,
  internetServices,
  ePinVoucher,
  bulkEPin,
}

extension PlatformProductTypeExt on PlatformProductType {
  bool get hasSubProducts {
    switch (this) {
      case PlatformProductType.airtime:
        return true; // Enable subproducts for airtime
      case PlatformProductType.mobileData:
        return true;
      case PlatformProductType.betting:
        return true;
      case PlatformProductType.cableTv:
        return true;
      case PlatformProductType.electricity:
        return true;
      case PlatformProductType.education:
        return true;
      case PlatformProductType.internetServices:
        return true;
      case PlatformProductType.ePinVoucher:
      case PlatformProductType.bulkEPin:
        return false;
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
