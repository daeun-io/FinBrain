// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_response_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$aiResponseViewmodelHash() =>
    r'53784a4a676098f5551c4ec985c1602d96f08fd5';

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

abstract class _$AiResponseViewmodel
    extends BuildlessAutoDisposeAsyncNotifier<String?> {
  late final String text;
  late final FinancialProduct? product;

  FutureOr<String?> build(String text, [FinancialProduct? product]);
}

/// See also [AiResponseViewmodel].
@ProviderFor(AiResponseViewmodel)
const aiResponseViewmodelProvider = AiResponseViewmodelFamily();

/// See also [AiResponseViewmodel].
class AiResponseViewmodelFamily extends Family<AsyncValue<String?>> {
  /// See also [AiResponseViewmodel].
  const AiResponseViewmodelFamily();

  /// See also [AiResponseViewmodel].
  AiResponseViewmodelProvider call(String text, [FinancialProduct? product]) {
    return AiResponseViewmodelProvider(text, product);
  }

  @override
  AiResponseViewmodelProvider getProviderOverride(
    covariant AiResponseViewmodelProvider provider,
  ) {
    return call(provider.text, provider.product);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'aiResponseViewmodelProvider';
}

/// See also [AiResponseViewmodel].
class AiResponseViewmodelProvider
    extends AutoDisposeAsyncNotifierProviderImpl<AiResponseViewmodel, String?> {
  /// See also [AiResponseViewmodel].
  AiResponseViewmodelProvider(String text, [FinancialProduct? product])
    : this._internal(
        () => AiResponseViewmodel()
          ..text = text
          ..product = product,
        from: aiResponseViewmodelProvider,
        name: r'aiResponseViewmodelProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$aiResponseViewmodelHash,
        dependencies: AiResponseViewmodelFamily._dependencies,
        allTransitiveDependencies:
            AiResponseViewmodelFamily._allTransitiveDependencies,
        text: text,
        product: product,
      );

  AiResponseViewmodelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.text,
    required this.product,
  }) : super.internal();

  final String text;
  final FinancialProduct? product;

  @override
  FutureOr<String?> runNotifierBuild(covariant AiResponseViewmodel notifier) {
    return notifier.build(text, product);
  }

  @override
  Override overrideWith(AiResponseViewmodel Function() create) {
    return ProviderOverride(
      origin: this,
      override: AiResponseViewmodelProvider._internal(
        () => create()
          ..text = text
          ..product = product,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        text: text,
        product: product,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<AiResponseViewmodel, String?>
  createElement() {
    return _AiResponseViewmodelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AiResponseViewmodelProvider &&
        other.text == text &&
        other.product == product;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, text.hashCode);
    hash = _SystemHash.combine(hash, product.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AiResponseViewmodelRef on AutoDisposeAsyncNotifierProviderRef<String?> {
  /// The parameter `text` of this provider.
  String get text;

  /// The parameter `product` of this provider.
  FinancialProduct? get product;
}

class _AiResponseViewmodelProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<AiResponseViewmodel, String?>
    with AiResponseViewmodelRef {
  _AiResponseViewmodelProviderElement(super.provider);

  @override
  String get text => (origin as AiResponseViewmodelProvider).text;
  @override
  FinancialProduct? get product =>
      (origin as AiResponseViewmodelProvider).product;
}

String _$aiScreenViewmodelHash() => r'5e5d81c44812a8721cee6e429563ae897932c40c';

abstract class _$AiScreenViewmodel
    extends BuildlessAutoDisposeNotifier<Map<String, String>> {
  late final String tag;

  Map<String, String> build(String tag);
}

/// See also [AiScreenViewmodel].
@ProviderFor(AiScreenViewmodel)
const aiScreenViewmodelProvider = AiScreenViewmodelFamily();

/// See also [AiScreenViewmodel].
class AiScreenViewmodelFamily extends Family<Map<String, String>> {
  /// See also [AiScreenViewmodel].
  const AiScreenViewmodelFamily();

  /// See also [AiScreenViewmodel].
  AiScreenViewmodelProvider call(String tag) {
    return AiScreenViewmodelProvider(tag);
  }

  @override
  AiScreenViewmodelProvider getProviderOverride(
    covariant AiScreenViewmodelProvider provider,
  ) {
    return call(provider.tag);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'aiScreenViewmodelProvider';
}

/// See also [AiScreenViewmodel].
class AiScreenViewmodelProvider
    extends
        AutoDisposeNotifierProviderImpl<
          AiScreenViewmodel,
          Map<String, String>
        > {
  /// See also [AiScreenViewmodel].
  AiScreenViewmodelProvider(String tag)
    : this._internal(
        () => AiScreenViewmodel()..tag = tag,
        from: aiScreenViewmodelProvider,
        name: r'aiScreenViewmodelProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$aiScreenViewmodelHash,
        dependencies: AiScreenViewmodelFamily._dependencies,
        allTransitiveDependencies:
            AiScreenViewmodelFamily._allTransitiveDependencies,
        tag: tag,
      );

  AiScreenViewmodelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tag,
  }) : super.internal();

  final String tag;

  @override
  Map<String, String> runNotifierBuild(covariant AiScreenViewmodel notifier) {
    return notifier.build(tag);
  }

  @override
  Override overrideWith(AiScreenViewmodel Function() create) {
    return ProviderOverride(
      origin: this,
      override: AiScreenViewmodelProvider._internal(
        () => create()..tag = tag,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        tag: tag,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<AiScreenViewmodel, Map<String, String>>
  createElement() {
    return _AiScreenViewmodelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AiScreenViewmodelProvider && other.tag == tag;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tag.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AiScreenViewmodelRef
    on AutoDisposeNotifierProviderRef<Map<String, String>> {
  /// The parameter `tag` of this provider.
  String get tag;
}

class _AiScreenViewmodelProviderElement
    extends
        AutoDisposeNotifierProviderElement<
          AiScreenViewmodel,
          Map<String, String>
        >
    with AiScreenViewmodelRef {
  _AiScreenViewmodelProviderElement(super.provider);

  @override
  String get tag => (origin as AiScreenViewmodelProvider).tag;
}

String _$aiComparisonScreenViewmodelHash() =>
    r'c6b5375fb784e85355530752804d80ccd975e34c';

abstract class _$AiComparisonScreenViewmodel
    extends BuildlessAutoDisposeNotifier<String> {
  late final String products;

  String build(String products);
}

/// See also [AiComparisonScreenViewmodel].
@ProviderFor(AiComparisonScreenViewmodel)
const aiComparisonScreenViewmodelProvider = AiComparisonScreenViewmodelFamily();

/// See also [AiComparisonScreenViewmodel].
class AiComparisonScreenViewmodelFamily extends Family<String> {
  /// See also [AiComparisonScreenViewmodel].
  const AiComparisonScreenViewmodelFamily();

  /// See also [AiComparisonScreenViewmodel].
  AiComparisonScreenViewmodelProvider call(String products) {
    return AiComparisonScreenViewmodelProvider(products);
  }

  @override
  AiComparisonScreenViewmodelProvider getProviderOverride(
    covariant AiComparisonScreenViewmodelProvider provider,
  ) {
    return call(provider.products);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'aiComparisonScreenViewmodelProvider';
}

/// See also [AiComparisonScreenViewmodel].
class AiComparisonScreenViewmodelProvider
    extends
        AutoDisposeNotifierProviderImpl<AiComparisonScreenViewmodel, String> {
  /// See also [AiComparisonScreenViewmodel].
  AiComparisonScreenViewmodelProvider(String products)
    : this._internal(
        () => AiComparisonScreenViewmodel()..products = products,
        from: aiComparisonScreenViewmodelProvider,
        name: r'aiComparisonScreenViewmodelProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$aiComparisonScreenViewmodelHash,
        dependencies: AiComparisonScreenViewmodelFamily._dependencies,
        allTransitiveDependencies:
            AiComparisonScreenViewmodelFamily._allTransitiveDependencies,
        products: products,
      );

  AiComparisonScreenViewmodelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.products,
  }) : super.internal();

  final String products;

  @override
  String runNotifierBuild(covariant AiComparisonScreenViewmodel notifier) {
    return notifier.build(products);
  }

  @override
  Override overrideWith(AiComparisonScreenViewmodel Function() create) {
    return ProviderOverride(
      origin: this,
      override: AiComparisonScreenViewmodelProvider._internal(
        () => create()..products = products,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        products: products,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<AiComparisonScreenViewmodel, String>
  createElement() {
    return _AiComparisonScreenViewmodelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AiComparisonScreenViewmodelProvider &&
        other.products == products;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, products.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AiComparisonScreenViewmodelRef on AutoDisposeNotifierProviderRef<String> {
  /// The parameter `products` of this provider.
  String get products;
}

class _AiComparisonScreenViewmodelProviderElement
    extends
        AutoDisposeNotifierProviderElement<AiComparisonScreenViewmodel, String>
    with AiComparisonScreenViewmodelRef {
  _AiComparisonScreenViewmodelProviderElement(super.provider);

  @override
  String get products =>
      (origin as AiComparisonScreenViewmodelProvider).products;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
