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
    r'a4a33d423d0858a21c3078588be2ea022acb6291';

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
