// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_text_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$filterTextNotifierHash() =>
    r'c5b8829810707ae17e98af7082a764925de0e5d9';

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

abstract class _$FilterTextNotifier
    extends BuildlessAutoDisposeNotifier<(Object, List<String>)> {
  late final FilterTextCategory category;

  (Object, List<String>) build(FilterTextCategory category);
}

/// See also [FilterTextNotifier].
@ProviderFor(FilterTextNotifier)
const filterTextNotifierProvider = FilterTextNotifierFamily();

/// See also [FilterTextNotifier].
class FilterTextNotifierFamily extends Family<(Object, List<String>)> {
  /// See also [FilterTextNotifier].
  const FilterTextNotifierFamily();

  /// See also [FilterTextNotifier].
  FilterTextNotifierProvider call(FilterTextCategory category) {
    return FilterTextNotifierProvider(category);
  }

  @override
  FilterTextNotifierProvider getProviderOverride(
    covariant FilterTextNotifierProvider provider,
  ) {
    return call(provider.category);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'filterTextNotifierProvider';
}

/// See also [FilterTextNotifier].
class FilterTextNotifierProvider
    extends
        AutoDisposeNotifierProviderImpl<
          FilterTextNotifier,
          (Object, List<String>)
        > {
  /// See also [FilterTextNotifier].
  FilterTextNotifierProvider(FilterTextCategory category)
    : this._internal(
        () => FilterTextNotifier()..category = category,
        from: filterTextNotifierProvider,
        name: r'filterTextNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$filterTextNotifierHash,
        dependencies: FilterTextNotifierFamily._dependencies,
        allTransitiveDependencies:
            FilterTextNotifierFamily._allTransitiveDependencies,
        category: category,
      );

  FilterTextNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.category,
  }) : super.internal();

  final FilterTextCategory category;

  @override
  (Object, List<String>) runNotifierBuild(
    covariant FilterTextNotifier notifier,
  ) {
    return notifier.build(category);
  }

  @override
  Override overrideWith(FilterTextNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: FilterTextNotifierProvider._internal(
        () => create()..category = category,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        category: category,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<FilterTextNotifier, (Object, List<String>)>
  createElement() {
    return _FilterTextNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FilterTextNotifierProvider && other.category == category;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, category.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FilterTextNotifierRef
    on AutoDisposeNotifierProviderRef<(Object, List<String>)> {
  /// The parameter `category` of this provider.
  FilterTextCategory get category;
}

class _FilterTextNotifierProviderElement
    extends
        AutoDisposeNotifierProviderElement<
          FilterTextNotifier,
          (Object, List<String>)
        >
    with FilterTextNotifierRef {
  _FilterTextNotifierProviderElement(super.provider);

  @override
  FilterTextCategory get category =>
      (origin as FilterTextNotifierProvider).category;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
