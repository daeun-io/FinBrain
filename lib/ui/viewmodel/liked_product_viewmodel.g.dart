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
    r'46e49a90637f3a7c264aed992c2dfbd2df6fa2cb';

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
    r'37c4967daef303996ec4e9428183b0910f583a75';

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
