// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$categoryRepositoryHash() =>
    r'4ea86972fe3575d4fa1597164c53747e2d274b49';

/// See also [categoryRepository].
@ProviderFor(categoryRepository)
final categoryRepositoryProvider =
    AutoDisposeProvider<BaseCategoryRepository>.internal(
  categoryRepository,
  name: r'categoryRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$categoryRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CategoryRepositoryRef = AutoDisposeProviderRef<BaseCategoryRepository>;
String _$taskRepositoryHash() => r'65514bfc7d75b95dfc9f18bd35b0718cb0ecd377';

/// See also [taskRepository].
@ProviderFor(taskRepository)
final taskRepositoryProvider = AutoDisposeProvider<BaseTaskRepository>.internal(
  taskRepository,
  name: r'taskRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$taskRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TaskRepositoryRef = AutoDisposeProviderRef<BaseTaskRepository>;
String _$numberOfAllActiveTasksHash() =>
    r'5b4c2ac1e0c98b2d5462f70b1bdafdf6708a0493';

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
    r'c13e88f75f007a3ae6a4a38d45f3157cd63dcf99';

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
    r'e431a7abd5fc478ecb3f7be57c85991f0339d62b';

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
    r'9b5a3dd52dd3e2d1bbf891940a7fef2b06d4ac5d';

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

String _$settingsRepositoryHash() =>
    r'b2e7ca2d76eb2b2d5ce9a22a84597b76b31b2744';

/// See also [settingsRepository].
@ProviderFor(settingsRepository)
final settingsRepositoryProvider =
    AutoDisposeProvider<BaseSettingsRepository>.internal(
  settingsRepository,
  name: r'settingsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$settingsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SettingsRepositoryRef = AutoDisposeProviderRef<BaseSettingsRepository>;
String _$backgroundColorNarrowLayoutHash() =>
    r'ae254f98f0d1f1da95f4b9a518830a53d5d2573c';

/// See also [backgroundColorNarrowLayout].
@ProviderFor(backgroundColorNarrowLayout)
final backgroundColorNarrowLayoutProvider = AutoDisposeProvider<Color>.internal(
  backgroundColorNarrowLayout,
  name: r'backgroundColorNarrowLayoutProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$backgroundColorNarrowLayoutHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BackgroundColorNarrowLayoutRef = AutoDisposeProviderRef<Color>;
String _$backgroundColorWideLayoutHash() =>
    r'9327da49fe85256cfc438539888bbd252657bcb9';

/// See also [backgroundColorWideLayout].
@ProviderFor(backgroundColorWideLayout)
final backgroundColorWideLayoutProvider = AutoDisposeProvider<Color>.internal(
  backgroundColorWideLayout,
  name: r'backgroundColorWideLayoutProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$backgroundColorWideLayoutHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BackgroundColorWideLayoutRef = AutoDisposeProviderRef<Color>;
String _$noDueDateTasksInCategoryHash() =>
    r'45e5f8629d543e6e308c40dc61eaf58f8c49721c';

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
    r'168c9d3232b7e533679dde656d94199704d008be';

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
    r'05df93852677086390e6e0cb2d8c821bfae19091';

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
    r'0f3b9ee1e8fac2317c4ad8a184a76d11eb6f789b';

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
    r'e2d07f369d5773dbd7ffd5d5411d02baf2fccc32';

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
    r'35c3ce76db1eb5b70ac5e09bff87530d48fc33ab';

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
    r'7265171415a3900b0ef35669c2fe6d3e51b4350d';

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
    r'df7acc503bf2cb756dd55eabc0ac999faba006e1';

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

String _$categoryCreatorCurrentStatusHash() =>
    r'd9eb744f03d9b43e036928d94280a4ea9cd11909';

/// See also [CategoryCreatorCurrentStatus].
@ProviderFor(CategoryCreatorCurrentStatus)
final categoryCreatorCurrentStatusProvider = AutoDisposeNotifierProvider<
    CategoryCreatorCurrentStatus, CategoryCreatorStatus>.internal(
  CategoryCreatorCurrentStatus.new,
  name: r'categoryCreatorCurrentStatusProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$categoryCreatorCurrentStatusHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CategoryCreatorCurrentStatus
    = AutoDisposeNotifier<CategoryCreatorStatus>;
String _$categoryScreenCurrentStatusHash() =>
    r'fbf778aa02a74a799a5658d3976df5f70c8cd1c8';

/// See also [CategoryScreenCurrentStatus].
@ProviderFor(CategoryScreenCurrentStatus)
final categoryScreenCurrentStatusProvider = AutoDisposeNotifierProvider<
    CategoryScreenCurrentStatus, CategoryScreenStatus>.internal(
  CategoryScreenCurrentStatus.new,
  name: r'categoryScreenCurrentStatusProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$categoryScreenCurrentStatusHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CategoryScreenCurrentStatus
    = AutoDisposeNotifier<CategoryScreenStatus>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
