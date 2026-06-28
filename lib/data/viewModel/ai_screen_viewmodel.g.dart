// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_screen_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$aiScreenViewmodelHash() => r'8dc1023de43281817082d82c36b367162b8ed664';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$AiScreenViewmodel
    extends BuildlessAutoDisposeNotifier<Map<String, String>> {
  late final String tag;

  Map<String, String> build(String tag);
}

/// See also [AiScreenViewmodel].
@ProviderFor(AiScreenViewmodel)
const aiScreenViewmodelProvider = AiScreenViewmodelFamily();

/// See also [AiScreenViewmodel].
class AiScreenViewmodelFamily extends Family<Map<String, String>> {
  /// See also [AiScreenViewmodel].
  const AiScreenViewmodelFamily();

  /// See also [AiScreenViewmodel].
  AiScreenViewmodelProvider call(String tag) {
    return AiScreenViewmodelProvider(tag);
  }

  @override
  AiScreenViewmodelProvider getProviderOverride(
    covariant AiScreenViewmodelProvider provider,
  ) {
    return call(provider.tag);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'aiScreenViewmodelProvider';
}

/// See also [AiScreenViewmodel].
class AiScreenViewmodelProvider
    extends
        AutoDisposeNotifierProviderImpl<
          AiScreenViewmodel,
          Map<String, String>
        > {
  /// See also [AiScreenViewmodel].
  AiScreenViewmodelProvider(String tag)
    : this._internal(
        () => AiScreenViewmodel()..tag = tag,
        from: aiScreenViewmodelProvider,
        name: r'aiScreenViewmodelProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$aiScreenViewmodelHash,
        dependencies: AiScreenViewmodelFamily._dependencies,
        allTransitiveDependencies:
            AiScreenViewmodelFamily._allTransitiveDependencies,
        tag: tag,
      );

  AiScreenViewmodelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tag,
  }) : super.internal();

  final String tag;

  @override
  Map<String, String> runNotifierBuild(covariant AiScreenViewmodel notifier) {
    return notifier.build(tag);
  }

  @override
  Override overrideWith(AiScreenViewmodel Function() create) {
    return ProviderOverride(
      origin: this,
      override: AiScreenViewmodelProvider._internal(
        () => create()..tag = tag,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        tag: tag,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<AiScreenViewmodel, Map<String, String>>
  createElement() {
    return _AiScreenViewmodelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AiScreenViewmodelProvider && other.tag == tag;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tag.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AiScreenViewmodelRef
    on AutoDisposeNotifierProviderRef<Map<String, String>> {
  /// The parameter `tag` of this provider.
  String get tag;
}

class _AiScreenViewmodelProviderElement
    extends
        AutoDisposeNotifierProviderElement<
          AiScreenViewmodel,
          Map<String, String>
        >
    with AiScreenViewmodelRef {
  _AiScreenViewmodelProviderElement(super.provider);

  @override
  String get tag => (origin as AiScreenViewmodelProvider).tag;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
