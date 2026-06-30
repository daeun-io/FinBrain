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
    required FilterTextCategory super.argument,
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

String _$filtersViewmodelHash() => r'1b07a3c4995fd6b80d4d9e79c1c3833a426e8b5c';

final class FiltersViewmodelFamily extends $Family
    with
        $ClassFamilyOverride<
          FiltersViewmodel,
          AsyncValue<Map<String, List<(String, bool)>>>,
          Map<String, List<(String, bool)>>,
          FutureOr<Map<String, List<(String, bool)>>>,
          FilterTextCategory
        > {
  FiltersViewmodelFamily._()
    : super(
        retry: null,
        name: r'filtersViewmodelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FiltersViewmodelProvider call(FilterTextCategory ctg) =>
      FiltersViewmodelProvider._(argument: ctg, from: this);

  @override
  String toString() => r'filtersViewmodelProvider';
}

abstract class _$FiltersViewmodel
    extends $AsyncNotifier<Map<String, List<(String, bool)>>> {
  late final _$args = ref.$arg as FilterTextCategory;
  FilterTextCategory get ctg => _$args;

  FutureOr<Map<String, List<(String, bool)>>> build(FilterTextCategory ctg);
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
          Map<String, List<(String, bool)>>
        > {
  DialogFiltersViewModelProvider._({
    required DialogFiltersViewModelFamily super.from,
    required FilterTextCategory super.argument,
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
  Override overrideWithValue(Map<String, List<(String, bool)>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, List<(String, bool)>>>(
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
    r'8f1cdcd387b70ee3507eac84d229ef0d10368d77';

final class DialogFiltersViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          DialogFiltersViewModel,
          Map<String, List<(String, bool)>>,
          Map<String, List<(String, bool)>>,
          Map<String, List<(String, bool)>>,
          FilterTextCategory
        > {
  DialogFiltersViewModelFamily._()
    : super(
        retry: null,
        name: r'dialogFiltersViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  DialogFiltersViewModelProvider call(FilterTextCategory ctg) =>
      DialogFiltersViewModelProvider._(argument: ctg, from: this);

  @override
  String toString() => r'dialogFiltersViewModelProvider';
}

abstract class _$DialogFiltersViewModel
    extends $Notifier<Map<String, List<(String, bool)>>> {
  late final _$args = ref.$arg as FilterTextCategory;
  FilterTextCategory get ctg => _$args;

  Map<String, List<(String, bool)>> build(FilterTextCategory ctg);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              Map<String, List<(String, bool)>>,
              Map<String, List<(String, bool)>>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                Map<String, List<(String, bool)>>,
                Map<String, List<(String, bool)>>
              >,
              Map<String, List<(String, bool)>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(SavedFilters)
final savedFiltersProvider = SavedFiltersFamily._();

final class SavedFiltersProvider
    extends $NotifierProvider<SavedFilters, Map<String, List<(String, bool)>>> {
  SavedFiltersProvider._({
    required SavedFiltersFamily super.from,
    required FilterTextCategory super.argument,
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

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, List<(String, bool)>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, List<(String, bool)>>>(
        value,
      ),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SavedFiltersProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$savedFiltersHash() => r'bfff14d099fdab0e13647c3fbf19b4c92d0a1cd1';

final class SavedFiltersFamily extends $Family
    with
        $ClassFamilyOverride<
          SavedFilters,
          Map<String, List<(String, bool)>>,
          Map<String, List<(String, bool)>>,
          Map<String, List<(String, bool)>>,
          FilterTextCategory
        > {
  SavedFiltersFamily._()
    : super(
        retry: null,
        name: r'savedFiltersProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  SavedFiltersProvider call(FilterTextCategory ctg) =>
      SavedFiltersProvider._(argument: ctg, from: this);

  @override
  String toString() => r'savedFiltersProvider';
}

abstract class _$SavedFilters
    extends $Notifier<Map<String, List<(String, bool)>>> {
  late final _$args = ref.$arg as FilterTextCategory;
  FilterTextCategory get ctg => _$args;

  Map<String, List<(String, bool)>> build(FilterTextCategory ctg);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              Map<String, List<(String, bool)>>,
              Map<String, List<(String, bool)>>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                Map<String, List<(String, bool)>>,
                Map<String, List<(String, bool)>>
              >,
              Map<String, List<(String, bool)>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
