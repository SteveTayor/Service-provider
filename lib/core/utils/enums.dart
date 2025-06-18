import 'package:bundlegram/gen/assets.gen.dart';

enum LoadState { loading, idle, success, error, loadmore, done }

enum HomeSessionState {
  logout,
  initial,
  authenticated
} // Added authenticated for user state

enum PinScreenMode {
  create,
  confirm,
  validate,
}

enum SecurityToggleType {
  faceId,
  fingerprintLogin,
  fingerprintPayment,
}

enum NotificationType {
  promo,
  transaction,
  payment,
  system,
}

enum OverLayType { loader, message, none }

enum MessageType {
  error,
  success,
  warning,
  info
} // Added warning and info for more feedback types

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
  // userPrice,
  // platformPrice,
}

enum UserAction { create, update, delete, read } // Added read for completeness

enum WalletTransactionType { topUp, withdrawal }

enum ServiceProvider { mtn, airtel, glo, a9mobile }

enum educationProvider { jamb, waec }

enum cableTvProvider { dstv, startimes, gotv }

enum electricityProvider {
  EkoPHCN,
  IbadanElectricity,
  EnuguPHCN,
  IkejaElectricity
}

enum internetServiceProvider { smileBundle, spectranet }

extension LoadStateExtension on LoadState {
  bool get isLoading => this == LoadState.loading;
  bool get isLoaded => this == LoadState.success;
  bool get isError => this == LoadState.error;
  bool get isInitial => this == LoadState.idle;
  bool get isLoadMore => this == LoadState.loadmore;
  bool get isCompleted => this == LoadState.done;
}

extension UserActionExtension on UserAction {
  bool get isCreate => this == UserAction.create;
  bool get isUpdate => this == UserAction.update;
  bool get isDelete => this == UserAction.delete;
  bool get isRead => this == UserAction.read;
}

extension PlatformProductTypeExtension on PlatformProductType {
  // bool get isUserPrice => this == PlatformProductType.userPrice;
  // bool get isPlatformPrice => this == PlatformProductType.platformPrice;
  bool get requiresProviderSelection => [
        PlatformProductType.mobileData,
        PlatformProductType.airtime,
        PlatformProductType.ePinVoucher,
        PlatformProductType.bulkEPin,
        PlatformProductType.internetServices,
        PlatformProductType.betting,
        PlatformProductType.electricity,
        PlatformProductType.cableTv,
        PlatformProductType.education,
      ].contains(this);
}

extension WalletTransactionTypeExtension on WalletTransactionType {
  bool get isTopUp => this == WalletTransactionType.topUp;
  bool get isWithdrawal => this == WalletTransactionType.withdrawal;
}

// extension ServiceProviderExtension on ServiceProvider {
//   String get imagePath {
//     switch (this) {
//       case ServiceProvider.mtn:
//         return Assets.svgs.mtnLogo;
//       case ServiceProvider.airtel:
//         return Assets.svgs.airtel;
//       case ServiceProvider.glo:
//         return Assets.svgs.glo;
//       case ServiceProvider.a9mobile:
//         return Assets.svgs.a9mobile;
//     }
//   }
// }

// extension educationProviderExtension on educationProvider {
//   String get imagePath {
//     switch (this) {
//       case educationProvider.jamb:
//         return Assets.svgs.jamb;
//       case educationProvider.waec:
//         return Assets.svgs.waec;
//     }
//   }
// }

// extension internetServiceProviderExtension on internetServiceProvider {
//   String get imagePath {
//     switch (this) {
//       case internetServiceProvider.smileBundle:
//         return Assets.svgs.smile;
//       case internetServiceProvider.spectranet:
//         return Assets.svgs.spectranet;
//     }
//   }
// }

// extension cableTvProviderExtension on cableTvProvider {
//   String get imagePath {
//     switch (this) {
//       case cableTvProvider.dstv:
//         return Assets.svgs.dstv;
//       case cableTvProvider.startimes:
//         return Assets.svgs.startimes;
//       case cableTvProvider.gotv:
//         return Assets.svgs.gotv;
//     }
//   }
// }

// extension electricityProviderExtension on electricityProvider {
//   String get imagePath {
//     switch (this) {
//       case electricityProvider.EnuguPHCN:
//         return Assets.svgs.eedc;
//       case electricityProvider.EkoPHCN:
//         return Assets.svgs.ekoElectricity;
//       case electricityProvider.IbadanElectricity:
//         return Assets.svgs.ibedc;
//       case electricityProvider.IkejaElectricity:
//         return Assets.svgs.ikejaElectricity;
//     }
//   }
// }
