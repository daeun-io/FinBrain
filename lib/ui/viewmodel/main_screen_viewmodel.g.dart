// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_screen_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MainScreenViewmodel)
final mainScreenViewmodelProvider = MainScreenViewmodelProvider._();

final class MainScreenViewmodelProvider
    extends $NotifierProvider<MainScreenViewmodel, bool> {
  MainScreenViewmodelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mainScreenViewmodelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mainScreenViewmodelHash();

  @$internal
  @override
  MainScreenViewmodel create() => MainScreenViewmodel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$mainScreenViewmodelHash() =>
    r'61b4cd6cc0b1c6c20c542b4400c4a7db85d15000';

abstract class _$MainScreenViewmodel extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
