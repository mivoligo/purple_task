import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers.dart';
import 'category_card_state.dart';

class CategoryCardController extends StateNotifier<CategoryState> {
  CategoryCardController({
    required int categoryId,
    required TasksController tasksController,
  })  : _tasksController = tasksController,
        super(CategoryState.initial()) {
    _load(categoryId);
  }

  // final CategoriesController _categoriesController;
  // final int _categoryId;
  final TasksController _tasksController;

  void _load(int categoryId) {
    final allTasks = _tasksController.state.tasks
        .where((element) => element.categoryId == categoryId);
    final activeTasks = allTasks.where((element) => !element.isDone);
    final completedTasks = allTasks.where((element) => element.isDone);
    state = state.copyWith(
      allTasksNumber: allTasks.length,
      activeTasksNumber: activeTasks.length,
      completedTasksNumber: completedTasks.length,
    );
  }
}
