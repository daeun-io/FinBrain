// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sort_or_filter_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sortOrFilterTextViewModelHash() =>
    r'c3aa69babf216ede8c17a77efd678f87fbfbc0ea';

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

abstract class _$SortOrFilterTextViewModel
    extends BuildlessAutoDisposeNotifier<(Object, List<String>)> {
  late final FilterTextCategory category;

  (Object, List<String>) build(FilterTextCategory category);
}

/// See also [SortOrFilterTextViewModel].
@ProviderFor(SortOrFilterTextViewModel)
const sortOrFilterTextViewModelProvider = SortOrFilterTextViewModelFamily();

/// See also [SortOrFilterTextViewModel].
class SortOrFilterTextViewModelFamily extends Family<(Object, List<String>)> {
  /// See also [SortOrFilterTextViewModel].
  const SortOrFilterTextViewModelFamily();

  /// See also [SortOrFilterTextViewModel].
  SortOrFilterTextViewModelProvider call(FilterTextCategory category) {
    return SortOrFilterTextViewModelProvider(category);
  }

  @override
  SortOrFilterTextViewModelProvider getProviderOverride(
    covariant SortOrFilterTextViewModelProvider provider,
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
  String? get name => r'sortOrFilterTextViewModelProvider';
}

/// See also [SortOrFilterTextViewModel].
class SortOrFilterTextViewModelProvider
    extends
        AutoDisposeNotifierProviderImpl<
          SortOrFilterTextViewModel,
          (Object, List<String>)
        > {
  /// See also [SortOrFilterTextViewModel].
  SortOrFilterTextViewModelProvider(FilterTextCategory category)
    : this._internal(
        () => SortOrFilterTextViewModel()..category = category,
        from: sortOrFilterTextViewModelProvider,
        name: r'sortOrFilterTextViewModelProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$sortOrFilterTextViewModelHash,
        dependencies: SortOrFilterTextViewModelFamily._dependencies,
        allTransitiveDependencies:
            SortOrFilterTextViewModelFamily._allTransitiveDependencies,
        category: category,
      );

  SortOrFilterTextViewModelProvider._internal(
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
    covariant SortOrFilterTextViewModel notifier,
  ) {
    return notifier.build(category);
  }

  @override
  Override overrideWith(SortOrFilterTextViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: SortOrFilterTextViewModelProvider._internal(
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
    SortOrFilterTextViewModel,
    (Object, List<String>)
  >
  createElement() {
    return _SortOrFilterTextViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SortOrFilterTextViewModelProvider &&
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
mixin SortOrFilterTextViewModelRef
    on AutoDisposeNotifierProviderRef<(Object, List<String>)> {
  /// The parameter `category` of this provider.
  FilterTextCategory get category;
}

class _SortOrFilterTextViewModelProviderElement
    extends
        AutoDisposeNotifierProviderElement<
          SortOrFilterTextViewModel,
          (Object, List<String>)
        >
    with SortOrFilterTextViewModelRef {
  _SortOrFilterTextViewModelProviderElement(super.provider);

  @override
  FilterTextCategory get category =>
      (origin as SortOrFilterTextViewModelProvider).category;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
