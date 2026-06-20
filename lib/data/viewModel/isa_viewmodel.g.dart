// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isa_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$isaJoinStatusViewModelHash() =>
    r'35d8378300383abc295cdc9bdbd37919f3512856';

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

abstract class _$IsaJoinStatusViewModel
    extends BuildlessAutoDisposeAsyncNotifier<List<IsaJoinStatus>> {
  late final String pageNo;
  late final String numOfRows;
  late final String baseYearMonth;
  late final String domain;
  late final String isaForm;

  FutureOr<List<IsaJoinStatus>> build(
    String pageNo,
    String numOfRows,
    String baseYearMonth,
    String domain,
    String isaForm,
  );
}

/// See also [IsaJoinStatusViewModel].
@ProviderFor(IsaJoinStatusViewModel)
const isaJoinStatusViewModelProvider = IsaJoinStatusViewModelFamily();

/// See also [IsaJoinStatusViewModel].
class IsaJoinStatusViewModelFamily
    extends Family<AsyncValue<List<IsaJoinStatus>>> {
  /// See also [IsaJoinStatusViewModel].
  const IsaJoinStatusViewModelFamily();

  /// See also [IsaJoinStatusViewModel].
  IsaJoinStatusViewModelProvider call(
    String pageNo,
    String numOfRows,
    String baseYearMonth,
    String domain,
    String isaForm,
  ) {
    return IsaJoinStatusViewModelProvider(
      pageNo,
      numOfRows,
      baseYearMonth,
      domain,
      isaForm,
    );
  }

  @override
  IsaJoinStatusViewModelProvider getProviderOverride(
    covariant IsaJoinStatusViewModelProvider provider,
  ) {
    return call(
      provider.pageNo,
      provider.numOfRows,
      provider.baseYearMonth,
      provider.domain,
      provider.isaForm,
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
  String? get name => r'isaJoinStatusViewModelProvider';
}

/// See also [IsaJoinStatusViewModel].
class IsaJoinStatusViewModelProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          IsaJoinStatusViewModel,
          List<IsaJoinStatus>
        > {
  /// See also [IsaJoinStatusViewModel].
  IsaJoinStatusViewModelProvider(
    String pageNo,
    String numOfRows,
    String baseYearMonth,
    String domain,
    String isaForm,
  ) : this._internal(
        () => IsaJoinStatusViewModel()
          ..pageNo = pageNo
          ..numOfRows = numOfRows
          ..baseYearMonth = baseYearMonth
          ..domain = domain
          ..isaForm = isaForm,
        from: isaJoinStatusViewModelProvider,
        name: r'isaJoinStatusViewModelProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$isaJoinStatusViewModelHash,
        dependencies: IsaJoinStatusViewModelFamily._dependencies,
        allTransitiveDependencies:
            IsaJoinStatusViewModelFamily._allTransitiveDependencies,
        pageNo: pageNo,
        numOfRows: numOfRows,
        baseYearMonth: baseYearMonth,
        domain: domain,
        isaForm: isaForm,
      );

  IsaJoinStatusViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.pageNo,
    required this.numOfRows,
    required this.baseYearMonth,
    required this.domain,
    required this.isaForm,
  }) : super.internal();

  final String pageNo;
  final String numOfRows;
  final String baseYearMonth;
  final String domain;
  final String isaForm;

  @override
  FutureOr<List<IsaJoinStatus>> runNotifierBuild(
    covariant IsaJoinStatusViewModel notifier,
  ) {
    return notifier.build(pageNo, numOfRows, baseYearMonth, domain, isaForm);
  }

  @override
  Override overrideWith(IsaJoinStatusViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: IsaJoinStatusViewModelProvider._internal(
        () => create()
          ..pageNo = pageNo
          ..numOfRows = numOfRows
          ..baseYearMonth = baseYearMonth
          ..domain = domain
          ..isaForm = isaForm,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        pageNo: pageNo,
        numOfRows: numOfRows,
        baseYearMonth: baseYearMonth,
        domain: domain,
        isaForm: isaForm,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<
    IsaJoinStatusViewModel,
    List<IsaJoinStatus>
  >
  createElement() {
    return _IsaJoinStatusViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IsaJoinStatusViewModelProvider &&
        other.pageNo == pageNo &&
        other.numOfRows == numOfRows &&
        other.baseYearMonth == baseYearMonth &&
        other.domain == domain &&
        other.isaForm == isaForm;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, pageNo.hashCode);
    hash = _SystemHash.combine(hash, numOfRows.hashCode);
    hash = _SystemHash.combine(hash, baseYearMonth.hashCode);
    hash = _SystemHash.combine(hash, domain.hashCode);
    hash = _SystemHash.combine(hash, isaForm.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin IsaJoinStatusViewModelRef
    on AutoDisposeAsyncNotifierProviderRef<List<IsaJoinStatus>> {
  /// The parameter `pageNo` of this provider.
  String get pageNo;

  /// The parameter `numOfRows` of this provider.
  String get numOfRows;

  /// The parameter `baseYearMonth` of this provider.
  String get baseYearMonth;

  /// The parameter `domain` of this provider.
  String get domain;

  /// The parameter `isaForm` of this provider.
  String get isaForm;
}

class _IsaJoinStatusViewModelProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          IsaJoinStatusViewModel,
          List<IsaJoinStatus>
        >
    with IsaJoinStatusViewModelRef {
  _IsaJoinStatusViewModelProviderElement(super.provider);

  @override
  String get pageNo => (origin as IsaJoinStatusViewModelProvider).pageNo;
  @override
  String get numOfRows => (origin as IsaJoinStatusViewModelProvider).numOfRows;
  @override
  String get baseYearMonth =>
      (origin as IsaJoinStatusViewModelProvider).baseYearMonth;
  @override
  String get domain => (origin as IsaJoinStatusViewModelProvider).domain;
  @override
  String get isaForm => (origin as IsaJoinStatusViewModelProvider).isaForm;
}

String _$isaManagementStatusViewModelHash() =>
    r'3b6957fee677869d7c708175b386243c7992a0de';

abstract class _$IsaManagementStatusViewModel
    extends BuildlessAutoDisposeAsyncNotifier<List<IsaManagementStatus>> {
  late final String pageNo;
  late final String numOfRows;
  late final String baseYearMonth;
  late final String ctg;
  late final String domain;
  late final String isaForm;

  FutureOr<List<IsaManagementStatus>> build(
    String pageNo,
    String numOfRows,
    String baseYearMonth,
    String ctg,
    String domain,
    String isaForm,
  );
}

/// See also [IsaManagementStatusViewModel].
@ProviderFor(IsaManagementStatusViewModel)
const isaManagementStatusViewModelProvider =
    IsaManagementStatusViewModelFamily();

/// See also [IsaManagementStatusViewModel].
class IsaManagementStatusViewModelFamily
    extends Family<AsyncValue<List<IsaManagementStatus>>> {
  /// See also [IsaManagementStatusViewModel].
  const IsaManagementStatusViewModelFamily();

  /// See also [IsaManagementStatusViewModel].
  IsaManagementStatusViewModelProvider call(
    String pageNo,
    String numOfRows,
    String baseYearMonth,
    String ctg,
    String domain,
    String isaForm,
  ) {
    return IsaManagementStatusViewModelProvider(
      pageNo,
      numOfRows,
      baseYearMonth,
      ctg,
      domain,
      isaForm,
    );
  }

  @override
  IsaManagementStatusViewModelProvider getProviderOverride(
    covariant IsaManagementStatusViewModelProvider provider,
  ) {
    return call(
      provider.pageNo,
      provider.numOfRows,
      provider.baseYearMonth,
      provider.ctg,
      provider.domain,
      provider.isaForm,
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
  String? get name => r'isaManagementStatusViewModelProvider';
}

/// See also [IsaManagementStatusViewModel].
class IsaManagementStatusViewModelProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          IsaManagementStatusViewModel,
          List<IsaManagementStatus>
        > {
  /// See also [IsaManagementStatusViewModel].
  IsaManagementStatusViewModelProvider(
    String pageNo,
    String numOfRows,
    String baseYearMonth,
    String ctg,
    String domain,
    String isaForm,
  ) : this._internal(
        () => IsaManagementStatusViewModel()
          ..pageNo = pageNo
          ..numOfRows = numOfRows
          ..baseYearMonth = baseYearMonth
          ..ctg = ctg
          ..domain = domain
          ..isaForm = isaForm,
        from: isaManagementStatusViewModelProvider,
        name: r'isaManagementStatusViewModelProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$isaManagementStatusViewModelHash,
        dependencies: IsaManagementStatusViewModelFamily._dependencies,
        allTransitiveDependencies:
            IsaManagementStatusViewModelFamily._allTransitiveDependencies,
        pageNo: pageNo,
        numOfRows: numOfRows,
        baseYearMonth: baseYearMonth,
        ctg: ctg,
        domain: domain,
        isaForm: isaForm,
      );

  IsaManagementStatusViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.pageNo,
    required this.numOfRows,
    required this.baseYearMonth,
    required this.ctg,
    required this.domain,
    required this.isaForm,
  }) : super.internal();

  final String pageNo;
  final String numOfRows;
  final String baseYearMonth;
  final String ctg;
  final String domain;
  final String isaForm;

  @override
  FutureOr<List<IsaManagementStatus>> runNotifierBuild(
    covariant IsaManagementStatusViewModel notifier,
  ) {
    return notifier.build(
      pageNo,
      numOfRows,
      baseYearMonth,
      ctg,
      domain,
      isaForm,
    );
  }

  @override
  Override overrideWith(IsaManagementStatusViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: IsaManagementStatusViewModelProvider._internal(
        () => create()
          ..pageNo = pageNo
          ..numOfRows = numOfRows
          ..baseYearMonth = baseYearMonth
          ..ctg = ctg
          ..domain = domain
          ..isaForm = isaForm,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        pageNo: pageNo,
        numOfRows: numOfRows,
        baseYearMonth: baseYearMonth,
        ctg: ctg,
        domain: domain,
        isaForm: isaForm,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<
    IsaManagementStatusViewModel,
    List<IsaManagementStatus>
  >
  createElement() {
    return _IsaManagementStatusViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IsaManagementStatusViewModelProvider &&
        other.pageNo == pageNo &&
        other.numOfRows == numOfRows &&
        other.baseYearMonth == baseYearMonth &&
        other.ctg == ctg &&
        other.domain == domain &&
        other.isaForm == isaForm;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, pageNo.hashCode);
    hash = _SystemHash.combine(hash, numOfRows.hashCode);
    hash = _SystemHash.combine(hash, baseYearMonth.hashCode);
    hash = _SystemHash.combine(hash, ctg.hashCode);
    hash = _SystemHash.combine(hash, domain.hashCode);
    hash = _SystemHash.combine(hash, isaForm.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin IsaManagementStatusViewModelRef
    on AutoDisposeAsyncNotifierProviderRef<List<IsaManagementStatus>> {
  /// The parameter `pageNo` of this provider.
  String get pageNo;

  /// The parameter `numOfRows` of this provider.
  String get numOfRows;

  /// The parameter `baseYearMonth` of this provider.
  String get baseYearMonth;

  /// The parameter `ctg` of this provider.
  String get ctg;

  /// The parameter `domain` of this provider.
  String get domain;

  /// The parameter `isaForm` of this provider.
  String get isaForm;
}

class _IsaManagementStatusViewModelProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          IsaManagementStatusViewModel,
          List<IsaManagementStatus>
        >
    with IsaManagementStatusViewModelRef {
  _IsaManagementStatusViewModelProviderElement(super.provider);

  @override
  String get pageNo => (origin as IsaManagementStatusViewModelProvider).pageNo;
  @override
  String get numOfRows =>
      (origin as IsaManagementStatusViewModelProvider).numOfRows;
  @override
  String get baseYearMonth =>
      (origin as IsaManagementStatusViewModelProvider).baseYearMonth;
  @override
  String get ctg => (origin as IsaManagementStatusViewModelProvider).ctg;
  @override
  String get domain => (origin as IsaManagementStatusViewModelProvider).domain;
  @override
  String get isaForm =>
      (origin as IsaManagementStatusViewModelProvider).isaForm;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
