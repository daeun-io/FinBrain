// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_comp_tutorial_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AiCompTutorialViewmodel)
final aiCompTutorialViewmodelProvider = AiCompTutorialViewmodelProvider._();

final class AiCompTutorialViewmodelProvider
    extends $AsyncNotifierProvider<AiCompTutorialViewmodel, bool> {
  AiCompTutorialViewmodelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'aiCompTutorialViewmodelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$aiCompTutorialViewmodelHash();

  @$internal
  @override
  AiCompTutorialViewmodel create() => AiCompTutorialViewmodel();
}

String _$aiCompTutorialViewmodelHash() =>
    r'984bbcb33ca11a5a0c85d3f2c3273864e3166f24';

abstract class _$AiCompTutorialViewmodel extends $AsyncNotifier<bool> {
  FutureOr<bool> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<bool>, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<bool>, bool>,
              AsyncValue<bool>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
