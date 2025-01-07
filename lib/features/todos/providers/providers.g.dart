// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$numberOfAllActiveTasksHash() =>
    r'719f041b69dcf6d7eb7a7c5c1685f3f9d37f1628';

/// See also [numberOfAllActiveTasks].
@ProviderFor(numberOfAllActiveTasks)
final numberOfAllActiveTasksProvider = AutoDisposeProvider<int>.internal(
  numberOfAllActiveTasks,
  name: r'numberOfAllActiveTasksProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$numberOfAllActiveTasksHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NumberOfAllActiveTasksRef = AutoDisposeProviderRef<int>;
String _$uncategorizedTasksHash() =>
    r'4013d9e97aa3b92db43ebc03e1de7430fecea4e3';

/// See also [uncategorizedTasks].
@ProviderFor(uncategorizedTasks)
final uncategorizedTasksProvider = AutoDisposeProvider<List<Task>>.internal(
  uncategorizedTasks,
  name: r'uncategorizedTasksProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$uncategorizedTasksHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UncategorizedTasksRef = AutoDisposeProviderRef<List<Task>>;
String _$numberOfActiveTasksInCategoryHash() =>
    r'5117cb5433e813fcbe37446632c0763e38ff9a19';

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

/// See also [numberOfActiveTasksInCategory].
@ProviderFor(numberOfActiveTasksInCategory)
const numberOfActiveTasksInCategoryProvider =
    NumberOfActiveTasksInCategoryFamily();

/// See also [numberOfActiveTasksInCategory].
class NumberOfActiveTasksInCategoryFamily extends Family<int> {
  /// See also [numberOfActiveTasksInCategory].
  const NumberOfActiveTasksInCategoryFamily();

  /// See also [numberOfActiveTasksInCategory].
  NumberOfActiveTasksInCategoryProvider call(
    int? categoryId,
  ) {
    return NumberOfActiveTasksInCategoryProvider(
      categoryId,
    );
  }

  @override
  NumberOfActiveTasksInCategoryProvider getProviderOverride(
    covariant NumberOfActiveTasksInCategoryProvider provider,
  ) {
    return call(
      provider.categoryId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'numberOfActiveTasksInCategoryProvider';
}

/// See also [numberOfActiveTasksInCategory].
class NumberOfActiveTasksInCategoryProvider extends AutoDisposeProvider<int> {
  /// See also [numberOfActiveTasksInCategory].
  NumberOfActiveTasksInCategoryProvider(
    int? categoryId,
  ) : this._internal(
          (ref) => numberOfActiveTasksInCategory(
            ref as NumberOfActiveTasksInCategoryRef,
            categoryId,
          ),
          from: numberOfActiveTasksInCategoryProvider,
          name: r'numberOfActiveTasksInCategoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$numberOfActiveTasksInCategoryHash,
          dependencies: NumberOfActiveTasksInCategoryFamily._dependencies,
          allTransitiveDependencies:
              NumberOfActiveTasksInCategoryFamily._allTransitiveDependencies,
          categoryId: categoryId,
        );

  NumberOfActiveTasksInCategoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.categoryId,
  }) : super.internal();

  final int? categoryId;

  @override
  Override overrideWith(
    int Function(NumberOfActiveTasksInCategoryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: NumberOfActiveTasksInCategoryProvider._internal(
        (ref) => create(ref as NumberOfActiveTasksInCategoryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        categoryId: categoryId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<int> createElement() {
    return _NumberOfActiveTasksInCategoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is NumberOfActiveTasksInCategoryProvider &&
        other.categoryId == categoryId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, categoryId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin NumberOfActiveTasksInCategoryRef on AutoDisposeProviderRef<int> {
  /// The parameter `categoryId` of this provider.
  int? get categoryId;
}

class _NumberOfActiveTasksInCategoryProviderElement
    extends AutoDisposeProviderElement<int>
    with NumberOfActiveTasksInCategoryRef {
  _NumberOfActiveTasksInCategoryProviderElement(super.provider);

  @override
  int? get categoryId =>
      (origin as NumberOfActiveTasksInCategoryProvider).categoryId;
}

String _$completionProgressHash() =>
    r'1756a0d46961b8765f18fdca1869bd71f065e82d';

/// See also [completionProgress].
@ProviderFor(completionProgress)
const completionProgressProvider = CompletionProgressFamily();

/// See also [completionProgress].
class CompletionProgressFamily extends Family<double> {
  /// See also [completionProgress].
  const CompletionProgressFamily();

  /// See also [completionProgress].
  CompletionProgressProvider call(
    int categoryId,
  ) {
    return CompletionProgressProvider(
      categoryId,
    );
  }

  @override
  CompletionProgressProvider getProviderOverride(
    covariant CompletionProgressProvider provider,
  ) {
    return call(
      provider.categoryId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'completionProgressProvider';
}

/// See also [completionProgress].
class CompletionProgressProvider extends AutoDisposeProvider<double> {
  /// See also [completionProgress].
  CompletionProgressProvider(
    int categoryId,
  ) : this._internal(
          (ref) => completionProgress(
            ref as CompletionProgressRef,
            categoryId,
          ),
          from: completionProgressProvider,
          name: r'completionProgressProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$completionProgressHash,
          dependencies: CompletionProgressFamily._dependencies,
          allTransitiveDependencies:
              CompletionProgressFamily._allTransitiveDependencies,
          categoryId: categoryId,
        );

  CompletionProgressProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.categoryId,
  }) : super.internal();

  final int categoryId;

  @override
  Override overrideWith(
    double Function(CompletionProgressRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CompletionProgressProvider._internal(
        (ref) => create(ref as CompletionProgressRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        categoryId: categoryId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<double> createElement() {
    return _CompletionProgressProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CompletionProgressProvider &&
        other.categoryId == categoryId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, categoryId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CompletionProgressRef on AutoDisposeProviderRef<double> {
  /// The parameter `categoryId` of this provider.
  int get categoryId;
}

class _CompletionProgressProviderElement
    extends AutoDisposeProviderElement<double> with CompletionProgressRef {
  _CompletionProgressProviderElement(super.provider);

  @override
  int get categoryId => (origin as CompletionProgressProvider).categoryId;
}

String _$appBackgroundColorHash() =>
    r'acbf96cc00128f489e688f83fea140e606ea9e00';

/// See also [appBackgroundColor].
@ProviderFor(appBackgroundColor)
final appBackgroundColorProvider = AutoDisposeProvider<Color>.internal(
  appBackgroundColor,
  name: r'appBackgroundColorProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$appBackgroundColorHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AppBackgroundColorRef = AutoDisposeProviderRef<Color>;
String _$noDueDateTasksInCategoryHash() =>
    r'5b5a0d5dd1ed3f15b28b4a1067654bd8b6775aec';

abstract class _$NoDueDateTasksInCategory
    extends BuildlessAutoDisposeNotifier<List<Task>> {
  late final int categoryId;

  List<Task> build(
    int categoryId,
  );
}

/// See also [NoDueDateTasksInCategory].
@ProviderFor(NoDueDateTasksInCategory)
const noDueDateTasksInCategoryProvider = NoDueDateTasksInCategoryFamily();

/// See also [NoDueDateTasksInCategory].
class NoDueDateTasksInCategoryFamily extends Family<List<Task>> {
  /// See also [NoDueDateTasksInCategory].
  const NoDueDateTasksInCategoryFamily();

  /// See also [NoDueDateTasksInCategory].
  NoDueDateTasksInCategoryProvider call(
    int categoryId,
  ) {
    return NoDueDateTasksInCategoryProvider(
      categoryId,
    );
  }

  @override
  NoDueDateTasksInCategoryProvider getProviderOverride(
    covariant NoDueDateTasksInCategoryProvider provider,
  ) {
    return call(
      provider.categoryId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'noDueDateTasksInCategoryProvider';
}

/// See also [NoDueDateTasksInCategory].
class NoDueDateTasksInCategoryProvider extends AutoDisposeNotifierProviderImpl<
    NoDueDateTasksInCategory, List<Task>> {
  /// See also [NoDueDateTasksInCategory].
  NoDueDateTasksInCategoryProvider(
    int categoryId,
  ) : this._internal(
          () => NoDueDateTasksInCategory()..categoryId = categoryId,
          from: noDueDateTasksInCategoryProvider,
          name: r'noDueDateTasksInCategoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$noDueDateTasksInCategoryHash,
          dependencies: NoDueDateTasksInCategoryFamily._dependencies,
          allTransitiveDependencies:
              NoDueDateTasksInCategoryFamily._allTransitiveDependencies,
          categoryId: categoryId,
        );

  NoDueDateTasksInCategoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.categoryId,
  }) : super.internal();

  final int categoryId;

  @override
  List<Task> runNotifierBuild(
    covariant NoDueDateTasksInCategory notifier,
  ) {
    return notifier.build(
      categoryId,
    );
  }

  @override
  Override overrideWith(NoDueDateTasksInCategory Function() create) {
    return ProviderOverride(
      origin: this,
      override: NoDueDateTasksInCategoryProvider._internal(
        () => create()..categoryId = categoryId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        categoryId: categoryId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<NoDueDateTasksInCategory, List<Task>>
      createElement() {
    return _NoDueDateTasksInCategoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is NoDueDateTasksInCategoryProvider &&
        other.categoryId == categoryId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, categoryId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin NoDueDateTasksInCategoryRef
    on AutoDisposeNotifierProviderRef<List<Task>> {
  /// The parameter `categoryId` of this provider.
  int get categoryId;
}

class _NoDueDateTasksInCategoryProviderElement
    extends AutoDisposeNotifierProviderElement<NoDueDateTasksInCategory,
        List<Task>> with NoDueDateTasksInCategoryRef {
  _NoDueDateTasksInCategoryProviderElement(super.provider);

  @override
  int get categoryId => (origin as NoDueDateTasksInCategoryProvider).categoryId;
}

String _$overdueTasksInCategoryHash() =>
    r'e3bb599b9baab91c01b406ed38f8c35b772163e8';

abstract class _$OverdueTasksInCategory
    extends BuildlessAutoDisposeNotifier<List<Task>> {
  late final int categoryId;

  List<Task> build(
    int categoryId,
  );
}

/// See also [OverdueTasksInCategory].
@ProviderFor(OverdueTasksInCategory)
const overdueTasksInCategoryProvider = OverdueTasksInCategoryFamily();

/// See also [OverdueTasksInCategory].
class OverdueTasksInCategoryFamily extends Family<List<Task>> {
  /// See also [OverdueTasksInCategory].
  const OverdueTasksInCategoryFamily();

  /// See also [OverdueTasksInCategory].
  OverdueTasksInCategoryProvider call(
    int categoryId,
  ) {
    return OverdueTasksInCategoryProvider(
      categoryId,
    );
  }

  @override
  OverdueTasksInCategoryProvider getProviderOverride(
    covariant OverdueTasksInCategoryProvider provider,
  ) {
    return call(
      provider.categoryId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'overdueTasksInCategoryProvider';
}

/// See also [OverdueTasksInCategory].
class OverdueTasksInCategoryProvider extends AutoDisposeNotifierProviderImpl<
    OverdueTasksInCategory, List<Task>> {
  /// See also [OverdueTasksInCategory].
  OverdueTasksInCategoryProvider(
    int categoryId,
  ) : this._internal(
          () => OverdueTasksInCategory()..categoryId = categoryId,
          from: overdueTasksInCategoryProvider,
          name: r'overdueTasksInCategoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$overdueTasksInCategoryHash,
          dependencies: OverdueTasksInCategoryFamily._dependencies,
          allTransitiveDependencies:
              OverdueTasksInCategoryFamily._allTransitiveDependencies,
          categoryId: categoryId,
        );

  OverdueTasksInCategoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.categoryId,
  }) : super.internal();

  final int categoryId;

  @override
  List<Task> runNotifierBuild(
    covariant OverdueTasksInCategory notifier,
  ) {
    return notifier.build(
      categoryId,
    );
  }

  @override
  Override overrideWith(OverdueTasksInCategory Function() create) {
    return ProviderOverride(
      origin: this,
      override: OverdueTasksInCategoryProvider._internal(
        () => create()..categoryId = categoryId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        categoryId: categoryId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<OverdueTasksInCategory, List<Task>>
      createElement() {
    return _OverdueTasksInCategoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OverdueTasksInCategoryProvider &&
        other.categoryId == categoryId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, categoryId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin OverdueTasksInCategoryRef on AutoDisposeNotifierProviderRef<List<Task>> {
  /// The parameter `categoryId` of this provider.
  int get categoryId;
}

class _OverdueTasksInCategoryProviderElement
    extends AutoDisposeNotifierProviderElement<OverdueTasksInCategory,
        List<Task>> with OverdueTasksInCategoryRef {
  _OverdueTasksInCategoryProviderElement(super.provider);

  @override
  int get categoryId => (origin as OverdueTasksInCategoryProvider).categoryId;
}

String _$todayTasksInCategoryHash() =>
    r'11593ab944967b182bd816511867af5510768714';

abstract class _$TodayTasksInCategory
    extends BuildlessAutoDisposeNotifier<List<Task>> {
  late final int categoryId;

  List<Task> build(
    int categoryId,
  );
}

/// See also [TodayTasksInCategory].
@ProviderFor(TodayTasksInCategory)
const todayTasksInCategoryProvider = TodayTasksInCategoryFamily();

/// See also [TodayTasksInCategory].
class TodayTasksInCategoryFamily extends Family<List<Task>> {
  /// See also [TodayTasksInCategory].
  const TodayTasksInCategoryFamily();

  /// See also [TodayTasksInCategory].
  TodayTasksInCategoryProvider call(
    int categoryId,
  ) {
    return TodayTasksInCategoryProvider(
      categoryId,
    );
  }

  @override
  TodayTasksInCategoryProvider getProviderOverride(
    covariant TodayTasksInCategoryProvider provider,
  ) {
    return call(
      provider.categoryId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'todayTasksInCategoryProvider';
}

/// See also [TodayTasksInCategory].
class TodayTasksInCategoryProvider
    extends AutoDisposeNotifierProviderImpl<TodayTasksInCategory, List<Task>> {
  /// See also [TodayTasksInCategory].
  TodayTasksInCategoryProvider(
    int categoryId,
  ) : this._internal(
          () => TodayTasksInCategory()..categoryId = categoryId,
          from: todayTasksInCategoryProvider,
          name: r'todayTasksInCategoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$todayTasksInCategoryHash,
          dependencies: TodayTasksInCategoryFamily._dependencies,
          allTransitiveDependencies:
              TodayTasksInCategoryFamily._allTransitiveDependencies,
          categoryId: categoryId,
        );

  TodayTasksInCategoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.categoryId,
  }) : super.internal();

  final int categoryId;

  @override
  List<Task> runNotifierBuild(
    covariant TodayTasksInCategory notifier,
  ) {
    return notifier.build(
      categoryId,
    );
  }

  @override
  Override overrideWith(TodayTasksInCategory Function() create) {
    return ProviderOverride(
      origin: this,
      override: TodayTasksInCategoryProvider._internal(
        () => create()..categoryId = categoryId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        categoryId: categoryId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<TodayTasksInCategory, List<Task>>
      createElement() {
    return _TodayTasksInCategoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TodayTasksInCategoryProvider &&
        other.categoryId == categoryId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, categoryId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TodayTasksInCategoryRef on AutoDisposeNotifierProviderRef<List<Task>> {
  /// The parameter `categoryId` of this provider.
  int get categoryId;
}

class _TodayTasksInCategoryProviderElement
    extends AutoDisposeNotifierProviderElement<TodayTasksInCategory, List<Task>>
    with TodayTasksInCategoryRef {
  _TodayTasksInCategoryProviderElement(super.provider);

  @override
  int get categoryId => (origin as TodayTasksInCategoryProvider).categoryId;
}

String _$tomorrowTasksInCategoryHash() =>
    r'98f7e318b5401e0f31bac981dce51e9d034fa361';

abstract class _$TomorrowTasksInCategory
    extends BuildlessAutoDisposeNotifier<List<Task>> {
  late final int categoryId;

  List<Task> build(
    int categoryId,
  );
}

/// See also [TomorrowTasksInCategory].
@ProviderFor(TomorrowTasksInCategory)
const tomorrowTasksInCategoryProvider = TomorrowTasksInCategoryFamily();

/// See also [TomorrowTasksInCategory].
class TomorrowTasksInCategoryFamily extends Family<List<Task>> {
  /// See also [TomorrowTasksInCategory].
  const TomorrowTasksInCategoryFamily();

  /// See also [TomorrowTasksInCategory].
  TomorrowTasksInCategoryProvider call(
    int categoryId,
  ) {
    return TomorrowTasksInCategoryProvider(
      categoryId,
    );
  }

  @override
  TomorrowTasksInCategoryProvider getProviderOverride(
    covariant TomorrowTasksInCategoryProvider provider,
  ) {
    return call(
      provider.categoryId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'tomorrowTasksInCategoryProvider';
}

/// See also [TomorrowTasksInCategory].
class TomorrowTasksInCategoryProvider extends AutoDisposeNotifierProviderImpl<
    TomorrowTasksInCategory, List<Task>> {
  /// See also [TomorrowTasksInCategory].
  TomorrowTasksInCategoryProvider(
    int categoryId,
  ) : this._internal(
          () => TomorrowTasksInCategory()..categoryId = categoryId,
          from: tomorrowTasksInCategoryProvider,
          name: r'tomorrowTasksInCategoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$tomorrowTasksInCategoryHash,
          dependencies: TomorrowTasksInCategoryFamily._dependencies,
          allTransitiveDependencies:
              TomorrowTasksInCategoryFamily._allTransitiveDependencies,
          categoryId: categoryId,
        );

  TomorrowTasksInCategoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.categoryId,
  }) : super.internal();

  final int categoryId;

  @override
  List<Task> runNotifierBuild(
    covariant TomorrowTasksInCategory notifier,
  ) {
    return notifier.build(
      categoryId,
    );
  }

  @override
  Override overrideWith(TomorrowTasksInCategory Function() create) {
    return ProviderOverride(
      origin: this,
      override: TomorrowTasksInCategoryProvider._internal(
        () => create()..categoryId = categoryId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        categoryId: categoryId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<TomorrowTasksInCategory, List<Task>>
      createElement() {
    return _TomorrowTasksInCategoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TomorrowTasksInCategoryProvider &&
        other.categoryId == categoryId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, categoryId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TomorrowTasksInCategoryRef on AutoDisposeNotifierProviderRef<List<Task>> {
  /// The parameter `categoryId` of this provider.
  int get categoryId;
}

class _TomorrowTasksInCategoryProviderElement
    extends AutoDisposeNotifierProviderElement<TomorrowTasksInCategory,
        List<Task>> with TomorrowTasksInCategoryRef {
  _TomorrowTasksInCategoryProviderElement(super.provider);

  @override
  int get categoryId => (origin as TomorrowTasksInCategoryProvider).categoryId;
}

String _$futureTasksInCategoryHash() =>
    r'b41e361f4f1543603ffcbc89c642a0632fd0bea6';

abstract class _$FutureTasksInCategory
    extends BuildlessAutoDisposeNotifier<List<Task>> {
  late final int categoryId;

  List<Task> build(
    int categoryId,
  );
}

/// See also [FutureTasksInCategory].
@ProviderFor(FutureTasksInCategory)
const futureTasksInCategoryProvider = FutureTasksInCategoryFamily();

/// See also [FutureTasksInCategory].
class FutureTasksInCategoryFamily extends Family<List<Task>> {
  /// See also [FutureTasksInCategory].
  const FutureTasksInCategoryFamily();

  /// See also [FutureTasksInCategory].
  FutureTasksInCategoryProvider call(
    int categoryId,
  ) {
    return FutureTasksInCategoryProvider(
      categoryId,
    );
  }

  @override
  FutureTasksInCategoryProvider getProviderOverride(
    covariant FutureTasksInCategoryProvider provider,
  ) {
    return call(
      provider.categoryId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'futureTasksInCategoryProvider';
}

/// See also [FutureTasksInCategory].
class FutureTasksInCategoryProvider
    extends AutoDisposeNotifierProviderImpl<FutureTasksInCategory, List<Task>> {
  /// See also [FutureTasksInCategory].
  FutureTasksInCategoryProvider(
    int categoryId,
  ) : this._internal(
          () => FutureTasksInCategory()..categoryId = categoryId,
          from: futureTasksInCategoryProvider,
          name: r'futureTasksInCategoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$futureTasksInCategoryHash,
          dependencies: FutureTasksInCategoryFamily._dependencies,
          allTransitiveDependencies:
              FutureTasksInCategoryFamily._allTransitiveDependencies,
          categoryId: categoryId,
        );

  FutureTasksInCategoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.categoryId,
  }) : super.internal();

  final int categoryId;

  @override
  List<Task> runNotifierBuild(
    covariant FutureTasksInCategory notifier,
  ) {
    return notifier.build(
      categoryId,
    );
  }

  @override
  Override overrideWith(FutureTasksInCategory Function() create) {
    return ProviderOverride(
      origin: this,
      override: FutureTasksInCategoryProvider._internal(
        () => create()..categoryId = categoryId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        categoryId: categoryId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<FutureTasksInCategory, List<Task>>
      createElement() {
    return _FutureTasksInCategoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FutureTasksInCategoryProvider &&
        other.categoryId == categoryId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, categoryId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FutureTasksInCategoryRef on AutoDisposeNotifierProviderRef<List<Task>> {
  /// The parameter `categoryId` of this provider.
  int get categoryId;
}

class _FutureTasksInCategoryProviderElement
    extends AutoDisposeNotifierProviderElement<FutureTasksInCategory,
        List<Task>> with FutureTasksInCategoryRef {
  _FutureTasksInCategoryProviderElement(super.provider);

  @override
  int get categoryId => (origin as FutureTasksInCategoryProvider).categoryId;
}

String _$todayCompletedTasksInCategoryHash() =>
    r'a847508c52907d12eeaf8a39e5b149191d3e50f9';

abstract class _$TodayCompletedTasksInCategory
    extends BuildlessAutoDisposeNotifier<List<Task>> {
  late final int categoryId;

  List<Task> build(
    int categoryId,
  );
}

/// See also [TodayCompletedTasksInCategory].
@ProviderFor(TodayCompletedTasksInCategory)
const todayCompletedTasksInCategoryProvider =
    TodayCompletedTasksInCategoryFamily();

/// See also [TodayCompletedTasksInCategory].
class TodayCompletedTasksInCategoryFamily extends Family<List<Task>> {
  /// See also [TodayCompletedTasksInCategory].
  const TodayCompletedTasksInCategoryFamily();

  /// See also [TodayCompletedTasksInCategory].
  TodayCompletedTasksInCategoryProvider call(
    int categoryId,
  ) {
    return TodayCompletedTasksInCategoryProvider(
      categoryId,
    );
  }

  @override
  TodayCompletedTasksInCategoryProvider getProviderOverride(
    covariant TodayCompletedTasksInCategoryProvider provider,
  ) {
    return call(
      provider.categoryId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'todayCompletedTasksInCategoryProvider';
}

/// See also [TodayCompletedTasksInCategory].
class TodayCompletedTasksInCategoryProvider
    extends AutoDisposeNotifierProviderImpl<TodayCompletedTasksInCategory,
        List<Task>> {
  /// See also [TodayCompletedTasksInCategory].
  TodayCompletedTasksInCategoryProvider(
    int categoryId,
  ) : this._internal(
          () => TodayCompletedTasksInCategory()..categoryId = categoryId,
          from: todayCompletedTasksInCategoryProvider,
          name: r'todayCompletedTasksInCategoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$todayCompletedTasksInCategoryHash,
          dependencies: TodayCompletedTasksInCategoryFamily._dependencies,
          allTransitiveDependencies:
              TodayCompletedTasksInCategoryFamily._allTransitiveDependencies,
          categoryId: categoryId,
        );

  TodayCompletedTasksInCategoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.categoryId,
  }) : super.internal();

  final int categoryId;

  @override
  List<Task> runNotifierBuild(
    covariant TodayCompletedTasksInCategory notifier,
  ) {
    return notifier.build(
      categoryId,
    );
  }

  @override
  Override overrideWith(TodayCompletedTasksInCategory Function() create) {
    return ProviderOverride(
      origin: this,
      override: TodayCompletedTasksInCategoryProvider._internal(
        () => create()..categoryId = categoryId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        categoryId: categoryId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<TodayCompletedTasksInCategory, List<Task>>
      createElement() {
    return _TodayCompletedTasksInCategoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TodayCompletedTasksInCategoryProvider &&
        other.categoryId == categoryId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, categoryId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TodayCompletedTasksInCategoryRef
    on AutoDisposeNotifierProviderRef<List<Task>> {
  /// The parameter `categoryId` of this provider.
  int get categoryId;
}

class _TodayCompletedTasksInCategoryProviderElement
    extends AutoDisposeNotifierProviderElement<TodayCompletedTasksInCategory,
        List<Task>> with TodayCompletedTasksInCategoryRef {
  _TodayCompletedTasksInCategoryProviderElement(super.provider);

  @override
  int get categoryId =>
      (origin as TodayCompletedTasksInCategoryProvider).categoryId;
}

String _$yesterdayCompletedTasksInCategoryHash() =>
    r'7d280bd054d3afb9bb0736a4abdbba186b396974';

abstract class _$YesterdayCompletedTasksInCategory
    extends BuildlessAutoDisposeNotifier<List<Task>> {
  late final int categoryId;

  List<Task> build(
    int categoryId,
  );
}

/// See also [YesterdayCompletedTasksInCategory].
@ProviderFor(YesterdayCompletedTasksInCategory)
const yesterdayCompletedTasksInCategoryProvider =
    YesterdayCompletedTasksInCategoryFamily();

/// See also [YesterdayCompletedTasksInCategory].
class YesterdayCompletedTasksInCategoryFamily extends Family<List<Task>> {
  /// See also [YesterdayCompletedTasksInCategory].
  const YesterdayCompletedTasksInCategoryFamily();

  /// See also [YesterdayCompletedTasksInCategory].
  YesterdayCompletedTasksInCategoryProvider call(
    int categoryId,
  ) {
    return YesterdayCompletedTasksInCategoryProvider(
      categoryId,
    );
  }

  @override
  YesterdayCompletedTasksInCategoryProvider getProviderOverride(
    covariant YesterdayCompletedTasksInCategoryProvider provider,
  ) {
    return call(
      provider.categoryId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'yesterdayCompletedTasksInCategoryProvider';
}

/// See also [YesterdayCompletedTasksInCategory].
class YesterdayCompletedTasksInCategoryProvider
    extends AutoDisposeNotifierProviderImpl<YesterdayCompletedTasksInCategory,
        List<Task>> {
  /// See also [YesterdayCompletedTasksInCategory].
  YesterdayCompletedTasksInCategoryProvider(
    int categoryId,
  ) : this._internal(
          () => YesterdayCompletedTasksInCategory()..categoryId = categoryId,
          from: yesterdayCompletedTasksInCategoryProvider,
          name: r'yesterdayCompletedTasksInCategoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$yesterdayCompletedTasksInCategoryHash,
          dependencies: YesterdayCompletedTasksInCategoryFamily._dependencies,
          allTransitiveDependencies: YesterdayCompletedTasksInCategoryFamily
              ._allTransitiveDependencies,
          categoryId: categoryId,
        );

  YesterdayCompletedTasksInCategoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.categoryId,
  }) : super.internal();

  final int categoryId;

  @override
  List<Task> runNotifierBuild(
    covariant YesterdayCompletedTasksInCategory notifier,
  ) {
    return notifier.build(
      categoryId,
    );
  }

  @override
  Override overrideWith(YesterdayCompletedTasksInCategory Function() create) {
    return ProviderOverride(
      origin: this,
      override: YesterdayCompletedTasksInCategoryProvider._internal(
        () => create()..categoryId = categoryId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        categoryId: categoryId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<YesterdayCompletedTasksInCategory,
      List<Task>> createElement() {
    return _YesterdayCompletedTasksInCategoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is YesterdayCompletedTasksInCategoryProvider &&
        other.categoryId == categoryId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, categoryId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin YesterdayCompletedTasksInCategoryRef
    on AutoDisposeNotifierProviderRef<List<Task>> {
  /// The parameter `categoryId` of this provider.
  int get categoryId;
}

class _YesterdayCompletedTasksInCategoryProviderElement
    extends AutoDisposeNotifierProviderElement<
        YesterdayCompletedTasksInCategory,
        List<Task>> with YesterdayCompletedTasksInCategoryRef {
  _YesterdayCompletedTasksInCategoryProviderElement(super.provider);

  @override
  int get categoryId =>
      (origin as YesterdayCompletedTasksInCategoryProvider).categoryId;
}

String _$pastCompletedTasksInCategoryHash() =>
    r'c218feab95a7771fe409c35ab684a2d5aef23d6d';

abstract class _$PastCompletedTasksInCategory
    extends BuildlessAutoDisposeNotifier<List<Task>> {
  late final int categoryId;

  List<Task> build(
    int categoryId,
  );
}

/// See also [PastCompletedTasksInCategory].
@ProviderFor(PastCompletedTasksInCategory)
const pastCompletedTasksInCategoryProvider =
    PastCompletedTasksInCategoryFamily();

/// See also [PastCompletedTasksInCategory].
class PastCompletedTasksInCategoryFamily extends Family<List<Task>> {
  /// See also [PastCompletedTasksInCategory].
  const PastCompletedTasksInCategoryFamily();

  /// See also [PastCompletedTasksInCategory].
  PastCompletedTasksInCategoryProvider call(
    int categoryId,
  ) {
    return PastCompletedTasksInCategoryProvider(
      categoryId,
    );
  }

  @override
  PastCompletedTasksInCategoryProvider getProviderOverride(
    covariant PastCompletedTasksInCategoryProvider provider,
  ) {
    return call(
      provider.categoryId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'pastCompletedTasksInCategoryProvider';
}

/// See also [PastCompletedTasksInCategory].
class PastCompletedTasksInCategoryProvider
    extends AutoDisposeNotifierProviderImpl<PastCompletedTasksInCategory,
        List<Task>> {
  /// See also [PastCompletedTasksInCategory].
  PastCompletedTasksInCategoryProvider(
    int categoryId,
  ) : this._internal(
          () => PastCompletedTasksInCategory()..categoryId = categoryId,
          from: pastCompletedTasksInCategoryProvider,
          name: r'pastCompletedTasksInCategoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$pastCompletedTasksInCategoryHash,
          dependencies: PastCompletedTasksInCategoryFamily._dependencies,
          allTransitiveDependencies:
              PastCompletedTasksInCategoryFamily._allTransitiveDependencies,
          categoryId: categoryId,
        );

  PastCompletedTasksInCategoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.categoryId,
  }) : super.internal();

  final int categoryId;

  @override
  List<Task> runNotifierBuild(
    covariant PastCompletedTasksInCategory notifier,
  ) {
    return notifier.build(
      categoryId,
    );
  }

  @override
  Override overrideWith(PastCompletedTasksInCategory Function() create) {
    return ProviderOverride(
      origin: this,
      override: PastCompletedTasksInCategoryProvider._internal(
        () => create()..categoryId = categoryId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        categoryId: categoryId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<PastCompletedTasksInCategory, List<Task>>
      createElement() {
    return _PastCompletedTasksInCategoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PastCompletedTasksInCategoryProvider &&
        other.categoryId == categoryId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, categoryId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PastCompletedTasksInCategoryRef
    on AutoDisposeNotifierProviderRef<List<Task>> {
  /// The parameter `categoryId` of this provider.
  int get categoryId;
}

class _PastCompletedTasksInCategoryProviderElement
    extends AutoDisposeNotifierProviderElement<PastCompletedTasksInCategory,
        List<Task>> with PastCompletedTasksInCategoryRef {
  _PastCompletedTasksInCategoryProviderElement(super.provider);

  @override
  int get categoryId =>
      (origin as PastCompletedTasksInCategoryProvider).categoryId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
