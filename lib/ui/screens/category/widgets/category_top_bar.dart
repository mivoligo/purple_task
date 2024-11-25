import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import '../../../../constants/strings/strings.dart' as s;
import '../../../../models/models.dart';
import '../../../widgets/widgets.dart';

class CategoryTopBar extends StatelessWidget {
  const CategoryTopBar({
    Key? key,
    required this.onClose,
    required this.category,
  }) : super(key: key);

  final VoidCallback onClose;
  final Category category;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Go back button
        CustomIconButton(
          icon: const Icon(AntIcons.close),
          color: Colors.black,
          tooltip: s.close,
          onPressed: () {
            onClose();
            Navigator.of(context).pop();
          },
        ),
        // Menu button
        CategoryMenu(
          category: category,
          canDeleteCategory: false,
        ),
      ],
    );
  }
}
