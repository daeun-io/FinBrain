// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filters_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FiltersViewmodel)
final filtersViewmodelProvider = FiltersViewmodelFamily._();

final class FiltersViewmodelProvider
    extends
        $AsyncNotifierProvider<
          FiltersViewmodel,
          Map<String, List<(String, bool)>>
        > {
  FiltersViewmodelProvider._({
    required FiltersViewmodelFamily super.from,
    required ProductCategory super.argument,
  }) : super(
         retry: null,
         name: r'filtersViewmodelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$filtersViewmodelHash();

  @override
  String toString() {
    return r'filtersViewmodelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  FiltersViewmodel create() => FiltersViewmodel();

  @override
  bool operator ==(Object other) {
    return other is FiltersViewmodelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$filtersViewmodelHash() => r'9b0564a9fa701558bf83de5cda0d5ac89636d085';

final class FiltersViewmodelFamily extends $Family
    with
        $ClassFamilyOverride<
          FiltersViewmodel,
          AsyncValue<Map<String, List<(String, bool)>>>,
          Map<String, List<(String, bool)>>,
          FutureOr<Map<String, List<(String, bool)>>>,
          ProductCategory
        > {
  FiltersViewmodelFamily._()
    : super(
        retry: null,
        name: r'filtersViewmodelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FiltersViewmodelProvider call(ProductCategory ctg) =>
      FiltersViewmodelProvider._(argument: ctg, from: this);

  @override
  String toString() => r'filtersViewmodelProvider';
}

abstract class _$FiltersViewmodel
    extends $AsyncNotifier<Map<String, List<(String, bool)>>> {
  late final _$args = ref.$arg as ProductCategory;
  ProductCategory get ctg => _$args;

  FutureOr<Map<String, List<(String, bool)>>> build(ProductCategory ctg);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<Map<String, List<(String, bool)>>>,
              Map<String, List<(String, bool)>>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<Map<String, List<(String, bool)>>>,
                Map<String, List<(String, bool)>>
              >,
              AsyncValue<Map<String, List<(String, bool)>>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(DialogFiltersViewModel)
final dialogFiltersViewModelProvider = DialogFiltersViewModelFamily._();

final class DialogFiltersViewModelProvider
    extends
        $NotifierProvider<
          DialogFiltersViewModel,
          AsyncValue<Map<String, List<(String, bool)>>>
        > {
  DialogFiltersViewModelProvider._({
    required DialogFiltersViewModelFamily super.from,
    required ProductCategory super.argument,
  }) : super(
         retry: null,
         name: r'dialogFiltersViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$dialogFiltersViewModelHash();

  @override
  String toString() {
    return r'dialogFiltersViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  DialogFiltersViewModel create() => DialogFiltersViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(
    AsyncValue<Map<String, List<(String, bool)>>> value,
  ) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<AsyncValue<Map<String, List<(String, bool)>>>>(
            value,
          ),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is DialogFiltersViewModelProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$dialogFiltersViewModelHash() =>
    r'966403b905720aadd102d8df73f3738d0be88fc2';

final class DialogFiltersViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          DialogFiltersViewModel,
          AsyncValue<Map<String, List<(String, bool)>>>,
          AsyncValue<Map<String, List<(String, bool)>>>,
          AsyncValue<Map<String, List<(String, bool)>>>,
          ProductCategory
        > {
  DialogFiltersViewModelFamily._()
    : super(
        retry: null,
        name: r'dialogFiltersViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  DialogFiltersViewModelProvider call(ProductCategory ctg) =>
      DialogFiltersViewModelProvider._(argument: ctg, from: this);

  @override
  String toString() => r'dialogFiltersViewModelProvider';
}

abstract class _$DialogFiltersViewModel
    extends $Notifier<AsyncValue<Map<String, List<(String, bool)>>>> {
  late final _$args = ref.$arg as ProductCategory;
  ProductCategory get ctg => _$args;

  AsyncValue<Map<String, List<(String, bool)>>> build(ProductCategory ctg);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<Map<String, List<(String, bool)>>>,
              AsyncValue<Map<String, List<(String, bool)>>>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<Map<String, List<(String, bool)>>>,
                AsyncValue<Map<String, List<(String, bool)>>>
              >,
              AsyncValue<Map<String, List<(String, bool)>>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(SavedFilters)
final savedFiltersProvider = SavedFiltersFamily._();

final class SavedFiltersProvider
    extends
        $AsyncNotifierProvider<
          SavedFilters,
          Map<String, List<(String, bool)>>
        > {
  SavedFiltersProvider._({
    required SavedFiltersFamily super.from,
    required ProductCategory super.argument,
  }) : super(
         retry: null,
         name: r'savedFiltersProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$savedFiltersHash();

  @override
  String toString() {
    return r'savedFiltersProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  SavedFilters create() => SavedFilters();

  @override
  bool operator ==(Object other) {
    return other is SavedFiltersProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$savedFiltersHash() => r'3467b1271f76e538a7433da317dc5f68e706650e';

final class SavedFiltersFamily extends $Family
    with
        $ClassFamilyOverride<
          SavedFilters,
          AsyncValue<Map<String, List<(String, bool)>>>,
          Map<String, List<(String, bool)>>,
          FutureOr<Map<String, List<(String, bool)>>>,
          ProductCategory
        > {
  SavedFiltersFamily._()
    : super(
        retry: null,
        name: r'savedFiltersProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  SavedFiltersProvider call(ProductCategory ctg) =>
      SavedFiltersProvider._(argument: ctg, from: this);

  @override
  String toString() => r'savedFiltersProvider';
}

abstract class _$SavedFilters
    extends $AsyncNotifier<Map<String, List<(String, bool)>>> {
  late final _$args = ref.$arg as ProductCategory;
  ProductCategory get ctg => _$args;

  FutureOr<Map<String, List<(String, bool)>>> build(ProductCategory ctg);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<Map<String, List<(String, bool)>>>,
              Map<String, List<(String, bool)>>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<Map<String, List<(String, bool)>>>,
                Map<String, List<(String, bool)>>
              >,
              AsyncValue<Map<String, List<(String, bool)>>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
