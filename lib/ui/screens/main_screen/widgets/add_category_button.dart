import 'dart:math' as math;

import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';

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
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60.0),
        ),
      ),
      child: Container(
        height: 40,
        constraints: BoxConstraints(
          // Make sure the button is not too wide
          maxWidth: math.min(300, MediaQuery.of(context).size.width - 80),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                AntIcons.folder_add,
                color: Colors.black,
              ),
              const SizedBox(width: 8.0),
              Flexible(
                // Flexible needed for TextOverflow to work
                child: Text(
                  text,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
