// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'liked_product_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FetchLikedViewmodel)
final fetchLikedViewmodelProvider = FetchLikedViewmodelProvider._();

final class FetchLikedViewmodelProvider
    extends
        $AsyncNotifierProvider<FetchLikedViewmodel, List<FinancialProduct>> {
  FetchLikedViewmodelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fetchLikedViewmodelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fetchLikedViewmodelHash();

  @$internal
  @override
  FetchLikedViewmodel create() => FetchLikedViewmodel();
}

String _$fetchLikedViewmodelHash() =>
    r'ef2c66f46804bfaff1b8c9cfe0b6e013ac01096f';

abstract class _$FetchLikedViewmodel
    extends $AsyncNotifier<List<FinancialProduct>> {
  FutureOr<List<FinancialProduct>> build();
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
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(LikedProductViewmodel)
final likedProductViewmodelProvider = LikedProductViewmodelProvider._();

final class LikedProductViewmodelProvider
    extends
        $AsyncNotifierProvider<LikedProductViewmodel, List<FinancialProduct>> {
  LikedProductViewmodelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'likedProductViewmodelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$likedProductViewmodelHash();

  @$internal
  @override
  LikedProductViewmodel create() => LikedProductViewmodel();
}

String _$likedProductViewmodelHash() =>
    r'94780d8b484898fc2445fcd586fab7eb5d8cd56d';

abstract class _$LikedProductViewmodel
    extends $AsyncNotifier<List<FinancialProduct>> {
  FutureOr<List<FinancialProduct>> build();
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
    return element.handleCreate(ref, build);
  }
}
