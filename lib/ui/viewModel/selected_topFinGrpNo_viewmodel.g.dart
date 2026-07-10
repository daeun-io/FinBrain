// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_topFinGrpNo_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SelectedTopfingrpnoViewmodel)
final selectedTopfingrpnoViewmodelProvider =
    SelectedTopfingrpnoViewmodelProvider._();

final class SelectedTopfingrpnoViewmodelProvider
    extends
        $NotifierProvider<SelectedTopfingrpnoViewmodel, Map<String, String>> {
  SelectedTopfingrpnoViewmodelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedTopfingrpnoViewmodelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedTopfingrpnoViewmodelHash();

  @$internal
  @override
  SelectedTopfingrpnoViewmodel create() => SelectedTopfingrpnoViewmodel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, String>>(value),
    );
  }
}

String _$selectedTopfingrpnoViewmodelHash() =>
    r'ac0185785d64b85c8af411ce86ef74e23030b8db';

abstract class _$SelectedTopfingrpnoViewmodel
    extends $Notifier<Map<String, String>> {
  Map<String, String> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<Map<String, String>, Map<String, String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Map<String, String>, Map<String, String>>,
              Map<String, String>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
