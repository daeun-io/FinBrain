// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isa_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FetchIsaJoinStatusViewmodel)
final fetchIsaJoinStatusViewmodelProvider =
    FetchIsaJoinStatusViewmodelProvider._();

final class FetchIsaJoinStatusViewmodelProvider
    extends
        $AsyncNotifierProvider<
          FetchIsaJoinStatusViewmodel,
          List<IsaJoinStatus>
        > {
  FetchIsaJoinStatusViewmodelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fetchIsaJoinStatusViewmodelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fetchIsaJoinStatusViewmodelHash();

  @$internal
  @override
  FetchIsaJoinStatusViewmodel create() => FetchIsaJoinStatusViewmodel();
}

String _$fetchIsaJoinStatusViewmodelHash() =>
    r'51ad67abbad0fbc9c2b767a2de9e9839b55c6e09';

abstract class _$FetchIsaJoinStatusViewmodel
    extends $AsyncNotifier<List<IsaJoinStatus>> {
  FutureOr<List<IsaJoinStatus>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<IsaJoinStatus>>, List<IsaJoinStatus>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<IsaJoinStatus>>, List<IsaJoinStatus>>,
              AsyncValue<List<IsaJoinStatus>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(FetchIsaMngmStatusViewmodel)
final fetchIsaMngmStatusViewmodelProvider =
    FetchIsaMngmStatusViewmodelProvider._();

final class FetchIsaMngmStatusViewmodelProvider
    extends
        $AsyncNotifierProvider<
          FetchIsaMngmStatusViewmodel,
          List<IsaManagementStatus>
        > {
  FetchIsaMngmStatusViewmodelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fetchIsaMngmStatusViewmodelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fetchIsaMngmStatusViewmodelHash();

  @$internal
  @override
  FetchIsaMngmStatusViewmodel create() => FetchIsaMngmStatusViewmodel();
}

String _$fetchIsaMngmStatusViewmodelHash() =>
    r'3bd1b742e8c407fd55e5378179d07d84c461b128';

abstract class _$FetchIsaMngmStatusViewmodel
    extends $AsyncNotifier<List<IsaManagementStatus>> {
  FutureOr<List<IsaManagementStatus>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<IsaManagementStatus>>,
              List<IsaManagementStatus>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<IsaManagementStatus>>,
                List<IsaManagementStatus>
              >,
              AsyncValue<List<IsaManagementStatus>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(IsaStatusViewmodel)
final isaStatusViewmodelProvider = IsaStatusViewmodelFamily._();

final class IsaStatusViewmodelProvider
    extends $NotifierProvider<IsaStatusViewmodel, AsyncValue<List<Object>>> {
  IsaStatusViewmodelProvider._({
    required IsaStatusViewmodelFamily super.from,
    required ProductCategory super.argument,
  }) : super(
         retry: null,
         name: r'isaStatusViewmodelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$isaStatusViewmodelHash();

  @override
  String toString() {
    return r'isaStatusViewmodelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  IsaStatusViewmodel create() => IsaStatusViewmodel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<List<Object>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<List<Object>>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is IsaStatusViewmodelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$isaStatusViewmodelHash() =>
    r'000fe525511ac315503337f55b48d62737175ae4';

final class IsaStatusViewmodelFamily extends $Family
    with
        $ClassFamilyOverride<
          IsaStatusViewmodel,
          AsyncValue<List<Object>>,
          AsyncValue<List<Object>>,
          AsyncValue<List<Object>>,
          ProductCategory
        > {
  IsaStatusViewmodelFamily._()
    : super(
        retry: null,
        name: r'isaStatusViewmodelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  IsaStatusViewmodelProvider call(ProductCategory category) =>
      IsaStatusViewmodelProvider._(argument: category, from: this);

  @override
  String toString() => r'isaStatusViewmodelProvider';
}

abstract class _$IsaStatusViewmodel
    extends $Notifier<AsyncValue<List<Object>>> {
  late final _$args = ref.$arg as ProductCategory;
  ProductCategory get category => _$args;

  AsyncValue<List<Object>> build(ProductCategory category);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<Object>>, AsyncValue<List<Object>>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Object>>, AsyncValue<List<Object>>>,
              AsyncValue<List<Object>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(IsaTutorialViemodel)
final isaTutorialViemodelProvider = IsaTutorialViemodelProvider._();

final class IsaTutorialViemodelProvider
    extends $AsyncNotifierProvider<IsaTutorialViemodel, bool> {
  IsaTutorialViemodelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isaTutorialViemodelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isaTutorialViemodelHash();

  @$internal
  @override
  IsaTutorialViemodel create() => IsaTutorialViemodel();
}

String _$isaTutorialViemodelHash() =>
    r'dc0dcd36e1c1e13b9b2f0bfaa2ac882565bb2901';

abstract class _$IsaTutorialViemodel extends $AsyncNotifier<bool> {
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
