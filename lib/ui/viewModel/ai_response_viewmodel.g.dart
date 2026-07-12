// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_response_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AiResponseViewmodel)
final aiResponseViewmodelProvider = AiResponseViewmodelFamily._();

final class AiResponseViewmodelProvider
    extends $AsyncNotifierProvider<AiResponseViewmodel, String?> {
  AiResponseViewmodelProvider._({
    required AiResponseViewmodelFamily super.from,
    required (String, FinancialProduct?) super.argument,
  }) : super(
         retry: null,
         name: r'aiResponseViewmodelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$aiResponseViewmodelHash();

  @override
  String toString() {
    return r'aiResponseViewmodelProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  AiResponseViewmodel create() => AiResponseViewmodel();

  @override
  bool operator ==(Object other) {
    return other is AiResponseViewmodelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$aiResponseViewmodelHash() =>
    r'0e861bd9813d4fd84a2abdf4e677aa2e438925d7';

final class AiResponseViewmodelFamily extends $Family
    with
        $ClassFamilyOverride<
          AiResponseViewmodel,
          AsyncValue<String?>,
          String?,
          FutureOr<String?>,
          (String, FinancialProduct?)
        > {
  AiResponseViewmodelFamily._()
    : super(
        retry: null,
        name: r'aiResponseViewmodelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AiResponseViewmodelProvider call(String text, [FinancialProduct? product]) =>
      AiResponseViewmodelProvider._(argument: (text, product), from: this);

  @override
  String toString() => r'aiResponseViewmodelProvider';
}

abstract class _$AiResponseViewmodel extends $AsyncNotifier<String?> {
  late final _$args = ref.$arg as (String, FinancialProduct?);
  String get text => _$args.$1;
  FinancialProduct? get product => _$args.$2;

  FutureOr<String?> build(String text, [FinancialProduct? product]);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<String?>, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<String?>, String?>,
              AsyncValue<String?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args.$1, _$args.$2));
  }
}

@ProviderFor(AiScreenViewmodel)
final aiScreenViewmodelProvider = AiScreenViewmodelFamily._();

final class AiScreenViewmodelProvider
    extends $NotifierProvider<AiScreenViewmodel, List<String>> {
  AiScreenViewmodelProvider._({
    required AiScreenViewmodelFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'aiScreenViewmodelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$aiScreenViewmodelHash();

  @override
  String toString() {
    return r'aiScreenViewmodelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  AiScreenViewmodel create() => AiScreenViewmodel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<String>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is AiScreenViewmodelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$aiScreenViewmodelHash() => r'40bea14613c39c0a0480a2fb35f650d16d93aec2';

final class AiScreenViewmodelFamily extends $Family
    with
        $ClassFamilyOverride<
          AiScreenViewmodel,
          List<String>,
          List<String>,
          List<String>,
          String
        > {
  AiScreenViewmodelFamily._()
    : super(
        retry: null,
        name: r'aiScreenViewmodelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AiScreenViewmodelProvider call(String tag) =>
      AiScreenViewmodelProvider._(argument: tag, from: this);

  @override
  String toString() => r'aiScreenViewmodelProvider';
}

abstract class _$AiScreenViewmodel extends $Notifier<List<String>> {
  late final _$args = ref.$arg as String;
  String get tag => _$args;

  List<String> build(String tag);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<List<String>, List<String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<String>, List<String>>,
              List<String>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(AiComparisonScreenViewmodel)
final aiComparisonScreenViewmodelProvider =
    AiComparisonScreenViewmodelFamily._();

final class AiComparisonScreenViewmodelProvider
    extends $NotifierProvider<AiComparisonScreenViewmodel, String> {
  AiComparisonScreenViewmodelProvider._({
    required AiComparisonScreenViewmodelFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'aiComparisonScreenViewmodelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$aiComparisonScreenViewmodelHash();

  @override
  String toString() {
    return r'aiComparisonScreenViewmodelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  AiComparisonScreenViewmodel create() => AiComparisonScreenViewmodel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is AiComparisonScreenViewmodelProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$aiComparisonScreenViewmodelHash() =>
    r'b35afcfc3762a05a408f56195b9789a992a022f9';

final class AiComparisonScreenViewmodelFamily extends $Family
    with
        $ClassFamilyOverride<
          AiComparisonScreenViewmodel,
          String,
          String,
          String,
          String
        > {
  AiComparisonScreenViewmodelFamily._()
    : super(
        retry: null,
        name: r'aiComparisonScreenViewmodelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AiComparisonScreenViewmodelProvider call(String products) =>
      AiComparisonScreenViewmodelProvider._(argument: products, from: this);

  @override
  String toString() => r'aiComparisonScreenViewmodelProvider';
}

abstract class _$AiComparisonScreenViewmodel extends $Notifier<String> {
  late final _$args = ref.$arg as String;
  String get products => _$args;

  String build(String products);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
