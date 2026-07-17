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
    required String super.argument,
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
    r'ea12d3f8790fe012e0d177fef60a23f44838406a';

final class FetchIsaJoinStatusViewmodelFamily extends $Family
    with
        $ClassFamilyOverride<
          FetchIsaJoinStatusViewmodel,
          AsyncValue<(int, List<IsaJoinStatus>)>,
          (int, List<IsaJoinStatus>),
          FutureOr<(int, List<IsaJoinStatus>)>,
          String
        > {
  FetchIsaJoinStatusViewmodelFamily._()
    : super(
        retry: null,
        name: r'fetchIsaJoinStatusViewmodelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FetchIsaJoinStatusViewmodelProvider call(String pageNo) =>
      FetchIsaJoinStatusViewmodelProvider._(argument: pageNo, from: this);

  @override
  String toString() => r'fetchIsaJoinStatusViewmodelProvider';
}

abstract class _$FetchIsaJoinStatusViewmodel
    extends $AsyncNotifier<(int, List<IsaJoinStatus>)> {
  late final _$args = ref.$arg as String;
  String get pageNo => _$args;

  FutureOr<(int, List<IsaJoinStatus>)> build(String pageNo);
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

@ProviderFor(IsaJoinStatusViewModel)
final isaJoinStatusViewModelProvider = IsaJoinStatusViewModelFamily._();

final class IsaJoinStatusViewModelProvider
    extends
        $NotifierProvider<
          IsaJoinStatusViewModel,
          AsyncValue<(int, List<IsaJoinStatus>)>
        > {
  IsaJoinStatusViewModelProvider._({
    required IsaJoinStatusViewModelFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'isaJoinStatusViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$isaJoinStatusViewModelHash();

  @override
  String toString() {
    return r'isaJoinStatusViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  IsaJoinStatusViewModel create() => IsaJoinStatusViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<(int, List<IsaJoinStatus>)> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<AsyncValue<(int, List<IsaJoinStatus>)>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is IsaJoinStatusViewModelProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$isaJoinStatusViewModelHash() =>
    r'0d1ce882ad3a1bac510c13a3f98166de76e3a639';

final class IsaJoinStatusViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          IsaJoinStatusViewModel,
          AsyncValue<(int, List<IsaJoinStatus>)>,
          AsyncValue<(int, List<IsaJoinStatus>)>,
          AsyncValue<(int, List<IsaJoinStatus>)>,
          String
        > {
  IsaJoinStatusViewModelFamily._()
    : super(
        retry: null,
        name: r'isaJoinStatusViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  IsaJoinStatusViewModelProvider call(String pageNo) =>
      IsaJoinStatusViewModelProvider._(argument: pageNo, from: this);

  @override
  String toString() => r'isaJoinStatusViewModelProvider';
}

abstract class _$IsaJoinStatusViewModel
    extends $Notifier<AsyncValue<(int, List<IsaJoinStatus>)>> {
  late final _$args = ref.$arg as String;
  String get pageNo => _$args;

  AsyncValue<(int, List<IsaJoinStatus>)> build(String pageNo);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<(int, List<IsaJoinStatus>)>,
              AsyncValue<(int, List<IsaJoinStatus>)>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<(int, List<IsaJoinStatus>)>,
                AsyncValue<(int, List<IsaJoinStatus>)>
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
    required String super.argument,
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
    r'444cdd63f23652ddab7bbba44d8b7cbf41b46da1';

final class FetchIsaMngmStatusViewmodelFamily extends $Family
    with
        $ClassFamilyOverride<
          FetchIsaMngmStatusViewmodel,
          AsyncValue<(int, List<IsaManagementStatus>)>,
          (int, List<IsaManagementStatus>),
          FutureOr<(int, List<IsaManagementStatus>)>,
          String
        > {
  FetchIsaMngmStatusViewmodelFamily._()
    : super(
        retry: null,
        name: r'fetchIsaMngmStatusViewmodelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FetchIsaMngmStatusViewmodelProvider call(String pageNo) =>
      FetchIsaMngmStatusViewmodelProvider._(argument: pageNo, from: this);

  @override
  String toString() => r'fetchIsaMngmStatusViewmodelProvider';
}

abstract class _$FetchIsaMngmStatusViewmodel
    extends $AsyncNotifier<(int, List<IsaManagementStatus>)> {
  late final _$args = ref.$arg as String;
  String get pageNo => _$args;

  FutureOr<(int, List<IsaManagementStatus>)> build(String pageNo);
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

@ProviderFor(IsaManagementStatusViewModel)
final isaManagementStatusViewModelProvider =
    IsaManagementStatusViewModelFamily._();

final class IsaManagementStatusViewModelProvider
    extends
        $NotifierProvider<
          IsaManagementStatusViewModel,
          AsyncValue<(int, List<IsaManagementStatus>)>
        > {
  IsaManagementStatusViewModelProvider._({
    required IsaManagementStatusViewModelFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'isaManagementStatusViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$isaManagementStatusViewModelHash();

  @override
  String toString() {
    return r'isaManagementStatusViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  IsaManagementStatusViewModel create() => IsaManagementStatusViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(
    AsyncValue<(int, List<IsaManagementStatus>)> value,
  ) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<AsyncValue<(int, List<IsaManagementStatus>)>>(
            value,
          ),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is IsaManagementStatusViewModelProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$isaManagementStatusViewModelHash() =>
    r'6cd65869a843a86e38e006fd841d24da06550703';

final class IsaManagementStatusViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          IsaManagementStatusViewModel,
          AsyncValue<(int, List<IsaManagementStatus>)>,
          AsyncValue<(int, List<IsaManagementStatus>)>,
          AsyncValue<(int, List<IsaManagementStatus>)>,
          String
        > {
  IsaManagementStatusViewModelFamily._()
    : super(
        retry: null,
        name: r'isaManagementStatusViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  IsaManagementStatusViewModelProvider call(String pageNo) =>
      IsaManagementStatusViewModelProvider._(argument: pageNo, from: this);

  @override
  String toString() => r'isaManagementStatusViewModelProvider';
}

abstract class _$IsaManagementStatusViewModel
    extends $Notifier<AsyncValue<(int, List<IsaManagementStatus>)>> {
  late final _$args = ref.$arg as String;
  String get pageNo => _$args;

  AsyncValue<(int, List<IsaManagementStatus>)> build(String pageNo);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<(int, List<IsaManagementStatus>)>,
              AsyncValue<(int, List<IsaManagementStatus>)>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<(int, List<IsaManagementStatus>)>,
                AsyncValue<(int, List<IsaManagementStatus>)>
              >,
              AsyncValue<(int, List<IsaManagementStatus>)>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
