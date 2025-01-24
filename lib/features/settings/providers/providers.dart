import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purple_task/features/settings/controllers/settings_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@riverpod
bool isUncategorizedViewPreferred(Ref ref) {
  final settings = ref.watch(settingsNotifierProvider);

  return settings.value?.isUncategorizedViewPreferred ?? true;
}
