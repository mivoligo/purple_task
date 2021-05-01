import 'package:flutter/material.dart';
import '../../../../globals/globals.dart';
import '../../../../globals/strings/strings.dart' as s;
import '../../../widgets/widgets.dart';
import 'new_category_base.dart';

class CategoryIcon extends StatelessWidget {
  CategoryIcon({
    Key? key,
    required this.name,
    required this.color,
    required this.onNext,
    required this.onCancel,
    required this.selectedIcon,
    required this.focusNode,
  }) : super(key: key);

  final String name;
  final Color color;
  final VoidCallback onNext;
  final VoidCallback onCancel;
  final int selectedIcon;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return NewCategoryBase(
      focusNode: focusNode,
      color: color,
      onNext: onNext,
      onCancel: onCancel,
      customWidget: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 15.0, 32.0, 4.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 2),
                    child: Icon(
                      IconData(
                        selectedIcon,
                        fontFamily: 'AntIcons',
                        fontPackage: 'ant_icons',
                      ),
                      color: color,
                      size: 38,
                    ),
                  ),
                  Text(
                    name,
                    style: CustomStyle.textStyleBigName,
                  ),
                ],
              ),
            ),
            Expanded(
              child: IconSelector(
                selectedIcon: selectedIcon,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(2.0),
              child: Text(
                s.icon,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
