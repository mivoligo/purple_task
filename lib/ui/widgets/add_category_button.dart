import 'dart:math' as math;

import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';

class AddCategoryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const AddCategoryButton({
    Key key,
    @required this.text,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(60.0),
      ),
      child: Container(
        height: 40,
        constraints: BoxConstraints(
          // Make sure the button is not too wide
          maxWidth: math.min(300, MediaQuery.of(context).size.width - 80),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(AntIcons.folder_add),
              const SizedBox(width: 8.0),
              Flexible(
                // Flexible needed for TextOverflow to work
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.subtitle1,
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
