// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filters_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$filtersViewmodelHash() => r'1b07a3c4995fd6b80d4d9e79c1c3833a426e8b5c';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$FiltersViewmodel
    extends
        BuildlessAutoDisposeAsyncNotifier<Map<String, List<(String, bool)>>> {
  late final FilterTextCategory ctg;

  FutureOr<Map<String, List<(String, bool)>>> build(FilterTextCategory ctg);
}

/// See also [FiltersViewmodel].
@ProviderFor(FiltersViewmodel)
const filtersViewmodelProvider = FiltersViewmodelFamily();

/// See also [FiltersViewmodel].
class FiltersViewmodelFamily
    extends Family<AsyncValue<Map<String, List<(String, bool)>>>> {
  /// See also [FiltersViewmodel].
  const FiltersViewmodelFamily();

  /// See also [FiltersViewmodel].
  FiltersViewmodelProvider call(FilterTextCategory ctg) {
    return FiltersViewmodelProvider(ctg);
  }

  @override
  FiltersViewmodelProvider getProviderOverride(
    covariant FiltersViewmodelProvider provider,
  ) {
    return call(provider.ctg);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'filtersViewmodelProvider';
}

/// See also [FiltersViewmodel].
class FiltersViewmodelProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          FiltersViewmodel,
          Map<String, List<(String, bool)>>
        > {
  /// See also [FiltersViewmodel].
  FiltersViewmodelProvider(FilterTextCategory ctg)
    : this._internal(
        () => FiltersViewmodel()..ctg = ctg,
        from: filtersViewmodelProvider,
        name: r'filtersViewmodelProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$filtersViewmodelHash,
        dependencies: FiltersViewmodelFamily._dependencies,
        allTransitiveDependencies:
            FiltersViewmodelFamily._allTransitiveDependencies,
        ctg: ctg,
      );

  FiltersViewmodelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.ctg,
  }) : super.internal();

  final FilterTextCategory ctg;

  @override
  FutureOr<Map<String, List<(String, bool)>>> runNotifierBuild(
    covariant FiltersViewmodel notifier,
  ) {
    return notifier.build(ctg);
  }

  @override
  Override overrideWith(FiltersViewmodel Function() create) {
    return ProviderOverride(
      origin: this,
      override: FiltersViewmodelProvider._internal(
        () => create()..ctg = ctg,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        ctg: ctg,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<
    FiltersViewmodel,
    Map<String, List<(String, bool)>>
  >
  createElement() {
    return _FiltersViewmodelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FiltersViewmodelProvider && other.ctg == ctg;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, ctg.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FiltersViewmodelRef
    on AutoDisposeAsyncNotifierProviderRef<Map<String, List<(String, bool)>>> {
  /// The parameter `ctg` of this provider.
  FilterTextCategory get ctg;
}

class _FiltersViewmodelProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          FiltersViewmodel,
          Map<String, List<(String, bool)>>
        >
    with FiltersViewmodelRef {
  _FiltersViewmodelProviderElement(super.provider);

  @override
  FilterTextCategory get ctg => (origin as FiltersViewmodelProvider).ctg;
}

String _$dialogFiltersViewModelHash() =>
    r'c4361d837334a184f343a52ef3df8a3cb76424cd';

abstract class _$DialogFiltersViewModel
    extends BuildlessAutoDisposeNotifier<Map<String, List<(String, bool)>>> {
  late final FilterTextCategory ctg;

  Map<String, List<(String, bool)>> build(FilterTextCategory ctg);
}

/// See also [DialogFiltersViewModel].
@ProviderFor(DialogFiltersViewModel)
const dialogFiltersViewModelProvider = DialogFiltersViewModelFamily();

/// See also [DialogFiltersViewModel].
class DialogFiltersViewModelFamily
    extends Family<Map<String, List<(String, bool)>>> {
  /// See also [DialogFiltersViewModel].
  const DialogFiltersViewModelFamily();

  /// See also [DialogFiltersViewModel].
  DialogFiltersViewModelProvider call(FilterTextCategory ctg) {
    return DialogFiltersViewModelProvider(ctg);
  }

  @override
  DialogFiltersViewModelProvider getProviderOverride(
    covariant DialogFiltersViewModelProvider provider,
  ) {
    return call(provider.ctg);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'dialogFiltersViewModelProvider';
}

/// See also [DialogFiltersViewModel].
class DialogFiltersViewModelProvider
    extends
        AutoDisposeNotifierProviderImpl<
          DialogFiltersViewModel,
          Map<String, List<(String, bool)>>
        > {
  /// See also [DialogFiltersViewModel].
  DialogFiltersViewModelProvider(FilterTextCategory ctg)
    : this._internal(
        () => DialogFiltersViewModel()..ctg = ctg,
        from: dialogFiltersViewModelProvider,
        name: r'dialogFiltersViewModelProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$dialogFiltersViewModelHash,
        dependencies: DialogFiltersViewModelFamily._dependencies,
        allTransitiveDependencies:
            DialogFiltersViewModelFamily._allTransitiveDependencies,
        ctg: ctg,
      );

  DialogFiltersViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.ctg,
  }) : super.internal();

  final FilterTextCategory ctg;

  @override
  Map<String, List<(String, bool)>> runNotifierBuild(
    covariant DialogFiltersViewModel notifier,
  ) {
    return notifier.build(ctg);
  }

  @override
  Override overrideWith(DialogFiltersViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: DialogFiltersViewModelProvider._internal(
        () => create()..ctg = ctg,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        ctg: ctg,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<
    DialogFiltersViewModel,
    Map<String, List<(String, bool)>>
  >
  createElement() {
    return _DialogFiltersViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DialogFiltersViewModelProvider && other.ctg == ctg;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, ctg.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DialogFiltersViewModelRef
    on AutoDisposeNotifierProviderRef<Map<String, List<(String, bool)>>> {
  /// The parameter `ctg` of this provider.
  FilterTextCategory get ctg;
}

class _DialogFiltersViewModelProviderElement
    extends
        AutoDisposeNotifierProviderElement<
          DialogFiltersViewModel,
          Map<String, List<(String, bool)>>
        >
    with DialogFiltersViewModelRef {
  _DialogFiltersViewModelProviderElement(super.provider);

  @override
  FilterTextCategory get ctg => (origin as DialogFiltersViewModelProvider).ctg;
}

String _$savedFiltersHash() => r'bfff14d099fdab0e13647c3fbf19b4c92d0a1cd1';

abstract class _$SavedFilters
    extends BuildlessNotifier<Map<String, List<(String, bool)>>> {
  late final FilterTextCategory ctg;

  Map<String, List<(String, bool)>> build(FilterTextCategory ctg);
}

/// See also [SavedFilters].
@ProviderFor(SavedFilters)
const savedFiltersProvider = SavedFiltersFamily();

/// See also [SavedFilters].
class SavedFiltersFamily extends Family<Map<String, List<(String, bool)>>> {
  /// See also [SavedFilters].
  const SavedFiltersFamily();

  /// See also [SavedFilters].
  SavedFiltersProvider call(FilterTextCategory ctg) {
    return SavedFiltersProvider(ctg);
  }

  @override
  SavedFiltersProvider getProviderOverride(
    covariant SavedFiltersProvider provider,
  ) {
    return call(provider.ctg);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'savedFiltersProvider';
}

/// See also [SavedFilters].
class SavedFiltersProvider
    extends
        NotifierProviderImpl<SavedFilters, Map<String, List<(String, bool)>>> {
  /// See also [SavedFilters].
  SavedFiltersProvider(FilterTextCategory ctg)
    : this._internal(
        () => SavedFilters()..ctg = ctg,
        from: savedFiltersProvider,
        name: r'savedFiltersProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$savedFiltersHash,
        dependencies: SavedFiltersFamily._dependencies,
        allTransitiveDependencies:
            SavedFiltersFamily._allTransitiveDependencies,
        ctg: ctg,
      );

  SavedFiltersProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.ctg,
  }) : super.internal();

  final FilterTextCategory ctg;

  @override
  Map<String, List<(String, bool)>> runNotifierBuild(
    covariant SavedFilters notifier,
  ) {
    return notifier.build(ctg);
  }

  @override
  Override overrideWith(SavedFilters Function() create) {
    return ProviderOverride(
      origin: this,
      override: SavedFiltersProvider._internal(
        () => create()..ctg = ctg,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        ctg: ctg,
      ),
    );
  }

  @override
  NotifierProviderElement<SavedFilters, Map<String, List<(String, bool)>>>
  createElement() {
    return _SavedFiltersProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SavedFiltersProvider && other.ctg == ctg;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, ctg.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SavedFiltersRef
    on NotifierProviderRef<Map<String, List<(String, bool)>>> {
  /// The parameter `ctg` of this provider.
  FilterTextCategory get ctg;
}

class _SavedFiltersProviderElement
    extends
        NotifierProviderElement<SavedFilters, Map<String, List<(String, bool)>>>
    with SavedFiltersRef {
  _SavedFiltersProviderElement(super.provider);

  @override
  FilterTextCategory get ctg => (origin as SavedFiltersProvider).ctg;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
