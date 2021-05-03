import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../repositories/repositories.dart';
import '../controllers.dart';

class TasksController extends StateNotifier<TasksState> {
  TasksController({
    required BaseTaskRepository baseTaskRepository,
  })  : _taskRepository = baseTaskRepository,
        super(TasksState.initial()) {
    _loadTasks();
  }

  final BaseTaskRepository _taskRepository;

  void _loadTasks() {
    state = state.copyWith(status: TasksStateStatus.loading);
    final tasks = _taskRepository.getTasks();
    state = state.copyWith(tasks: tasks, status: TasksStateStatus.data);
  }
}
