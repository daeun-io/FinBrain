// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productViewmodelHash() => r'c1f08dc806ba99de18298425548ef0f6247e9951';

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

abstract class _$ProductViewmodel
    extends BuildlessAutoDisposeAsyncNotifier<List<FinancialProduct>> {
  late final ProductCategory ctg;
  late final FilterTextCategory filterCtg;
  late final String topFinGrpNo;
  late final String pageNo;
  late final String numOfRows;
  late final String baseYearMonth;
  late final String domain;
  late final String mpType;
  late final String cmpy;

  FutureOr<List<FinancialProduct>> build(
    ProductCategory ctg,
    FilterTextCategory filterCtg,
    String topFinGrpNo,
    String pageNo,
    String numOfRows,
    String baseYearMonth,
    String domain,
    String mpType,
    String cmpy,
  );
}

/// See also [ProductViewmodel].
@ProviderFor(ProductViewmodel)
const productViewmodelProvider = ProductViewmodelFamily();

/// See also [ProductViewmodel].
class ProductViewmodelFamily
    extends Family<AsyncValue<List<FinancialProduct>>> {
  /// See also [ProductViewmodel].
  const ProductViewmodelFamily();

  /// See also [ProductViewmodel].
  ProductViewmodelProvider call(
    ProductCategory ctg,
    FilterTextCategory filterCtg,
    String topFinGrpNo,
    String pageNo,
    String numOfRows,
    String baseYearMonth,
    String domain,
    String mpType,
    String cmpy,
  ) {
    return ProductViewmodelProvider(
      ctg,
      filterCtg,
      topFinGrpNo,
      pageNo,
      numOfRows,
      baseYearMonth,
      domain,
      mpType,
      cmpy,
    );
  }

  @override
  ProductViewmodelProvider getProviderOverride(
    covariant ProductViewmodelProvider provider,
  ) {
    return call(
      provider.ctg,
      provider.filterCtg,
      provider.topFinGrpNo,
      provider.pageNo,
      provider.numOfRows,
      provider.baseYearMonth,
      provider.domain,
      provider.mpType,
      provider.cmpy,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'productViewmodelProvider';
}

/// See also [ProductViewmodel].
class ProductViewmodelProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          ProductViewmodel,
          List<FinancialProduct>
        > {
  /// See also [ProductViewmodel].
  ProductViewmodelProvider(
    ProductCategory ctg,
    FilterTextCategory filterCtg,
    String topFinGrpNo,
    String pageNo,
    String numOfRows,
    String baseYearMonth,
    String domain,
    String mpType,
    String cmpy,
  ) : this._internal(
        () => ProductViewmodel()
          ..ctg = ctg
          ..filterCtg = filterCtg
          ..topFinGrpNo = topFinGrpNo
          ..pageNo = pageNo
          ..numOfRows = numOfRows
          ..baseYearMonth = baseYearMonth
          ..domain = domain
          ..mpType = mpType
          ..cmpy = cmpy,
        from: productViewmodelProvider,
        name: r'productViewmodelProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$productViewmodelHash,
        dependencies: ProductViewmodelFamily._dependencies,
        allTransitiveDependencies:
            ProductViewmodelFamily._allTransitiveDependencies,
        ctg: ctg,
        filterCtg: filterCtg,
        topFinGrpNo: topFinGrpNo,
        pageNo: pageNo,
        numOfRows: numOfRows,
        baseYearMonth: baseYearMonth,
        domain: domain,
        mpType: mpType,
        cmpy: cmpy,
      );

  ProductViewmodelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.ctg,
    required this.filterCtg,
    required this.topFinGrpNo,
    required this.pageNo,
    required this.numOfRows,
    required this.baseYearMonth,
    required this.domain,
    required this.mpType,
    required this.cmpy,
  }) : super.internal();

  final ProductCategory ctg;
  final FilterTextCategory filterCtg;
  final String topFinGrpNo;
  final String pageNo;
  final String numOfRows;
  final String baseYearMonth;
  final String domain;
  final String mpType;
  final String cmpy;

  @override
  FutureOr<List<FinancialProduct>> runNotifierBuild(
    covariant ProductViewmodel notifier,
  ) {
    return notifier.build(
      ctg,
      filterCtg,
      topFinGrpNo,
      pageNo,
      numOfRows,
      baseYearMonth,
      domain,
      mpType,
      cmpy,
    );
  }

  @override
  Override overrideWith(ProductViewmodel Function() create) {
    return ProviderOverride(
      origin: this,
      override: ProductViewmodelProvider._internal(
        () => create()
          ..ctg = ctg
          ..filterCtg = filterCtg
          ..topFinGrpNo = topFinGrpNo
          ..pageNo = pageNo
          ..numOfRows = numOfRows
          ..baseYearMonth = baseYearMonth
          ..domain = domain
          ..mpType = mpType
          ..cmpy = cmpy,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        ctg: ctg,
        filterCtg: filterCtg,
        topFinGrpNo: topFinGrpNo,
        pageNo: pageNo,
        numOfRows: numOfRows,
        baseYearMonth: baseYearMonth,
        domain: domain,
        mpType: mpType,
        cmpy: cmpy,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<
    ProductViewmodel,
    List<FinancialProduct>
  >
  createElement() {
    return _ProductViewmodelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductViewmodelProvider &&
        other.ctg == ctg &&
        other.filterCtg == filterCtg &&
        other.topFinGrpNo == topFinGrpNo &&
        other.pageNo == pageNo &&
        other.numOfRows == numOfRows &&
        other.baseYearMonth == baseYearMonth &&
        other.domain == domain &&
        other.mpType == mpType &&
        other.cmpy == cmpy;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, ctg.hashCode);
    hash = _SystemHash.combine(hash, filterCtg.hashCode);
    hash = _SystemHash.combine(hash, topFinGrpNo.hashCode);
    hash = _SystemHash.combine(hash, pageNo.hashCode);
    hash = _SystemHash.combine(hash, numOfRows.hashCode);
    hash = _SystemHash.combine(hash, baseYearMonth.hashCode);
    hash = _SystemHash.combine(hash, domain.hashCode);
    hash = _SystemHash.combine(hash, mpType.hashCode);
    hash = _SystemHash.combine(hash, cmpy.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProductViewmodelRef
    on AutoDisposeAsyncNotifierProviderRef<List<FinancialProduct>> {
  /// The parameter `ctg` of this provider.
  ProductCategory get ctg;

  /// The parameter `filterCtg` of this provider.
  FilterTextCategory get filterCtg;

  /// The parameter `topFinGrpNo` of this provider.
  String get topFinGrpNo;

  /// The parameter `pageNo` of this provider.
  String get pageNo;

  /// The parameter `numOfRows` of this provider.
  String get numOfRows;

  /// The parameter `baseYearMonth` of this provider.
  String get baseYearMonth;

  /// The parameter `domain` of this provider.
  String get domain;

  /// The parameter `mpType` of this provider.
  String get mpType;

  /// The parameter `cmpy` of this provider.
  String get cmpy;
}

class _ProductViewmodelProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          ProductViewmodel,
          List<FinancialProduct>
        >
    with ProductViewmodelRef {
  _ProductViewmodelProviderElement(super.provider);

  @override
  ProductCategory get ctg => (origin as ProductViewmodelProvider).ctg;
  @override
  FilterTextCategory get filterCtg =>
      (origin as ProductViewmodelProvider).filterCtg;
  @override
  String get topFinGrpNo => (origin as ProductViewmodelProvider).topFinGrpNo;
  @override
  String get pageNo => (origin as ProductViewmodelProvider).pageNo;
  @override
  String get numOfRows => (origin as ProductViewmodelProvider).numOfRows;
  @override
  String get baseYearMonth =>
      (origin as ProductViewmodelProvider).baseYearMonth;
  @override
  String get domain => (origin as ProductViewmodelProvider).domain;
  @override
  String get mpType => (origin as ProductViewmodelProvider).mpType;
  @override
  String get cmpy => (origin as ProductViewmodelProvider).cmpy;
}

String _$likedProductViewmodelHash() =>
    r'25aae816d5aa151a9d5404b3112fc86982dbf3d0';

abstract class _$LikedProductViewmodel
    extends BuildlessAutoDisposeAsyncNotifier<List<FinancialProduct>> {
  late final ProductCategory ctg;
  late final FilterTextCategory filterCtg;
  late final String topFinGrpNo;
  late final String pageNo;
  late final String numOfRows;
  late final String baseYearMonth;
  late final String domain;
  late final String mpType;
  late final String cmpy;

  FutureOr<List<FinancialProduct>> build(
    ProductCategory ctg,
    FilterTextCategory filterCtg,
    String topFinGrpNo,
    String pageNo,
    String numOfRows,
    String baseYearMonth,
    String domain,
    String mpType,
    String cmpy,
  );
}

/// See also [LikedProductViewmodel].
@ProviderFor(LikedProductViewmodel)
const likedProductViewmodelProvider = LikedProductViewmodelFamily();

/// See also [LikedProductViewmodel].
class LikedProductViewmodelFamily
    extends Family<AsyncValue<List<FinancialProduct>>> {
  /// See also [LikedProductViewmodel].
  const LikedProductViewmodelFamily();

  /// See also [LikedProductViewmodel].
  LikedProductViewmodelProvider call(
    ProductCategory ctg,
    FilterTextCategory filterCtg,
    String topFinGrpNo,
    String pageNo,
    String numOfRows,
    String baseYearMonth,
    String domain,
    String mpType,
    String cmpy,
  ) {
    return LikedProductViewmodelProvider(
      ctg,
      filterCtg,
      topFinGrpNo,
      pageNo,
      numOfRows,
      baseYearMonth,
      domain,
      mpType,
      cmpy,
    );
  }

  @override
  LikedProductViewmodelProvider getProviderOverride(
    covariant LikedProductViewmodelProvider provider,
  ) {
    return call(
      provider.ctg,
      provider.filterCtg,
      provider.topFinGrpNo,
      provider.pageNo,
      provider.numOfRows,
      provider.baseYearMonth,
      provider.domain,
      provider.mpType,
      provider.cmpy,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'likedProductViewmodelProvider';
}

/// See also [LikedProductViewmodel].
class LikedProductViewmodelProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          LikedProductViewmodel,
          List<FinancialProduct>
        > {
  /// See also [LikedProductViewmodel].
  LikedProductViewmodelProvider(
    ProductCategory ctg,
    FilterTextCategory filterCtg,
    String topFinGrpNo,
    String pageNo,
    String numOfRows,
    String baseYearMonth,
    String domain,
    String mpType,
    String cmpy,
  ) : this._internal(
        () => LikedProductViewmodel()
          ..ctg = ctg
          ..filterCtg = filterCtg
          ..topFinGrpNo = topFinGrpNo
          ..pageNo = pageNo
          ..numOfRows = numOfRows
          ..baseYearMonth = baseYearMonth
          ..domain = domain
          ..mpType = mpType
          ..cmpy = cmpy,
        from: likedProductViewmodelProvider,
        name: r'likedProductViewmodelProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$likedProductViewmodelHash,
        dependencies: LikedProductViewmodelFamily._dependencies,
        allTransitiveDependencies:
            LikedProductViewmodelFamily._allTransitiveDependencies,
        ctg: ctg,
        filterCtg: filterCtg,
        topFinGrpNo: topFinGrpNo,
        pageNo: pageNo,
        numOfRows: numOfRows,
        baseYearMonth: baseYearMonth,
        domain: domain,
        mpType: mpType,
        cmpy: cmpy,
      );

  LikedProductViewmodelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.ctg,
    required this.filterCtg,
    required this.topFinGrpNo,
    required this.pageNo,
    required this.numOfRows,
    required this.baseYearMonth,
    required this.domain,
    required this.mpType,
    required this.cmpy,
  }) : super.internal();

  final ProductCategory ctg;
  final FilterTextCategory filterCtg;
  final String topFinGrpNo;
  final String pageNo;
  final String numOfRows;
  final String baseYearMonth;
  final String domain;
  final String mpType;
  final String cmpy;

  @override
  FutureOr<List<FinancialProduct>> runNotifierBuild(
    covariant LikedProductViewmodel notifier,
  ) {
    return notifier.build(
      ctg,
      filterCtg,
      topFinGrpNo,
      pageNo,
      numOfRows,
      baseYearMonth,
      domain,
      mpType,
      cmpy,
    );
  }

  @override
  Override overrideWith(LikedProductViewmodel Function() create) {
    return ProviderOverride(
      origin: this,
      override: LikedProductViewmodelProvider._internal(
        () => create()
          ..ctg = ctg
          ..filterCtg = filterCtg
          ..topFinGrpNo = topFinGrpNo
          ..pageNo = pageNo
          ..numOfRows = numOfRows
          ..baseYearMonth = baseYearMonth
          ..domain = domain
          ..mpType = mpType
          ..cmpy = cmpy,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        ctg: ctg,
        filterCtg: filterCtg,
        topFinGrpNo: topFinGrpNo,
        pageNo: pageNo,
        numOfRows: numOfRows,
        baseYearMonth: baseYearMonth,
        domain: domain,
        mpType: mpType,
        cmpy: cmpy,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<
    LikedProductViewmodel,
    List<FinancialProduct>
  >
  createElement() {
    return _LikedProductViewmodelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LikedProductViewmodelProvider &&
        other.ctg == ctg &&
        other.filterCtg == filterCtg &&
        other.topFinGrpNo == topFinGrpNo &&
        other.pageNo == pageNo &&
        other.numOfRows == numOfRows &&
        other.baseYearMonth == baseYearMonth &&
        other.domain == domain &&
        other.mpType == mpType &&
        other.cmpy == cmpy;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, ctg.hashCode);
    hash = _SystemHash.combine(hash, filterCtg.hashCode);
    hash = _SystemHash.combine(hash, topFinGrpNo.hashCode);
    hash = _SystemHash.combine(hash, pageNo.hashCode);
    hash = _SystemHash.combine(hash, numOfRows.hashCode);
    hash = _SystemHash.combine(hash, baseYearMonth.hashCode);
    hash = _SystemHash.combine(hash, domain.hashCode);
    hash = _SystemHash.combine(hash, mpType.hashCode);
    hash = _SystemHash.combine(hash, cmpy.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin LikedProductViewmodelRef
    on AutoDisposeAsyncNotifierProviderRef<List<FinancialProduct>> {
  /// The parameter `ctg` of this provider.
  ProductCategory get ctg;

  /// The parameter `filterCtg` of this provider.
  FilterTextCategory get filterCtg;

  /// The parameter `topFinGrpNo` of this provider.
  String get topFinGrpNo;

  /// The parameter `pageNo` of this provider.
  String get pageNo;

  /// The parameter `numOfRows` of this provider.
  String get numOfRows;

  /// The parameter `baseYearMonth` of this provider.
  String get baseYearMonth;

  /// The parameter `domain` of this provider.
  String get domain;

  /// The parameter `mpType` of this provider.
  String get mpType;

  /// The parameter `cmpy` of this provider.
  String get cmpy;
}

class _LikedProductViewmodelProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          LikedProductViewmodel,
          List<FinancialProduct>
        >
    with LikedProductViewmodelRef {
  _LikedProductViewmodelProviderElement(super.provider);

  @override
  ProductCategory get ctg => (origin as LikedProductViewmodelProvider).ctg;
  @override
  FilterTextCategory get filterCtg =>
      (origin as LikedProductViewmodelProvider).filterCtg;
  @override
  String get topFinGrpNo =>
      (origin as LikedProductViewmodelProvider).topFinGrpNo;
  @override
  String get pageNo => (origin as LikedProductViewmodelProvider).pageNo;
  @override
  String get numOfRows => (origin as LikedProductViewmodelProvider).numOfRows;
  @override
  String get baseYearMonth =>
      (origin as LikedProductViewmodelProvider).baseYearMonth;
  @override
  String get domain => (origin as LikedProductViewmodelProvider).domain;
  @override
  String get mpType => (origin as LikedProductViewmodelProvider).mpType;
  @override
  String get cmpy => (origin as LikedProductViewmodelProvider).cmpy;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
