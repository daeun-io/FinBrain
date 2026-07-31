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
    r'8e201928c31d8818534a3c8ac9d81818c715ea19';

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
final isaJoinStatusViewModelProvider = IsaJoinStatusViewModelProvider._();

final class IsaJoinStatusViewModelProvider
    extends
        $NotifierProvider<
          IsaJoinStatusViewModel,
          AsyncValue<(int, List<IsaJoinStatus>)>
        > {
  IsaJoinStatusViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isaJoinStatusViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isaJoinStatusViewModelHash();

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
}

String _$isaJoinStatusViewModelHash() =>
    r'f1b421833cc555c7afe16648d16b9597fbbd463d';

abstract class _$IsaJoinStatusViewModel
    extends $Notifier<AsyncValue<(int, List<IsaJoinStatus>)>> {
  AsyncValue<(int, List<IsaJoinStatus>)> build();
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
    return element.handleCreate(ref, build);
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
    r'63f5e0d8b068e916fed7062f83afbd3e5bd2bf84';

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

@ProviderFor(IsaManagementStatusViewmodel)
final isaManagementStatusViewmodelProvider =
    IsaManagementStatusViewmodelProvider._();

final class IsaManagementStatusViewmodelProvider
    extends
        $NotifierProvider<
          IsaManagementStatusViewmodel,
          AsyncValue<(int, List<IsaManagementStatus>)>
        > {
  IsaManagementStatusViewmodelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isaManagementStatusViewmodelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isaManagementStatusViewmodelHash();

  @$internal
  @override
  IsaManagementStatusViewmodel create() => IsaManagementStatusViewmodel();

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
}

String _$isaManagementStatusViewmodelHash() =>
    r'146320c4d71f62345957721e7220de3fce17376b';

abstract class _$IsaManagementStatusViewmodel
    extends $Notifier<AsyncValue<(int, List<IsaManagementStatus>)>> {
  AsyncValue<(int, List<IsaManagementStatus>)> build();
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
    return element.handleCreate(ref, build);
  }
}
