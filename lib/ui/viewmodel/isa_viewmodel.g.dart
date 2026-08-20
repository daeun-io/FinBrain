// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isa_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FetchIsaJoinStatusViewmodel)
final fetchIsaJoinStatusViewmodelProvider =
    FetchIsaJoinStatusViewmodelFamily._();

final class FetchIsaJoinStatusViewmodelProvider
    extends
        $AsyncNotifierProvider<
          FetchIsaJoinStatusViewmodel,
          (int, List<IsaJoinStatus>)
        > {
  FetchIsaJoinStatusViewmodelProvider._({
    required FetchIsaJoinStatusViewmodelFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'fetchIsaJoinStatusViewmodelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$fetchIsaJoinStatusViewmodelHash();

  @override
  String toString() {
    return r'fetchIsaJoinStatusViewmodelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  FetchIsaJoinStatusViewmodel create() => FetchIsaJoinStatusViewmodel();

  @override
  bool operator ==(Object other) {
    return other is FetchIsaJoinStatusViewmodelProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fetchIsaJoinStatusViewmodelHash() =>
    r'82fc56ee8a46c2f47a02152458882afad79ae9d2';

final class FetchIsaJoinStatusViewmodelFamily extends $Family
    with
        $ClassFamilyOverride<
          FetchIsaJoinStatusViewmodel,
          AsyncValue<(int, List<IsaJoinStatus>)>,
          (int, List<IsaJoinStatus>),
          FutureOr<(int, List<IsaJoinStatus>)>,
          int
        > {
  FetchIsaJoinStatusViewmodelFamily._()
    : super(
        retry: null,
        name: r'fetchIsaJoinStatusViewmodelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FetchIsaJoinStatusViewmodelProvider call(int pageNo) =>
      FetchIsaJoinStatusViewmodelProvider._(argument: pageNo, from: this);

  @override
  String toString() => r'fetchIsaJoinStatusViewmodelProvider';
}

abstract class _$FetchIsaJoinStatusViewmodel
    extends $AsyncNotifier<(int, List<IsaJoinStatus>)> {
  late final _$args = ref.$arg as int;
  int get pageNo => _$args;

  FutureOr<(int, List<IsaJoinStatus>)> build(int pageNo);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<(int, List<IsaJoinStatus>)>,
              (int, List<IsaJoinStatus>)
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<(int, List<IsaJoinStatus>)>,
                (int, List<IsaJoinStatus>)
              >,
              AsyncValue<(int, List<IsaJoinStatus>)>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(FetchIsaMngmStatusViewmodel)
final fetchIsaMngmStatusViewmodelProvider =
    FetchIsaMngmStatusViewmodelFamily._();

final class FetchIsaMngmStatusViewmodelProvider
    extends
        $AsyncNotifierProvider<
          FetchIsaMngmStatusViewmodel,
          (int, List<IsaManagementStatus>)
        > {
  FetchIsaMngmStatusViewmodelProvider._({
    required FetchIsaMngmStatusViewmodelFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'fetchIsaMngmStatusViewmodelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$fetchIsaMngmStatusViewmodelHash();

  @override
  String toString() {
    return r'fetchIsaMngmStatusViewmodelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  FetchIsaMngmStatusViewmodel create() => FetchIsaMngmStatusViewmodel();

  @override
  bool operator ==(Object other) {
    return other is FetchIsaMngmStatusViewmodelProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fetchIsaMngmStatusViewmodelHash() =>
    r'203c1e55d7d995e1d053a4659ab765df840a4a0c';

final class FetchIsaMngmStatusViewmodelFamily extends $Family
    with
        $ClassFamilyOverride<
          FetchIsaMngmStatusViewmodel,
          AsyncValue<(int, List<IsaManagementStatus>)>,
          (int, List<IsaManagementStatus>),
          FutureOr<(int, List<IsaManagementStatus>)>,
          int
        > {
  FetchIsaMngmStatusViewmodelFamily._()
    : super(
        retry: null,
        name: r'fetchIsaMngmStatusViewmodelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FetchIsaMngmStatusViewmodelProvider call(int pageNo) =>
      FetchIsaMngmStatusViewmodelProvider._(argument: pageNo, from: this);

  @override
  String toString() => r'fetchIsaMngmStatusViewmodelProvider';
}

abstract class _$FetchIsaMngmStatusViewmodel
    extends $AsyncNotifier<(int, List<IsaManagementStatus>)> {
  late final _$args = ref.$arg as int;
  int get pageNo => _$args;

  FutureOr<(int, List<IsaManagementStatus>)> build(int pageNo);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<(int, List<IsaManagementStatus>)>,
              (int, List<IsaManagementStatus>)
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<(int, List<IsaManagementStatus>)>,
                (int, List<IsaManagementStatus>)
              >,
              AsyncValue<(int, List<IsaManagementStatus>)>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(IsaStatusViewmodel)
final isaStatusViewmodelProvider = IsaStatusViewmodelFamily._();

final class IsaStatusViewmodelProvider
    extends
        $NotifierProvider<IsaStatusViewmodel, AsyncValue<(int, List<Object>)>> {
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
  Override overrideWithValue(AsyncValue<(int, List<Object>)> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<(int, List<Object>)>>(
        value,
      ),
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
    r'3ba456a792d1d7bbabdb4ee65931d510591bf71f';

final class IsaStatusViewmodelFamily extends $Family
    with
        $ClassFamilyOverride<
          IsaStatusViewmodel,
          AsyncValue<(int, List<Object>)>,
          AsyncValue<(int, List<Object>)>,
          AsyncValue<(int, List<Object>)>,
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
    extends $Notifier<AsyncValue<(int, List<Object>)>> {
  late final _$args = ref.$arg as ProductCategory;
  ProductCategory get category => _$args;

  AsyncValue<(int, List<Object>)> build(ProductCategory category);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<(int, List<Object>)>,
              AsyncValue<(int, List<Object>)>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<(int, List<Object>)>,
                AsyncValue<(int, List<Object>)>
              >,
              AsyncValue<(int, List<Object>)>,
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
