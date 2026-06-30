// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'searched_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SearchedViewmodel)
final searchedViewmodelProvider = SearchedViewmodelProvider._();

final class SearchedViewmodelProvider
    extends $NotifierProvider<SearchedViewmodel, List<String>> {
  SearchedViewmodelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchedViewmodelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchedViewmodelHash();

  @$internal
  @override
  SearchedViewmodel create() => SearchedViewmodel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<String>>(value),
    );
  }
}

String _$searchedViewmodelHash() => r'f14151ad30b313ee412f88270da682082423ef7f';

abstract class _$SearchedViewmodel extends $Notifier<List<String>> {
  List<String> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<List<String>, List<String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<String>, List<String>>,
              List<String>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
