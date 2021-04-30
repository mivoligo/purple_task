import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories.dart';

final taskRepositoryProvider = Provider<BaseTaskRepository>((ref) {
  return TaskRepository();
});
