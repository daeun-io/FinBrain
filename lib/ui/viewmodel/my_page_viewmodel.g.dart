// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_page_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MyPageViewmodel)
final myPageViewmodelProvider = MyPageViewmodelProvider._();

final class MyPageViewmodelProvider
    extends $NotifierProvider<MyPageViewmodel, bool> {
  MyPageViewmodelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myPageViewmodelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myPageViewmodelHash();

  @$internal
  @override
  MyPageViewmodel create() => MyPageViewmodel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$myPageViewmodelHash() => r'f8d942483cbbb1afc9a320ca79ce0de593df69ea';

abstract class _$MyPageViewmodel extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
