// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_dao.dart';

// ignore_for_file: type=lint
mixin _$CategoryDaoMixin on DatabaseAccessor<AppDatabase> {
  $CategoriesTable get categories => attachedDatabase.categories;
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$categoryDaoHash() => r'5be907cf93b4ddb70c1cb8d526bbdeb452b99427';

/// See also [categoryDao].
@ProviderFor(categoryDao)
final categoryDaoProvider = AutoDisposeProvider<CategoryDao>.internal(
  categoryDao,
  name: r'categoryDaoProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$categoryDaoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CategoryDaoRef = AutoDisposeProviderRef<CategoryDao>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
