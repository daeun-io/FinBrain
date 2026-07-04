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

@ProviderFor(ArchiveComparisonViewmodel)
final archiveComparisonViewmodelProvider =
    ArchiveComparisonViewmodelProvider._();

final class ArchiveComparisonViewmodelProvider
    extends $AsyncNotifierProvider<ArchiveComparisonViewmodel, List<AiRecord>> {
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
}

String _$archiveComparisonViewmodelHash() =>
    r'248fdb530848ff80c0908e9828a9cd08bb3051f7';

abstract class _$ArchiveComparisonViewmodel
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
