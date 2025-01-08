// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_dao.dart';

// ignore_for_file: type=lint
mixin _$TaskDaoMixin on DatabaseAccessor<AppDatabase> {
  $CategoriesTable get categories => attachedDatabase.categories;
  $TaskItemsTable get taskItems => attachedDatabase.taskItems;
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$taskDaoHash() => r'075a41019fff31337f6241f20daec78db672e6c2';

/// See also [taskDao].
@ProviderFor(taskDao)
final taskDaoProvider = AutoDisposeProvider<TaskDao>.internal(
  taskDao,
  name: r'taskDaoProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$taskDaoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TaskDaoRef = AutoDisposeProviderRef<TaskDao>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
