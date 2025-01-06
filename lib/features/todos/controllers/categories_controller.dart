import 'package:purple_task/features/todos/models/category.dart';
import 'package:purple_task/features/todos/repositories/drift_category_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'categories_controller.g.dart';

@riverpod
class CategoriesNotifier extends _$CategoriesNotifier {
  @override
  Future<List<Category>> build() async =>
      ref.watch(categoryRepositoryProvider).getCategories();

  Future<void> add({required Category category}) async {
    await ref.read(categoryRepositoryProvider).add(category: category);

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
//
// void reorder(int oldIndex, int newIndex) {
//   ref
//       .read(categoryRepositoryProvider)
//       .reorder(oldIndex: oldIndex, newIndex: newIndex);
//   state = ref.read(categoryRepositoryProvider).getCategories();
// }
}
