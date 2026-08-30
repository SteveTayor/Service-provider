// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'secure_storage_helper.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(secureStorageHelper)
final secureStorageHelperProvider = SecureStorageHelperProvider._();

final class SecureStorageHelperProvider
    extends
        $FunctionalProvider<
          SecureStorageHelper,
          SecureStorageHelper,
          SecureStorageHelper
        >
    with $Provider<SecureStorageHelper> {
  SecureStorageHelperProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'secureStorageHelperProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$secureStorageHelperHash();

  @$internal
  @override
  $ProviderElement<SecureStorageHelper> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SecureStorageHelper create(Ref ref) {
    return secureStorageHelper(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SecureStorageHelper value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SecureStorageHelper>(value),
    );
  }
}

String _$secureStorageHelperHash() =>
    r'80201b5fa36434275759265a8c8da31bf0ccaa43';
