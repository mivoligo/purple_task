import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import '../../../../constants/strings/strings.dart' as s;
import '../../../widgets/widgets.dart';

class TopBar extends StatelessWidget {
  const TopBar({
    Key? key,
    required this.categoryId,
    required this.onRemoveAllTasks,
    required this.onRemoveCompletedTasks,
    required this.onRemoveCategory,
    required this.onClose,
  }) : super(key: key);

  final int categoryId;
  final VoidCallback onRemoveAllTasks;
  final VoidCallback onRemoveCompletedTasks;
  final VoidCallback onRemoveCategory;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Go back button
        CustomIconButton(
          icon: const Icon(AntIcons.arrow_left),
          color: Colors.white,
          tooltip: s.close,
          onPressed: () {
            onClose();
            Navigator.of(context).pop();
          },
        ),
        // Menu button
        CategoryMenu(
          categoryId: categoryId,
          onRemoveAllTasks: onRemoveAllTasks,
          onRemoveCompletedTasks: onRemoveCompletedTasks,
          onRemoveCategory: onRemoveCategory,
        ),
      ],
    );
  }
}
