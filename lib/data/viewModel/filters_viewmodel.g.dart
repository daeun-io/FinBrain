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
    r'da4299a0326ebbb716c11756be6009ee771ff6fb';

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

String _$savedFiltersHash() => r'de4a18f0c6fbb37b029864f91e25a73366f838d3';

/// See also [SavedFilters].
@ProviderFor(SavedFilters)
final savedFiltersProvider =
    NotifierProvider<SavedFilters, Map<String, List<(String, bool)>>>.internal(
      SavedFilters.new,
      name: r'savedFiltersProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$savedFiltersHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SavedFilters = Notifier<Map<String, List<(String, bool)>>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
