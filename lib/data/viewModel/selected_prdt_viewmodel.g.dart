// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_prdt_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SelectedProductsViewmodel)
final selectedProductsViewmodelProvider = SelectedProductsViewmodelProvider._();

final class SelectedProductsViewmodelProvider
    extends
        $NotifierProvider<SelectedProductsViewmodel, List<FinancialProduct>> {
  SelectedProductsViewmodelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedProductsViewmodelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedProductsViewmodelHash();

  @$internal
  @override
  SelectedProductsViewmodel create() => SelectedProductsViewmodel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<FinancialProduct> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<FinancialProduct>>(value),
    );
  }
}

String _$selectedProductsViewmodelHash() =>
    r'aaaf25ea7fb7a8b892460d61abaa1f156d0014a3';

abstract class _$SelectedProductsViewmodel
    extends $Notifier<List<FinancialProduct>> {
  List<FinancialProduct> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<List<FinancialProduct>, List<FinancialProduct>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<FinancialProduct>, List<FinancialProduct>>,
              List<FinancialProduct>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
