import 'package:purple_task/features/todos/controllers/task_tile_state.dart';
import 'package:purple_task/features/todos/models/task.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'task_tile_controller.g.dart';

@riverpod
class TaskTileNotifier extends _$TaskTileNotifier {
  @override
  TaskTileState build(Task task) {
    return TaskTileState(task: task, status: TaskTileStateStatus.data);
  }

  void collapseTile() {
    state = state.copyWith(status: TaskTileStateStatus.data);
  }

  void showNameEditing() {
    state = state.copyWith(status: TaskTileStateStatus.editName);
  }
}
