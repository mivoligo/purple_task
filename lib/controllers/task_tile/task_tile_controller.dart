import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/models.dart';
import '../controllers.dart';

final taskTileProvider = StateNotifierProvider.family
    .autoDispose<TaskTileController, TaskTileState, Task>(
  (ref, task) => TaskTileController(task: task),
);

class TaskTileController extends StateNotifier<TaskTileState> {
  TaskTileController({required this.task}) : super(TaskTileState.initial()) {
    _load(task: task);
  }

  final Task task;

  _load({required Task task}) {
    state = state.copyWith(task: task, status: TaskTileStateStatus.data);
  }

  void expandTile() {
    state = state.copyWith(status: TaskTileStateStatus.expanded);
  }

  void collapseTile() {
    state = state.copyWith(status: TaskTileStateStatus.data);
  }

  void showNameEditing() {
    state = state.copyWith(status: TaskTileStateStatus.editName);
  }
}
