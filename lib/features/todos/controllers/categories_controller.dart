import 'package:purple_task/features/todos/models/category.dart';
import 'package:purple_task/features/todos/repositories/providers/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'categories_controller.g.dart';

@riverpod
class CategoriesNotifier extends _$CategoriesNotifier {
  @override
  Future<List<Category>> build() async =>
      ref.watch(categoryRepositoryProvider).getCategories();

  Future<void> refreshCategories() async {
    final updatedCategories =
        await ref.read(categoryRepositoryProvider).getCategories();

    await update((currentState) => [...updatedCategories]);
  }

  Future<void> remove({required int categoryId}) async {
    await ref.read(categoryRepositoryProvider).remove(categoryId: categoryId);
    final updatedCategories =
        await ref.read(categoryRepositoryProvider).getCategories();
    await update((currentState) => [...updatedCategories]);
  }

  Future<void> updateCategory({required Category category}) async {
    await ref.read(categoryRepositoryProvider).update(category: category);
    final updatedCategories =
        await ref.read(categoryRepositoryProvider).getCategories();
    await update((currentState) => [...updatedCategories]);
  }

  Future<void> reorder(
    int oldIndex,
    int newIndex,
  ) async {
    final categories = state.valueOrNull;

    var newIndexLocal = newIndex;
    final categoriesToBeUpdated = <Category>[];

    if (categories != null) {
      if (newIndex > oldIndex) {
        newIndexLocal -= 1;

        final affectedCategories =
            categories.sublist(oldIndex, newIndexLocal + 1).toList();

        for (var i = 0; i < affectedCategories.length; i++) {
          final currentCategory = affectedCategories[i];

          if (i == 0) {
            categoriesToBeUpdated.add(
              currentCategory.copyWith(
                position: affectedCategories.last.position,
              ),
            );
          } else {
            categoriesToBeUpdated.add(
              currentCategory.copyWith(
                position: affectedCategories[i - 1].position,
              ),
            );
          }
        }
      } else {
        final affectedCategories =
            categories.sublist(newIndexLocal, oldIndex + 1).toList();

        for (var i = 0; i < affectedCategories.length; i++) {
          final currentCategory = affectedCategories[i];
          if (i == affectedCategories.length - 1) {
            categoriesToBeUpdated.add(
              currentCategory.copyWith(
                position: affectedCategories.first.position,
              ),
            );
          } else {
            categoriesToBeUpdated.add(
              currentCategory.copyWith(
                position: affectedCategories[i + 1].position,
              ),
            );
          }
        }
      }
    }

    await ref
        .read(categoryRepositoryProvider)
        .reorder(categories: categoriesToBeUpdated);
    final updatedCategories =
        await ref.read(categoryRepositoryProvider).getCategories();

    await update((currentState) => [...updatedCategories]);
  }
}
