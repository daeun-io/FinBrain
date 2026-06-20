// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filters_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$filtersViewmodelHash() => r'a8938c7c47a5c879f72116d555be3795f6c50236';

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
  late final String topFinGrpNo;
  late final String pageNo;

  FutureOr<Map<String, List<(String, bool)>>> build(
    FilterTextCategory ctg,
    String topFinGrpNo,
    String pageNo,
  );
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
  FiltersViewmodelProvider call(
    FilterTextCategory ctg,
    String topFinGrpNo,
    String pageNo,
  ) {
    return FiltersViewmodelProvider(ctg, topFinGrpNo, pageNo);
  }

  @override
  FiltersViewmodelProvider getProviderOverride(
    covariant FiltersViewmodelProvider provider,
  ) {
    return call(provider.ctg, provider.topFinGrpNo, provider.pageNo);
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
  FiltersViewmodelProvider(
    FilterTextCategory ctg,
    String topFinGrpNo,
    String pageNo,
  ) : this._internal(
        () => FiltersViewmodel()
          ..ctg = ctg
          ..topFinGrpNo = topFinGrpNo
          ..pageNo = pageNo,
        from: filtersViewmodelProvider,
        name: r'filtersViewmodelProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$filtersViewmodelHash,
        dependencies: FiltersViewmodelFamily._dependencies,
        allTransitiveDependencies:
            FiltersViewmodelFamily._allTransitiveDependencies,
        ctg: ctg,
        topFinGrpNo: topFinGrpNo,
        pageNo: pageNo,
      );

  FiltersViewmodelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.ctg,
    required this.topFinGrpNo,
    required this.pageNo,
  }) : super.internal();

  final FilterTextCategory ctg;
  final String topFinGrpNo;
  final String pageNo;

  @override
  FutureOr<Map<String, List<(String, bool)>>> runNotifierBuild(
    covariant FiltersViewmodel notifier,
  ) {
    return notifier.build(ctg, topFinGrpNo, pageNo);
  }

  @override
  Override overrideWith(FiltersViewmodel Function() create) {
    return ProviderOverride(
      origin: this,
      override: FiltersViewmodelProvider._internal(
        () => create()
          ..ctg = ctg
          ..topFinGrpNo = topFinGrpNo
          ..pageNo = pageNo,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        ctg: ctg,
        topFinGrpNo: topFinGrpNo,
        pageNo: pageNo,
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
    return other is FiltersViewmodelProvider &&
        other.ctg == ctg &&
        other.topFinGrpNo == topFinGrpNo &&
        other.pageNo == pageNo;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, ctg.hashCode);
    hash = _SystemHash.combine(hash, topFinGrpNo.hashCode);
    hash = _SystemHash.combine(hash, pageNo.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FiltersViewmodelRef
    on AutoDisposeAsyncNotifierProviderRef<Map<String, List<(String, bool)>>> {
  /// The parameter `ctg` of this provider.
  FilterTextCategory get ctg;

  /// The parameter `topFinGrpNo` of this provider.
  String get topFinGrpNo;

  /// The parameter `pageNo` of this provider.
  String get pageNo;
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
  @override
  String get topFinGrpNo => (origin as FiltersViewmodelProvider).topFinGrpNo;
  @override
  String get pageNo => (origin as FiltersViewmodelProvider).pageNo;
}

String _$dialogFiltersViewModelHash() =>
    r'c7eb0b27819e5af6758a6dd63b6616e2e2e8e47c';

abstract class _$DialogFiltersViewModel
    extends BuildlessAutoDisposeNotifier<Map<String, List<(String, bool)>>> {
  late final FilterTextCategory ctg;
  late final String topFinGrpNo;
  late final String pageNo;

  Map<String, List<(String, bool)>> build(
    FilterTextCategory ctg,
    String topFinGrpNo,
    String pageNo,
  );
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
  DialogFiltersViewModelProvider call(
    FilterTextCategory ctg,
    String topFinGrpNo,
    String pageNo,
  ) {
    return DialogFiltersViewModelProvider(ctg, topFinGrpNo, pageNo);
  }

  @override
  DialogFiltersViewModelProvider getProviderOverride(
    covariant DialogFiltersViewModelProvider provider,
  ) {
    return call(provider.ctg, provider.topFinGrpNo, provider.pageNo);
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
  DialogFiltersViewModelProvider(
    FilterTextCategory ctg,
    String topFinGrpNo,
    String pageNo,
  ) : this._internal(
        () => DialogFiltersViewModel()
          ..ctg = ctg
          ..topFinGrpNo = topFinGrpNo
          ..pageNo = pageNo,
        from: dialogFiltersViewModelProvider,
        name: r'dialogFiltersViewModelProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$dialogFiltersViewModelHash,
        dependencies: DialogFiltersViewModelFamily._dependencies,
        allTransitiveDependencies:
            DialogFiltersViewModelFamily._allTransitiveDependencies,
        ctg: ctg,
        topFinGrpNo: topFinGrpNo,
        pageNo: pageNo,
      );

  DialogFiltersViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.ctg,
    required this.topFinGrpNo,
    required this.pageNo,
  }) : super.internal();

  final FilterTextCategory ctg;
  final String topFinGrpNo;
  final String pageNo;

  @override
  Map<String, List<(String, bool)>> runNotifierBuild(
    covariant DialogFiltersViewModel notifier,
  ) {
    return notifier.build(ctg, topFinGrpNo, pageNo);
  }

  @override
  Override overrideWith(DialogFiltersViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: DialogFiltersViewModelProvider._internal(
        () => create()
          ..ctg = ctg
          ..topFinGrpNo = topFinGrpNo
          ..pageNo = pageNo,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        ctg: ctg,
        topFinGrpNo: topFinGrpNo,
        pageNo: pageNo,
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
    return other is DialogFiltersViewModelProvider &&
        other.ctg == ctg &&
        other.topFinGrpNo == topFinGrpNo &&
        other.pageNo == pageNo;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, ctg.hashCode);
    hash = _SystemHash.combine(hash, topFinGrpNo.hashCode);
    hash = _SystemHash.combine(hash, pageNo.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DialogFiltersViewModelRef
    on AutoDisposeNotifierProviderRef<Map<String, List<(String, bool)>>> {
  /// The parameter `ctg` of this provider.
  FilterTextCategory get ctg;

  /// The parameter `topFinGrpNo` of this provider.
  String get topFinGrpNo;

  /// The parameter `pageNo` of this provider.
  String get pageNo;
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
  @override
  String get topFinGrpNo =>
      (origin as DialogFiltersViewModelProvider).topFinGrpNo;
  @override
  String get pageNo => (origin as DialogFiltersViewModelProvider).pageNo;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
