import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import '../../../widgets/simple_button.dart';

class AddCategoryButton extends StatelessWidget {
  const AddCategoryButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'new_category',
      child: SimpleButton(
        text: text,
        onPressed: onPressed,
        icon: const Icon(AntIcons.folderAdd),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
      ),
    );
  }
}
