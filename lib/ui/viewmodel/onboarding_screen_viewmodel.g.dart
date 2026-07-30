// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_screen_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(OnboardingScreenViewmodel)
final onboardingScreenViewmodelProvider = OnboardingScreenViewmodelProvider._();

final class OnboardingScreenViewmodelProvider
    extends $NotifierProvider<OnboardingScreenViewmodel, int> {
  OnboardingScreenViewmodelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onboardingScreenViewmodelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$onboardingScreenViewmodelHash();

  @$internal
  @override
  OnboardingScreenViewmodel create() => OnboardingScreenViewmodel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$onboardingScreenViewmodelHash() =>
    r'9604ff82ec9bee67cbb4780802ec96d5859dca52';

abstract class _$OnboardingScreenViewmodel extends $Notifier<int> {
  int build();
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
    return element.handleCreate(ref, build);
  }
}
