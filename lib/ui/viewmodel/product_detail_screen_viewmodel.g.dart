// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_detail_screen_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProductDetailScreenViewmodel)
final productDetailScreenViewmodelProvider =
    ProductDetailScreenViewmodelProvider._();

final class ProductDetailScreenViewmodelProvider
    extends $AsyncNotifierProvider<ProductDetailScreenViewmodel, bool> {
  ProductDetailScreenViewmodelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'productDetailScreenViewmodelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$productDetailScreenViewmodelHash();

  @$internal
  @override
  ProductDetailScreenViewmodel create() => ProductDetailScreenViewmodel();
}

String _$productDetailScreenViewmodelHash() =>
    r'7d444d97b66ea6cc43d92fef730740c36648b56d';

abstract class _$ProductDetailScreenViewmodel extends $AsyncNotifier<bool> {
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
