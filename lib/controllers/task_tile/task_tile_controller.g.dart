// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_tile_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$taskTileNotifierHash() => r'c7cc80b6de85fe2ed7b767e6cb6ece001b6b90fb';

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

abstract class _$TaskTileNotifier
    extends BuildlessAutoDisposeNotifier<TaskTileState> {
  late final Task task;

  TaskTileState build(
    Task task,
  );
}

/// See also [TaskTileNotifier].
@ProviderFor(TaskTileNotifier)
const taskTileNotifierProvider = TaskTileNotifierFamily();

/// See also [TaskTileNotifier].
class TaskTileNotifierFamily extends Family<TaskTileState> {
  /// See also [TaskTileNotifier].
  const TaskTileNotifierFamily();

  /// See also [TaskTileNotifier].
  TaskTileNotifierProvider call(
    Task task,
  ) {
    return TaskTileNotifierProvider(
      task,
    );
  }

  @override
  TaskTileNotifierProvider getProviderOverride(
    covariant TaskTileNotifierProvider provider,
  ) {
    return call(
      provider.task,
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
  String? get name => r'taskTileNotifierProvider';
}

/// See also [TaskTileNotifier].
class TaskTileNotifierProvider
    extends AutoDisposeNotifierProviderImpl<TaskTileNotifier, TaskTileState> {
  /// See also [TaskTileNotifier].
  TaskTileNotifierProvider(
    Task task,
  ) : this._internal(
          () => TaskTileNotifier()..task = task,
          from: taskTileNotifierProvider,
          name: r'taskTileNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$taskTileNotifierHash,
          dependencies: TaskTileNotifierFamily._dependencies,
          allTransitiveDependencies:
              TaskTileNotifierFamily._allTransitiveDependencies,
          task: task,
        );

  TaskTileNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.task,
  }) : super.internal();

  final Task task;

  @override
  TaskTileState runNotifierBuild(
    covariant TaskTileNotifier notifier,
  ) {
    return notifier.build(
      task,
    );
  }

  @override
  Override overrideWith(TaskTileNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: TaskTileNotifierProvider._internal(
        () => create()..task = task,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        task: task,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<TaskTileNotifier, TaskTileState>
      createElement() {
    return _TaskTileNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TaskTileNotifierProvider && other.task == task;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, task.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TaskTileNotifierRef on AutoDisposeNotifierProviderRef<TaskTileState> {
  /// The parameter `task` of this provider.
  Task get task;
}

class _TaskTileNotifierProviderElement
    extends AutoDisposeNotifierProviderElement<TaskTileNotifier, TaskTileState>
    with TaskTileNotifierRef {
  _TaskTileNotifierProviderElement(super.provider);

  @override
  Task get task => (origin as TaskTileNotifierProvider).task;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
