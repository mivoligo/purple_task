import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../models/models.dart';

import '../../providers/providers.dart';

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
//
// Future<void> update({required Category category}) async {
//   await ref.read(categoryRepositoryProvider).update(category: category);
//   state = ref.read(categoryRepositoryProvider).getCategories();
// }
//
// void reorder(int oldIndex, int newIndex) {
//   ref
//       .read(categoryRepositoryProvider)
//       .reorder(oldIndex: oldIndex, newIndex: newIndex);
//   state = ref.read(categoryRepositoryProvider).getCategories();
// }
}
