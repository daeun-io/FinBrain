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

@ProviderFor(AiAssistScreenViewmodel)
final aiAssistScreenViewmodelProvider = AiAssistScreenViewmodelFamily._();

final class AiAssistScreenViewmodelProvider
    extends $NotifierProvider<AiAssistScreenViewmodel, List<String>> {
  AiAssistScreenViewmodelProvider._({
    required AiAssistScreenViewmodelFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'aiAssistScreenViewmodelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$aiAssistScreenViewmodelHash();

  @override
  String toString() {
    return r'aiAssistScreenViewmodelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  AiAssistScreenViewmodel create() => AiAssistScreenViewmodel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<String>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is AiAssistScreenViewmodelProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$aiAssistScreenViewmodelHash() =>
    r'5aeb289ffaf0986b28289dddc9aad2e410ec8c2b';

final class AiAssistScreenViewmodelFamily extends $Family
    with
        $ClassFamilyOverride<
          AiAssistScreenViewmodel,
          List<String>,
          List<String>,
          List<String>,
          String
        > {
  AiAssistScreenViewmodelFamily._()
    : super(
        retry: null,
        name: r'aiAssistScreenViewmodelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AiAssistScreenViewmodelProvider call(String tag) =>
      AiAssistScreenViewmodelProvider._(argument: tag, from: this);

  @override
  String toString() => r'aiAssistScreenViewmodelProvider';
}

abstract class _$AiAssistScreenViewmodel extends $Notifier<List<String>> {
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
    extends $AsyncNotifierProvider<AiComparisonScreenViewmodel, String> {
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
    r'2a671c4d4116774477dcb1abc1f95763fed020ba';

final class AiComparisonScreenViewmodelFamily extends $Family
    with
        $ClassFamilyOverride<
          AiComparisonScreenViewmodel,
          AsyncValue<String>,
          String,
          FutureOr<String>,
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

  AiComparisonScreenViewmodelProvider call(String text) =>
      AiComparisonScreenViewmodelProvider._(argument: text, from: this);

  @override
  String toString() => r'aiComparisonScreenViewmodelProvider';
}

abstract class _$AiComparisonScreenViewmodel extends $AsyncNotifier<String> {
  late final _$args = ref.$arg as String;
  String get text => _$args;

  FutureOr<String> build(String text);
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
    return element.handleCreate(ref, () => build(_$args));
  }
}
