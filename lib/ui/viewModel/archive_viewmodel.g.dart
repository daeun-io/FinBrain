// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'archive_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ArchiveSummaryViewmodel)
final archiveSummaryViewmodelProvider = ArchiveSummaryViewmodelProvider._();

final class ArchiveSummaryViewmodelProvider
    extends $AsyncNotifierProvider<ArchiveSummaryViewmodel, List<AiRecord>> {
  ArchiveSummaryViewmodelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'archiveSummaryViewmodelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$archiveSummaryViewmodelHash();

  @$internal
  @override
  ArchiveSummaryViewmodel create() => ArchiveSummaryViewmodel();
}

String _$archiveSummaryViewmodelHash() =>
    r'6b6caa0992b6ff495ca8ddccc26a3dc241c07b90';

abstract class _$ArchiveSummaryViewmodel
    extends $AsyncNotifier<List<AiRecord>> {
  FutureOr<List<AiRecord>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<AiRecord>>, List<AiRecord>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<AiRecord>>, List<AiRecord>>,
              AsyncValue<List<AiRecord>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(SelectedCtgForArchiveViewmodel)
final selectedCtgForArchiveViewmodelProvider =
    SelectedCtgForArchiveViewmodelProvider._();

final class SelectedCtgForArchiveViewmodelProvider
    extends
        $NotifierProvider<
          SelectedCtgForArchiveViewmodel,
          List<ProductCategory>
        > {
  SelectedCtgForArchiveViewmodelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedCtgForArchiveViewmodelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedCtgForArchiveViewmodelHash();

  @$internal
  @override
  SelectedCtgForArchiveViewmodel create() => SelectedCtgForArchiveViewmodel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<ProductCategory> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<ProductCategory>>(value),
    );
  }
}

String _$selectedCtgForArchiveViewmodelHash() =>
    r'2666740efbb6089b24b344587bf465b6cb20325e';

abstract class _$SelectedCtgForArchiveViewmodel
    extends $Notifier<List<ProductCategory>> {
  List<ProductCategory> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<List<ProductCategory>, List<ProductCategory>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<ProductCategory>, List<ProductCategory>>,
              List<ProductCategory>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(AiCompViewmodel)
final aiCompViewmodelProvider = AiCompViewmodelProvider._();

final class AiCompViewmodelProvider
    extends $AsyncNotifierProvider<AiCompViewmodel, List<AiRecord>> {
  AiCompViewmodelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'aiCompViewmodelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$aiCompViewmodelHash();

  @$internal
  @override
  AiCompViewmodel create() => AiCompViewmodel();
}

String _$aiCompViewmodelHash() => r'6e885e2e69d44b1ba4c2b92e396dcac8b6cf70c4';

abstract class _$AiCompViewmodel extends $AsyncNotifier<List<AiRecord>> {
  FutureOr<List<AiRecord>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<AiRecord>>, List<AiRecord>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<AiRecord>>, List<AiRecord>>,
              AsyncValue<List<AiRecord>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(ArchiveComparisonViewmodel)
final archiveComparisonViewmodelProvider =
    ArchiveComparisonViewmodelProvider._();

final class ArchiveComparisonViewmodelProvider
    extends
        $NotifierProvider<
          ArchiveComparisonViewmodel,
          AsyncValue<List<AiRecord>>
        > {
  ArchiveComparisonViewmodelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'archiveComparisonViewmodelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$archiveComparisonViewmodelHash();

  @$internal
  @override
  ArchiveComparisonViewmodel create() => ArchiveComparisonViewmodel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<List<AiRecord>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<List<AiRecord>>>(value),
    );
  }
}

String _$archiveComparisonViewmodelHash() =>
    r'545807b84713d2eb0173ef8a69f048ec41c697be';

abstract class _$ArchiveComparisonViewmodel
    extends $Notifier<AsyncValue<List<AiRecord>>> {
  AsyncValue<List<AiRecord>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<AiRecord>>, AsyncValue<List<AiRecord>>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<AiRecord>>,
                AsyncValue<List<AiRecord>>
              >,
              AsyncValue<List<AiRecord>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
