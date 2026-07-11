// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_page_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CurrentPageViewmodel)
final currentPageViewmodelProvider = CurrentPageViewmodelFamily._();

final class CurrentPageViewmodelProvider
    extends $NotifierProvider<CurrentPageViewmodel, int> {
  CurrentPageViewmodelProvider._({
    required CurrentPageViewmodelFamily super.from,
    required ProductCategory super.argument,
  }) : super(
         retry: null,
         name: r'currentPageViewmodelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$currentPageViewmodelHash();

  @override
  String toString() {
    return r'currentPageViewmodelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CurrentPageViewmodel create() => CurrentPageViewmodel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CurrentPageViewmodelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$currentPageViewmodelHash() =>
    r'69fc41514f63cdda5f84e45a8bfd846dcd8a29f4';

final class CurrentPageViewmodelFamily extends $Family
    with
        $ClassFamilyOverride<
          CurrentPageViewmodel,
          int,
          int,
          int,
          ProductCategory
        > {
  CurrentPageViewmodelFamily._()
    : super(
        retry: null,
        name: r'currentPageViewmodelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CurrentPageViewmodelProvider call(ProductCategory ctg) =>
      CurrentPageViewmodelProvider._(argument: ctg, from: this);

  @override
  String toString() => r'currentPageViewmodelProvider';
}

abstract class _$CurrentPageViewmodel extends $Notifier<int> {
  late final _$args = ref.$arg as ProductCategory;
  ProductCategory get ctg => _$args;

  int build(ProductCategory ctg);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
