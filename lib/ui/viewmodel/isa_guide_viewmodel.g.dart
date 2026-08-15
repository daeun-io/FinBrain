// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isa_guide_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(IsaGuideViewmodel)
final isaGuideViewmodelProvider = IsaGuideViewmodelProvider._();

final class IsaGuideViewmodelProvider
    extends $AsyncNotifierProvider<IsaGuideViewmodel, bool> {
  IsaGuideViewmodelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isaGuideViewmodelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isaGuideViewmodelHash();

  @$internal
  @override
  IsaGuideViewmodel create() => IsaGuideViewmodel();
}

String _$isaGuideViewmodelHash() => r'aac38b6486d8b91af4dca4456e80ed8d57bc0238';

abstract class _$IsaGuideViewmodel extends $AsyncNotifier<bool> {
  FutureOr<bool> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<bool>, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<bool>, bool>,
              AsyncValue<bool>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(IsaGuideScreenViewmodel)
final isaGuideScreenViewmodelProvider = IsaGuideScreenViewmodelProvider._();

final class IsaGuideScreenViewmodelProvider
    extends $NotifierProvider<IsaGuideScreenViewmodel, bool> {
  IsaGuideScreenViewmodelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isaGuideScreenViewmodelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isaGuideScreenViewmodelHash();

  @$internal
  @override
  IsaGuideScreenViewmodel create() => IsaGuideScreenViewmodel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isaGuideScreenViewmodelHash() =>
    r'453545e5371dc3dbfdc3965ae9d7b6b1a656e068';

abstract class _$IsaGuideScreenViewmodel extends $Notifier<bool> {
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
