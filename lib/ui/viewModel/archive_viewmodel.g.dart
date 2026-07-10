// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'archive_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SelectedCtgForSummariesViewmodel)
final selectedCtgForSummariesViewmodelProvider =
    SelectedCtgForSummariesViewmodelProvider._();

final class SelectedCtgForSummariesViewmodelProvider
    extends
        $NotifierProvider<
          SelectedCtgForSummariesViewmodel,
          List<ProductCategory>
        > {
  SelectedCtgForSummariesViewmodelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedCtgForSummariesViewmodelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedCtgForSummariesViewmodelHash();

  @$internal
  @override
  SelectedCtgForSummariesViewmodel create() =>
      SelectedCtgForSummariesViewmodel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<ProductCategory> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<ProductCategory>>(value),
    );
  }
}

String _$selectedCtgForSummariesViewmodelHash() =>
    r'1e47aa69f65d5dc5179595ae026d2c87541bff0b';

abstract class _$SelectedCtgForSummariesViewmodel
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

@ProviderFor(AiSummariesViewmodel)
final aiSummariesViewmodelProvider = AiSummariesViewmodelProvider._();

final class AiSummariesViewmodelProvider
    extends $AsyncNotifierProvider<AiSummariesViewmodel, List<AiRecord>> {
  AiSummariesViewmodelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'aiSummariesViewmodelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$aiSummariesViewmodelHash();

  @$internal
  @override
  AiSummariesViewmodel create() => AiSummariesViewmodel();
}

String _$aiSummariesViewmodelHash() =>
    r'e6eb807f39da3a85d0d13066f81a80d152e1895c';

abstract class _$AiSummariesViewmodel extends $AsyncNotifier<List<AiRecord>> {
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

@ProviderFor(ArchiveSummaryViewmodel)
final archiveSummaryViewmodelProvider = ArchiveSummaryViewmodelProvider._();

final class ArchiveSummaryViewmodelProvider
    extends
        $NotifierProvider<ArchiveSummaryViewmodel, AsyncValue<List<AiRecord>>> {
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

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<List<AiRecord>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<List<AiRecord>>>(value),
    );
  }
}

String _$archiveSummaryViewmodelHash() =>
    r'ce23c0af69f9e372b7e2c7d1e5ae9d82a8f295a8';

abstract class _$ArchiveSummaryViewmodel
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

@ProviderFor(SelectedCtgForCompTextViewmodel)
final selectedCtgForCompTextViewmodelProvider =
    SelectedCtgForCompTextViewmodelProvider._();

final class SelectedCtgForCompTextViewmodelProvider
    extends
        $NotifierProvider<
          SelectedCtgForCompTextViewmodel,
          List<ProductCategory>
        > {
  SelectedCtgForCompTextViewmodelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedCtgForCompTextViewmodelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedCtgForCompTextViewmodelHash();

  @$internal
  @override
  SelectedCtgForCompTextViewmodel create() => SelectedCtgForCompTextViewmodel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<ProductCategory> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<ProductCategory>>(value),
    );
  }
}

String _$selectedCtgForCompTextViewmodelHash() =>
    r'ffae3c52f64c64a81165248fbc64fc6cb79979a9';

abstract class _$SelectedCtgForCompTextViewmodel
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

String _$aiCompViewmodelHash() => r'a3ecbe0d1bb9445cfe373acd84e32c303c3bdc98';

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
    r'7ace299eba29402a9070c0f8791482bc06e5456b';

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
