// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProductViewmodel)
final productViewmodelProvider = ProductViewmodelProvider._();

final class ProductViewmodelProvider
    extends
        $AsyncNotifierProvider<
          ProductViewmodel,
          (int, List<FinancialProduct>)
        > {
  ProductViewmodelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'productViewmodelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$productViewmodelHash();

  @$internal
  @override
  ProductViewmodel create() => ProductViewmodel();
}

String _$productViewmodelHash() => r'b95ec993d219ee024616a094f2d8c65b026b6660';

abstract class _$ProductViewmodel
    extends $AsyncNotifier<(int, List<FinancialProduct>)> {
  FutureOr<(int, List<FinancialProduct>)> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<(int, List<FinancialProduct>)>,
              (int, List<FinancialProduct>)
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<(int, List<FinancialProduct>)>,
                (int, List<FinancialProduct>)
              >,
              AsyncValue<(int, List<FinancialProduct>)>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
