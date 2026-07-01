// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isa_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(IsaJoinStatusViewModel)
final isaJoinStatusViewModelProvider = IsaJoinStatusViewModelProvider._();

final class IsaJoinStatusViewModelProvider
    extends
        $AsyncNotifierProvider<
          IsaJoinStatusViewModel,
          (int, List<IsaJoinStatus>)
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
}

String _$isaJoinStatusViewModelHash() =>
    r'b70547728bce3beb1c9f9dbbaff2f1778b2e35bc';

abstract class _$IsaJoinStatusViewModel
    extends $AsyncNotifier<(int, List<IsaJoinStatus>)> {
  FutureOr<(int, List<IsaJoinStatus>)> build();
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
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(IsaManagementStatusViewModel)
final isaManagementStatusViewModelProvider =
    IsaManagementStatusViewModelProvider._();

final class IsaManagementStatusViewModelProvider
    extends
        $AsyncNotifierProvider<
          IsaManagementStatusViewModel,
          (int, List<IsaManagementStatus>)
        > {
  IsaManagementStatusViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isaManagementStatusViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isaManagementStatusViewModelHash();

  @$internal
  @override
  IsaManagementStatusViewModel create() => IsaManagementStatusViewModel();
}

String _$isaManagementStatusViewModelHash() =>
    r'6684db96d5cbafdc9603e38bf5b85c750882ea1d';

abstract class _$IsaManagementStatusViewModel
    extends $AsyncNotifier<(int, List<IsaManagementStatus>)> {
  FutureOr<(int, List<IsaManagementStatus>)> build();
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
    return element.handleCreate(ref, build);
  }
}
