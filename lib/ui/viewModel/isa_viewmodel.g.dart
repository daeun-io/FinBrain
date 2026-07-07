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
    r'3ff474be1656e38160cb71d34246dbb8fe2ceea2';

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
    r'a57e8c120896668dcfa709c289bc4f16280863c6';

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
