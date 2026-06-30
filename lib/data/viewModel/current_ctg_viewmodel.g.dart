// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_ctg_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CurrentCtgViewmodel)
final currentCtgViewmodelProvider = CurrentCtgViewmodelProvider._();

final class CurrentCtgViewmodelProvider
    extends $NotifierProvider<CurrentCtgViewmodel, ProductCategory> {
  CurrentCtgViewmodelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentCtgViewmodelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentCtgViewmodelHash();

  @$internal
  @override
  CurrentCtgViewmodel create() => CurrentCtgViewmodel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProductCategory value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProductCategory>(value),
    );
  }
}

String _$currentCtgViewmodelHash() =>
    r'7eff21baf16c35a714f170210b36f6982fab6ffc';

abstract class _$CurrentCtgViewmodel extends $Notifier<ProductCategory> {
  ProductCategory build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ProductCategory, ProductCategory>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ProductCategory, ProductCategory>,
              ProductCategory,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
