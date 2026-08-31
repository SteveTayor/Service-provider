// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version_manager.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(versionManager)
final versionManagerProvider = VersionManagerProvider._();

final class VersionManagerProvider
    extends $FunctionalProvider<VersionManager, VersionManager, VersionManager>
    with $Provider<VersionManager> {
  VersionManagerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'versionManagerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$versionManagerHash();

  @$internal
  @override
  $ProviderElement<VersionManager> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  VersionManager create(Ref ref) {
    return versionManager(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VersionManager value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VersionManager>(value),
    );
  }
}

String _$versionManagerHash() => r'53f3c80dc49e86bd1eb7fd29e98407884172ac3c';
