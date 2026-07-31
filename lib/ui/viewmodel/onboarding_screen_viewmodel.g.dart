// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_screen_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(OnboardingScreenViewmodel)
final onboardingScreenViewmodelProvider = OnboardingScreenViewmodelFamily._();

final class OnboardingScreenViewmodelProvider
    extends $AsyncNotifierProvider<OnboardingScreenViewmodel, bool?> {
  OnboardingScreenViewmodelProvider._({
    required OnboardingScreenViewmodelFamily super.from,
    required User? super.argument,
  }) : super(
         retry: null,
         name: r'onboardingScreenViewmodelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$onboardingScreenViewmodelHash();

  @override
  String toString() {
    return r'onboardingScreenViewmodelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  OnboardingScreenViewmodel create() => OnboardingScreenViewmodel();

  @override
  bool operator ==(Object other) {
    return other is OnboardingScreenViewmodelProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$onboardingScreenViewmodelHash() =>
    r'4dcab531150ed15881a108c5eb743ce30152c190';

final class OnboardingScreenViewmodelFamily extends $Family
    with
        $ClassFamilyOverride<
          OnboardingScreenViewmodel,
          AsyncValue<bool?>,
          bool?,
          FutureOr<bool?>,
          User?
        > {
  OnboardingScreenViewmodelFamily._()
    : super(
        retry: null,
        name: r'onboardingScreenViewmodelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  OnboardingScreenViewmodelProvider call(User? user) =>
      OnboardingScreenViewmodelProvider._(argument: user, from: this);

  @override
  String toString() => r'onboardingScreenViewmodelProvider';
}

abstract class _$OnboardingScreenViewmodel extends $AsyncNotifier<bool?> {
  late final _$args = ref.$arg as User?;
  User? get user => _$args;

  FutureOr<bool?> build(User? user);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<bool?>, bool?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<bool?>, bool?>,
              AsyncValue<bool?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
