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
    r'10ffb1997377b95d6a258220ba94a9c5d0503b29';

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
    r'2bfa89316f9c1eac8134352b8b915d82cce51c8c';

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
    r'39c31ec86e0d4a92e347ca4fe8f9b383f7d929cd';

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
    r'261f4de6c48dc986464dc3dde768547c900a5a39';

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

String _$aiCompViewmodelHash() => r'ca0b7d8d851520aa2a580e018e582453be4524b4';

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
    r'eb1a0348f780eec16607029488b1626bdc8028db';

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
