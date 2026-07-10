// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sort_or_filter_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SortOrFilterTextViewModel)
final sortOrFilterTextViewModelProvider = SortOrFilterTextViewModelFamily._();

final class SortOrFilterTextViewModelProvider
    extends
        $NotifierProvider<SortOrFilterTextViewModel, (Object, List<String>)> {
  SortOrFilterTextViewModelProvider._({
    required SortOrFilterTextViewModelFamily super.from,
    required ProductCategory super.argument,
  }) : super(
         retry: null,
         name: r'sortOrFilterTextViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$sortOrFilterTextViewModelHash();

  @override
  String toString() {
    return r'sortOrFilterTextViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  SortOrFilterTextViewModel create() => SortOrFilterTextViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue((Object, List<String>) value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<(Object, List<String>)>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SortOrFilterTextViewModelProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$sortOrFilterTextViewModelHash() =>
    r'2418860915a1b49ba3702b707c03603967fb5612';

final class SortOrFilterTextViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          SortOrFilterTextViewModel,
          (Object, List<String>),
          (Object, List<String>),
          (Object, List<String>),
          ProductCategory
        > {
  SortOrFilterTextViewModelFamily._()
    : super(
        retry: null,
        name: r'sortOrFilterTextViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SortOrFilterTextViewModelProvider call(ProductCategory category) =>
      SortOrFilterTextViewModelProvider._(argument: category, from: this);

  @override
  String toString() => r'sortOrFilterTextViewModelProvider';
}

abstract class _$SortOrFilterTextViewModel
    extends $Notifier<(Object, List<String>)> {
  late final _$args = ref.$arg as ProductCategory;
  ProductCategory get category => _$args;

  (Object, List<String>) build(ProductCategory category);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<(Object, List<String>), (Object, List<String>)>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<(Object, List<String>), (Object, List<String>)>,
              (Object, List<String>),
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
