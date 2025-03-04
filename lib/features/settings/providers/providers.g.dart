// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$isUncategorizedViewPreferredHash() =>
    r'a7c8de636ff021af75ee132d282b77b8ce1d2abb';

/// See also [isUncategorizedViewPreferred].
@ProviderFor(isUncategorizedViewPreferred)
final isUncategorizedViewPreferredProvider = AutoDisposeProvider<bool>.internal(
  isUncategorizedViewPreferred,
  name: r'isUncategorizedViewPreferredProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isUncategorizedViewPreferredHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsUncategorizedViewPreferredRef = AutoDisposeProviderRef<bool>;
String _$savedLocaleHash() => r'7be84ecae3597e353924fb600b440df2c788261d';

/// See also [savedLocale].
@ProviderFor(savedLocale)
final savedLocaleProvider = AutoDisposeFutureProvider<String?>.internal(
  savedLocale,
  name: r'savedLocaleProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$savedLocaleHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SavedLocaleRef = AutoDisposeFutureProviderRef<String?>;
String _$appLocaleHash() => r'0fa73cd256bb9ad2e2c66ffb3dd86bf0a2c7f6db';

/// See also [AppLocale].
@ProviderFor(AppLocale)
final appLocaleProvider =
    AutoDisposeNotifierProvider<AppLocale, Locale?>.internal(
  AppLocale.new,
  name: r'appLocaleProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$appLocaleHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AppLocale = AutoDisposeNotifier<Locale?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
