// import 'package:bundlegram/core/utils/enums.dart';
// import 'package:bundlegram/data/models/service_config_model.dart';

// class ServiceConfigs {
//   static final Map<PlatformProductType, ServiceConfig> configs = {
//     PlatformProductType.mobileData: ServiceConfig(
//         title: 'Buy Data',
//         type: PlatformProductType.mobileData,
//         bundles: [
//           {'data': '100MB', 'duration': '1 Day', 'price': '₦120'},
//           {'data': '200MB', 'duration': '3 Days', 'price': '₦220'},
//           {'data': '1GB', 'duration': '1 Day', 'price': '₦520'},
//           {'data': '2.5GB', 'duration': '2 Days', 'price': '₦920'},
//           {'data': '5GB', 'duration': '7 Days', 'price': '₦2020'},
//           {'data': '3GB', 'duration': '30 Days', 'price': '₦1520'},
//         ],
//         inputHint: 'Phone Number',
//         dropdownHint: 'SME',
//         dropdownOptions: ['SME']),
//     PlatformProductType.airtime: ServiceConfig(
//       title: 'Buy Airtime',
//       type: PlatformProductType.airtime,
//       bundles: [
//         {'amount': '₦200', 'duration': ''},
//         {'amount': '₦500', 'duration': ''},
//         {'amount': '₦1000', 'duration': ''},
//         {'amount': '₦2000', 'duration': ''},
//         {'amount': '₦5000', 'duration': ''},
//         {'amount': '₦10000', 'duration': ''},
//       ],
//       inputHint: 'Phone Number',
//     ),
//     PlatformProductType.betting: ServiceConfig(
//       title: 'Betting',
//       type: PlatformProductType.betting,
//       bundles: [
//         {'amount': '₦200', 'duration': ''},
//         {'amount': '₦500', 'duration': ''},
//         {'amount': '₦1,000', 'duration': ''},
//         {'amount': '₦2,000', 'duration': ''},
//         {'amount': '₦5,000', 'duration': ''},
//         {'amount': '₦10,000', 'duration': ''},
//       ],
//       inputHint: 'Betting biller',
//       secondaryInputHint: 'User ID',
//     ),
//     PlatformProductType.electricity: ServiceConfig(
//         title: 'Electricity',
//         type: PlatformProductType.electricity,
//         bundles: [
//           {'amount': '₦1,000', 'duration': ''},
//           {'amount': '₦2,000', 'duration': ''},
//           {'amount': '₦3,000', 'duration': ''},
//           {'amount': '₦5,000', 'duration': ''},
//           {'amount': '₦10,000', 'duration': ''},
//           {'amount': '₦20,000', 'duration': ''},
//         ],
//         inputHint: '',
//         secondaryInputHint: 'Meter Number',
//         tabs: ['Prepaid', 'Postpaid']),
//     PlatformProductType.education: ServiceConfig(
//       title: 'Education',
//       type: PlatformProductType.education,
//       bundles: [],
//       inputHint: 'Select sub product',
//       secondaryInputHint: 'Transaction ID',
//       dropdownHint: 'Select sub product',
//       dropdownOptions: [
//         'WAEC scratch card',
//       ],
//     ),
//     PlatformProductType.cableTv: ServiceConfig(
//       title: 'Cable Tv',
//       type: PlatformProductType.cableTv,
//       bundles: [],
//       inputHint: '',
//       secondaryInputHint: 'Smart card number',
//       dropdownHint: 'Startimes Plus Web Access',
//       dropdownOptions: ['Startimes Plus Web Access', 'GoTv Plus', 'GoTv Jolly'],
//     ),
//     PlatformProductType.internetServices: ServiceConfig(
//         title: 'Internet Services',
//         type: PlatformProductType.internetServices,
//         // bundles: [
//         //   {'data': '10GB', 'duration': '30 Days', 'price': '₦15,020'},
//         //   {'data': '20GB', 'duration': '60 Days', 'price': '₦30,020'},
//         // ],
//         inputHint: '',
//         secondaryInputHint: 'Smile account number',
//         dropdownHint: 'Select an option',
//         dropdownOptions: ['SME']),
//     PlatformProductType.ePinVoucher: ServiceConfig(
//       title: 'E-PIN Voucher',
//       type: PlatformProductType.ePinVoucher,
//       bundles: [],
//       inputHint: 'Amount',
//     ),
//     PlatformProductType.bulkEPin: ServiceConfig(
//       title: 'Bulk E-PIN',
//       type: PlatformProductType.bulkEPin,
//       bundles: [],
//       inputHint: 'Agent name',
//       secondaryInputHint: 'Agent email',
//       dropdownHint: 'Network',
//     ),
//   };
// }
