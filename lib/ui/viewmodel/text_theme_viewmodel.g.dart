// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_theme_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TextThemeViewmodel)
final textThemeViewmodelProvider = TextThemeViewmodelProvider._();

final class TextThemeViewmodelProvider
    extends $NotifierProvider<TextThemeViewmodel, TextTheme> {
  TextThemeViewmodelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'textThemeViewmodelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$textThemeViewmodelHash();

  @$internal
  @override
  TextThemeViewmodel create() => TextThemeViewmodel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TextTheme value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TextTheme>(value),
    );
  }
}

String _$textThemeViewmodelHash() =>
    r'c22f9435aefeb866e84ad061644c36e50e374d0b';

abstract class _$TextThemeViewmodel extends $Notifier<TextTheme> {
  TextTheme build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<TextTheme, TextTheme>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<TextTheme, TextTheme>,
              TextTheme,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
