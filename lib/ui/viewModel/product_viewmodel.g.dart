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
        $AsyncNotifierProvider<
          FetchProductViewmodel,
          (int, List<FinancialProduct>)
        > {
  FetchProductViewmodelProvider._({
    required FetchProductViewmodelFamily super.from,
    required (ProductCategory, String) super.argument,
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
        '$argument';
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
    r'731638a1535ae74e2738f7d6a2461696156f2c72';

final class FetchProductViewmodelFamily extends $Family
    with
        $ClassFamilyOverride<
          FetchProductViewmodel,
          AsyncValue<(int, List<FinancialProduct>)>,
          (int, List<FinancialProduct>),
          FutureOr<(int, List<FinancialProduct>)>,
          (ProductCategory, String)
        > {
  FetchProductViewmodelFamily._()
    : super(
        retry: null,
        name: r'fetchProductViewmodelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FetchProductViewmodelProvider call(ProductCategory ctg, String pageNo) =>
      FetchProductViewmodelProvider._(argument: (ctg, pageNo), from: this);

  @override
  String toString() => r'fetchProductViewmodelProvider';
}

abstract class _$FetchProductViewmodel
    extends $AsyncNotifier<(int, List<FinancialProduct>)> {
  late final _$args = ref.$arg as (ProductCategory, String);
  ProductCategory get ctg => _$args.$1;
  String get pageNo => _$args.$2;

  FutureOr<(int, List<FinancialProduct>)> build(
    ProductCategory ctg,
    String pageNo,
  );
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
    return element.handleCreate(ref, () => build(_$args.$1, _$args.$2));
  }
}

@ProviderFor(ProductViewmodel)
final productViewmodelProvider = ProductViewmodelFamily._();

final class ProductViewmodelProvider
    extends
        $NotifierProvider<
          ProductViewmodel,
          AsyncValue<(int, List<FinancialProduct>)>
        > {
  ProductViewmodelProvider._({
    required ProductViewmodelFamily super.from,
    required (ProductCategory, String) super.argument,
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
        '$argument';
  }

  @$internal
  @override
  ProductViewmodel create() => ProductViewmodel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<(int, List<FinancialProduct>)> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<AsyncValue<(int, List<FinancialProduct>)>>(value),
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

String _$productViewmodelHash() => r'b28be89ec8a343bb2ef62ab4d88c702eee398f81';

final class ProductViewmodelFamily extends $Family
    with
        $ClassFamilyOverride<
          ProductViewmodel,
          AsyncValue<(int, List<FinancialProduct>)>,
          AsyncValue<(int, List<FinancialProduct>)>,
          AsyncValue<(int, List<FinancialProduct>)>,
          (ProductCategory, String)
        > {
  ProductViewmodelFamily._()
    : super(
        retry: null,
        name: r'productViewmodelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ProductViewmodelProvider call(ProductCategory ctg, String pageNo) =>
      ProductViewmodelProvider._(argument: (ctg, pageNo), from: this);

  @override
  String toString() => r'productViewmodelProvider';
}

abstract class _$ProductViewmodel
    extends $Notifier<AsyncValue<(int, List<FinancialProduct>)>> {
  late final _$args = ref.$arg as (ProductCategory, String);
  ProductCategory get ctg => _$args.$1;
  String get pageNo => _$args.$2;

  AsyncValue<(int, List<FinancialProduct>)> build(
    ProductCategory ctg,
    String pageNo,
  );
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<(int, List<FinancialProduct>)>,
              AsyncValue<(int, List<FinancialProduct>)>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<(int, List<FinancialProduct>)>,
                AsyncValue<(int, List<FinancialProduct>)>
              >,
              AsyncValue<(int, List<FinancialProduct>)>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args.$1, _$args.$2));
  }
}
