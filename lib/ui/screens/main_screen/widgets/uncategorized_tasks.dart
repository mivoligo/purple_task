import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../constants/strings/strings.dart' as s;

import '../../../../providers/providers.dart';
import '../../category/widgets/widgets.dart';

class UncategorizedTasks extends ConsumerStatefulWidget {
  UncategorizedTasks();

  @override
  ConsumerState<UncategorizedTasks> createState() => _UncategorizedTasksState();
}

class _UncategorizedTasksState extends ConsumerState<UncategorizedTasks> {
  int navigationIndex = 0;

  @override
  Widget build(BuildContext context) {
    final uncategorizedTasks = ref.watch(uncategorizedTasksProvider);

    return uncategorizedTasks.isNotEmpty
        ? Column(
            children: [
              Expanded(child: _buildTasksList()),
              NavigationBar(
                height: 64,
                backgroundColor: Colors.transparent,
                selectedIndex: navigationIndex,
                onDestinationSelected: (index) {
                  setState(() {
                    navigationIndex = index;
                  });
                },
                destinations: [
                  const NavigationDestination(
                    label: s.toDo,
                    icon: Icon(AntIcons.edit),
                  ),
                  const NavigationDestination(
                    label: s.all,
                    icon: Icon(AntIcons.profile),
                  ),
                  const NavigationDestination(
                    label: s.completed,
                    icon: Icon(AntIcons.checkCircle),
                  ),
                ],
              ),
            ],
          )
        : const SizedBox();
  }

  Widget _buildTasksList() {
    return switch (navigationIndex) {
      0 => const PlannedTasks(categoryId: -1),
      1 => const AllTasks(categoryId: -1),
      2 => const CompletedTasks(categoryId: -1),
      _ => const PlannedTasks(categoryId: -1),
    };
  }
}
