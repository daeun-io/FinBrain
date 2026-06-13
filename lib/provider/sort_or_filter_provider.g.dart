// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sort_or_filter_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sortOrFilterTextNotifierHash() =>
    r'4e86c2a90d2cd51d27b5f987005db795e8ce46cb';

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

abstract class _$SortOrFilterTextNotifier
    extends BuildlessAutoDisposeNotifier<(Object, List<String>)> {
  late final FilterTextCategory category;

  (Object, List<String>) build(FilterTextCategory category);
}

/// See also [SortOrFilterTextNotifier].
@ProviderFor(SortOrFilterTextNotifier)
const sortOrFilterTextNotifierProvider = SortOrFilterTextNotifierFamily();

/// See also [SortOrFilterTextNotifier].
class SortOrFilterTextNotifierFamily extends Family<(Object, List<String>)> {
  /// See also [SortOrFilterTextNotifier].
  const SortOrFilterTextNotifierFamily();

  /// See also [SortOrFilterTextNotifier].
  SortOrFilterTextNotifierProvider call(FilterTextCategory category) {
    return SortOrFilterTextNotifierProvider(category);
  }

  @override
  SortOrFilterTextNotifierProvider getProviderOverride(
    covariant SortOrFilterTextNotifierProvider provider,
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
  String? get name => r'sortOrFilterTextNotifierProvider';
}

/// See also [SortOrFilterTextNotifier].
class SortOrFilterTextNotifierProvider
    extends
        AutoDisposeNotifierProviderImpl<
          SortOrFilterTextNotifier,
          (Object, List<String>)
        > {
  /// See also [SortOrFilterTextNotifier].
  SortOrFilterTextNotifierProvider(FilterTextCategory category)
    : this._internal(
        () => SortOrFilterTextNotifier()..category = category,
        from: sortOrFilterTextNotifierProvider,
        name: r'sortOrFilterTextNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$sortOrFilterTextNotifierHash,
        dependencies: SortOrFilterTextNotifierFamily._dependencies,
        allTransitiveDependencies:
            SortOrFilterTextNotifierFamily._allTransitiveDependencies,
        category: category,
      );

  SortOrFilterTextNotifierProvider._internal(
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
    covariant SortOrFilterTextNotifier notifier,
  ) {
    return notifier.build(category);
  }

  @override
  Override overrideWith(SortOrFilterTextNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: SortOrFilterTextNotifierProvider._internal(
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
  AutoDisposeNotifierProviderElement<
    SortOrFilterTextNotifier,
    (Object, List<String>)
  >
  createElement() {
    return _SortOrFilterTextNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SortOrFilterTextNotifierProvider &&
        other.category == category;
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
mixin SortOrFilterTextNotifierRef
    on AutoDisposeNotifierProviderRef<(Object, List<String>)> {
  /// The parameter `category` of this provider.
  FilterTextCategory get category;
}

class _SortOrFilterTextNotifierProviderElement
    extends
        AutoDisposeNotifierProviderElement<
          SortOrFilterTextNotifier,
          (Object, List<String>)
        >
    with SortOrFilterTextNotifierRef {
  _SortOrFilterTextNotifierProviderElement(super.provider);

  @override
  FilterTextCategory get category =>
      (origin as SortOrFilterTextNotifierProvider).category;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
