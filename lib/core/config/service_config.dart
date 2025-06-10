import 'package:bundlegram/core/utils/enums.dart';
import 'package:bundlegram/data/models/service_config_model.dart';

class ServiceConfigs {
  static final Map<PlatformProductType, ServiceConfig> configs = {
    PlatformProductType.mobileData: ServiceConfig(
      title: 'Buy Data',
      type: PlatformProductType.mobileData,
      bundles: [
        {'data': '100MB', 'duration': '1 Day'},
        {'data': '200MB', 'duration': '3 Days'},
        {'data': '1GB', 'duration': '1 Day'},
        {'data': '2.5GB', 'duration': '2 Days'},
        {'data': '5GB', 'duration': '7 Days'},
        {'data': '3GB', 'duration': '30 Days'},
      ],
      inputHint: 'Phone Number',
      dropdownHint: 'SME',
    ),
    PlatformProductType.airtime: ServiceConfig(
      title: 'Buy Airtime',
      type: PlatformProductType.airtime,
      bundles: [
        {'amount': '₦100', 'duration': ''},
        {'amount': '₦200', 'duration': ''},
        {'amount': '₦500', 'duration': ''},
        {'amount': '₦1,000', 'duration': ''},
      ],
      inputHint: 'Phone Number',
    ),
    PlatformProductType.betting: ServiceConfig(
      title: 'Betting',
      type: PlatformProductType.betting,
      bundles: [
        {'amount': '₦200', 'duration': ''},
        {'amount': '₦500', 'duration': ''},
        {'amount': '₦1,000', 'duration': ''},
        {'amount': '₦2,000', 'duration': ''},
        {'amount': '₦5,000', 'duration': ''},
        {'amount': '₦10,000', 'duration': ''},
      ],
      inputHint: 'Betting biller',
      secondaryInputHint: 'User ID',
    ),
    PlatformProductType.electricity: ServiceConfig(
      title: 'Electricity',
      type: PlatformProductType.electricity,
      bundles: [
        {'amount': '₦1,000', 'duration': ''},
        {'amount': '₦2,000', 'duration': ''},
        {'amount': '₦3,000', 'duration': ''},
        {'amount': '₦5,000', 'duration': ''},
        {'amount': '₦10,000', 'duration': ''},
        {'amount': '₦20,000', 'duration': ''},
      ],
      inputHint: 'Meter Number',
      secondaryInputHint: 'Prepaid',
    ),
    PlatformProductType.education: ServiceConfig(
      title: 'Education',
      type: PlatformProductType.education,
      bundles: [],
      inputHint: 'Select sub product',
      secondaryInputHint: 'Transaction ID',
    ),
    PlatformProductType.cableTv: ServiceConfig(
      title: 'Cable Tv',
      type: PlatformProductType.cableTv,
      bundles: [],
      inputHint: 'Smart card number',
      dropdownHint: 'Startimes Plus Web Access',
    ),
    PlatformProductType.internetServices: ServiceConfig(
      title: 'Internet Services',
      type: PlatformProductType.internetServices,
      bundles: [
        {'data': '10GB', 'duration': '30 Days'},
        {'data': '20GB', 'duration': '60 Days'},
      ],
      inputHint: 'Smile account number',
      dropdownHint: 'Select an option',
    ),
    PlatformProductType.ePinVoucher: ServiceConfig(
      title: 'E-PIN Voucher',
      type: PlatformProductType.ePinVoucher,
      bundles: [],
      inputHint: 'Amount',
    ),
    PlatformProductType.bulkEPin: ServiceConfig(
      title: 'Bulk E-PIN',
      type: PlatformProductType.bulkEPin,
      bundles: [],
      inputHint: 'Agent name',
      secondaryInputHint: 'Agent email',
      dropdownHint: 'Network',
    ),
  };
}
