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
    state = [...state, category];
  }

  Future<void> remove({required Category category}) async {
    await ref.read(categoryRepositoryProvider).remove(category: category);
    state = state.where((element) => element.id != category.id).toList();
  }

  Future<void> update({required Category category}) async {
    await ref.read(categoryRepositoryProvider).update(category: category);
    state = [
      for (final element in state)
        if (element.id == category.id) category else element,
    ];
  }
}
