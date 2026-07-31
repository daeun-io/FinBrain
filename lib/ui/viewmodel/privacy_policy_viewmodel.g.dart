// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'privacy_policy_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PrivacyPolicyViewmodel)
final privacyPolicyViewmodelProvider = PrivacyPolicyViewmodelProvider._();

final class PrivacyPolicyViewmodelProvider
    extends $AsyncNotifierProvider<PrivacyPolicyViewmodel, String> {
  PrivacyPolicyViewmodelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'privacyPolicyViewmodelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$privacyPolicyViewmodelHash();

  @$internal
  @override
  PrivacyPolicyViewmodel create() => PrivacyPolicyViewmodel();
}

String _$privacyPolicyViewmodelHash() =>
    r'90d7d176fc7f8bbd4c288261d8ff4edc75697cee';

abstract class _$PrivacyPolicyViewmodel extends $AsyncNotifier<String> {
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
