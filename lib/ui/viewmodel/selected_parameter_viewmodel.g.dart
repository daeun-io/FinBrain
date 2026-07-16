// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_parameter_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SelectedTopFinGrpNoViewmodel)
final selectedTopFinGrpNoViewmodelProvider =
    SelectedTopFinGrpNoViewmodelProvider._();

final class SelectedTopFinGrpNoViewmodelProvider
    extends
        $NotifierProvider<
          SelectedTopFinGrpNoViewmodel,
          Map<ProductCategory, String>
        > {
  SelectedTopFinGrpNoViewmodelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedTopFinGrpNoViewmodelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedTopFinGrpNoViewmodelHash();

  @$internal
  @override
  SelectedTopFinGrpNoViewmodel create() => SelectedTopFinGrpNoViewmodel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<ProductCategory, String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<ProductCategory, String>>(value),
    );
  }
}

String _$selectedTopFinGrpNoViewmodelHash() =>
    r'6d0f28561899cb716eacddcc7a36946bf7830753';

abstract class _$SelectedTopFinGrpNoViewmodel
    extends $Notifier<Map<ProductCategory, String>> {
  Map<ProductCategory, String> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<Map<ProductCategory, String>, Map<ProductCategory, String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                Map<ProductCategory, String>,
                Map<ProductCategory, String>
              >,
              Map<ProductCategory, String>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(SelectedBaseYearViewmodel)
final selectedBaseYearViewmodelProvider = SelectedBaseYearViewmodelProvider._();

final class SelectedBaseYearViewmodelProvider
    extends
        $NotifierProvider<
          SelectedBaseYearViewmodel,
          Map<ProductCategory, int>
        > {
  SelectedBaseYearViewmodelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedBaseYearViewmodelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedBaseYearViewmodelHash();

  @$internal
  @override
  SelectedBaseYearViewmodel create() => SelectedBaseYearViewmodel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<ProductCategory, int> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<ProductCategory, int>>(value),
    );
  }
}

String _$selectedBaseYearViewmodelHash() =>
    r'f30080c5813ca6fa427f906db13da4c51f39a3ec';

abstract class _$SelectedBaseYearViewmodel
    extends $Notifier<Map<ProductCategory, int>> {
  Map<ProductCategory, int> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<Map<ProductCategory, int>, Map<ProductCategory, int>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Map<ProductCategory, int>, Map<ProductCategory, int>>,
              Map<ProductCategory, int>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
