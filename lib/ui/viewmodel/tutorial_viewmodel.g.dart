// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tutorial_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DetailTutorialViewmodel)
final detailTutorialViewmodelProvider = DetailTutorialViewmodelProvider._();

final class DetailTutorialViewmodelProvider
    extends $NotifierProvider<DetailTutorialViewmodel, int> {
  DetailTutorialViewmodelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'detailTutorialViewmodelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$detailTutorialViewmodelHash();

  @$internal
  @override
  DetailTutorialViewmodel create() => DetailTutorialViewmodel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$detailTutorialViewmodelHash() =>
    r'a5774dd6582b2653c83ca3c836049fba0ea2f41f';

abstract class _$DetailTutorialViewmodel extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(AiCompTutorialViewmodel)
final aiCompTutorialViewmodelProvider = AiCompTutorialViewmodelProvider._();

final class AiCompTutorialViewmodelProvider
    extends $NotifierProvider<AiCompTutorialViewmodel, int> {
  AiCompTutorialViewmodelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'aiCompTutorialViewmodelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$aiCompTutorialViewmodelHash();

  @$internal
  @override
  AiCompTutorialViewmodel create() => AiCompTutorialViewmodel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$aiCompTutorialViewmodelHash() =>
    r'f7d337f0c7301c1b0beb2527ab24a49fefbbbea6';

abstract class _$AiCompTutorialViewmodel extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
