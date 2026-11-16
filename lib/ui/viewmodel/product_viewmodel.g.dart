// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FetchProductViewmodel)
final fetchProductViewmodelProvider = FetchProductViewmodelFamily._();

final class FetchProductViewmodelProvider
    extends
        $AsyncNotifierProvider<FetchProductViewmodel, List<FinancialProduct>> {
  FetchProductViewmodelProvider._({
    required FetchProductViewmodelFamily super.from,
    required ProductCategory super.argument,
  }) : super(
         retry: null,
         name: r'fetchProductViewmodelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$fetchProductViewmodelHash();

  @override
  String toString() {
    return r'fetchProductViewmodelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  FetchProductViewmodel create() => FetchProductViewmodel();

  @override
  bool operator ==(Object other) {
    return other is FetchProductViewmodelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fetchProductViewmodelHash() =>
    r'0fdbccbf28c9b32244d751741844343782ce0711';

final class FetchProductViewmodelFamily extends $Family
    with
        $ClassFamilyOverride<
          FetchProductViewmodel,
          AsyncValue<List<FinancialProduct>>,
          List<FinancialProduct>,
          FutureOr<List<FinancialProduct>>,
          ProductCategory
        > {
  FetchProductViewmodelFamily._()
    : super(
        retry: null,
        name: r'fetchProductViewmodelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FetchProductViewmodelProvider call(ProductCategory ctg) =>
      FetchProductViewmodelProvider._(argument: ctg, from: this);

  @override
  String toString() => r'fetchProductViewmodelProvider';
}

abstract class _$FetchProductViewmodel
    extends $AsyncNotifier<List<FinancialProduct>> {
  late final _$args = ref.$arg as ProductCategory;
  ProductCategory get ctg => _$args;

  FutureOr<List<FinancialProduct>> build(ProductCategory ctg);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<FinancialProduct>>, List<FinancialProduct>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<FinancialProduct>>,
                List<FinancialProduct>
              >,
              AsyncValue<List<FinancialProduct>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(ProductViewmodel)
final productViewmodelProvider = ProductViewmodelFamily._();

final class ProductViewmodelProvider
    extends
        $NotifierProvider<
          ProductViewmodel,
          AsyncValue<List<FinancialProduct>>
        > {
  ProductViewmodelProvider._({
    required ProductViewmodelFamily super.from,
    required ProductCategory super.argument,
  }) : super(
         retry: null,
         name: r'productViewmodelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$productViewmodelHash();

  @override
  String toString() {
    return r'productViewmodelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ProductViewmodel create() => ProductViewmodel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<List<FinancialProduct>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<List<FinancialProduct>>>(
        value,
      ),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ProductViewmodelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$productViewmodelHash() => r'436ef8120336dc79dd55a37900320390169de9d8';

final class ProductViewmodelFamily extends $Family
    with
        $ClassFamilyOverride<
          ProductViewmodel,
          AsyncValue<List<FinancialProduct>>,
          AsyncValue<List<FinancialProduct>>,
          AsyncValue<List<FinancialProduct>>,
          ProductCategory
        > {
  ProductViewmodelFamily._()
    : super(
        retry: null,
        name: r'productViewmodelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ProductViewmodelProvider call(ProductCategory ctg) =>
      ProductViewmodelProvider._(argument: ctg, from: this);

  @override
  String toString() => r'productViewmodelProvider';
}

abstract class _$ProductViewmodel
    extends $Notifier<AsyncValue<List<FinancialProduct>>> {
  late final _$args = ref.$arg as ProductCategory;
  ProductCategory get ctg => _$args;

  AsyncValue<List<FinancialProduct>> build(ProductCategory ctg);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<FinancialProduct>>,
              AsyncValue<List<FinancialProduct>>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<FinancialProduct>>,
                AsyncValue<List<FinancialProduct>>
              >,
              AsyncValue<List<FinancialProduct>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
