import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../providers/providers.dart';
import '../../category/widgets/widgets.dart';

class UncategorizedTasks extends ConsumerWidget {
  UncategorizedTasks();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uncategorizedTasks = ref.watch(uncategorizedTasksProvider);
    return uncategorizedTasks.isNotEmpty
        ? const AllTasks(
            categoryId: -1,
            shrinkWrap: false,
          )
        : const SizedBox();
  }
}
