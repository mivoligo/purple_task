import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../models/models.dart';

import '../../providers/providers.dart';

part 'categories_controller.g.dart';

@riverpod
class CategoriesNotifier extends _$CategoriesNotifier {
  @override
  List<Category> build() =>
      ref.watch(categoryRepositoryProvider).getCategories();

  Future<void> add({required Category category}) async {
    await ref.read(categoryRepositoryProvider).add(category: category);
    state = ref.read(categoryRepositoryProvider).getCategories();
  }

  Future<void> remove({required Category category}) async {
    await ref.read(categoryRepositoryProvider).remove(category: category);
    state = ref.read(categoryRepositoryProvider).getCategories();
  }

  Future<void> update({required Category category}) async {
    await ref.read(categoryRepositoryProvider).update(category: category);
    state = ref.read(categoryRepositoryProvider).getCategories();
  }

  void reorder(int oldIndex, int newIndex) {
    ref
        .read(categoryRepositoryProvider)
        .reorder(oldIndex: oldIndex, newIndex: newIndex);
    state = ref.read(categoryRepositoryProvider).getCategories();
  }
}
