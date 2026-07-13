// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared_preferences_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SharedPreferencesViewmodel)
final sharedPreferencesViewmodelProvider =
    SharedPreferencesViewmodelProvider._();

final class SharedPreferencesViewmodelProvider
    extends $AsyncNotifierProvider<SharedPreferencesViewmodel, bool> {
  SharedPreferencesViewmodelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sharedPreferencesViewmodelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sharedPreferencesViewmodelHash();

  @$internal
  @override
  SharedPreferencesViewmodel create() => SharedPreferencesViewmodel();
}

String _$sharedPreferencesViewmodelHash() =>
    r'dd610d16640ae310aef755877144e9c766484831';

abstract class _$SharedPreferencesViewmodel extends $AsyncNotifier<bool> {
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
