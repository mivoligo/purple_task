import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/task.dart';
import 'task_tile_state.dart';

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
