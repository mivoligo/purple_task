import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());
}
