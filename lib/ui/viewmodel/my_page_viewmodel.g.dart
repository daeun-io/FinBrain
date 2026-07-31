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
    extends $AsyncNotifierProvider<MyPageViewmodel, String> {
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
}

String _$myPageViewmodelHash() => r'73f2642d337af641d8973f81981e49af01599c1f';

abstract class _$MyPageViewmodel extends $AsyncNotifier<String> {
  FutureOr<String> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<String>, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<String>, String>,
              AsyncValue<String>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
