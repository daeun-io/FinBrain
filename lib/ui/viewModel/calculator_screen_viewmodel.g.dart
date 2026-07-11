// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calculator_screen_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CalculatorScreenViewmodel)
final calculatorScreenViewmodelProvider = CalculatorScreenViewmodelProvider._();

final class CalculatorScreenViewmodelProvider
    extends $NotifierProvider<CalculatorScreenViewmodel, List<double>> {
  CalculatorScreenViewmodelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'calculatorScreenViewmodelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$calculatorScreenViewmodelHash();

  @$internal
  @override
  CalculatorScreenViewmodel create() => CalculatorScreenViewmodel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<double> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<double>>(value),
    );
  }
}

String _$calculatorScreenViewmodelHash() =>
    r'be749d9d76861f985bc852c46069cc9865acc0b6';

abstract class _$CalculatorScreenViewmodel extends $Notifier<List<double>> {
  List<double> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<List<double>, List<double>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<double>, List<double>>,
              List<double>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
