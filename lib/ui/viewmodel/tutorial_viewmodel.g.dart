// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tutorial_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DetailTutorialViewmodel)
final detailTutorialViewmodelProvider = DetailTutorialViewmodelProvider._();

final class DetailTutorialViewmodelProvider
    extends $NotifierProvider<DetailTutorialViewmodel, int> {
  DetailTutorialViewmodelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'detailTutorialViewmodelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$detailTutorialViewmodelHash();

  @$internal
  @override
  DetailTutorialViewmodel create() => DetailTutorialViewmodel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$detailTutorialViewmodelHash() =>
    r'73ef27d3f51abdb996f93ce322d581ac0cc9d51e';

abstract class _$DetailTutorialViewmodel extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
