import 'dart:math';

import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';

class AddCategoryButton extends StatelessWidget {
  final String text;
  final double opacity;
  final VoidCallback onPressed;

  const AddCategoryButton({
    Key key,
    @required this.text,
    @required this.opacity,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: FlatButton(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60.0),
        ),
        child: Container(
          height: 48,
          constraints: BoxConstraints(
            // Make sure the button is not too wide
            maxWidth: min(300, MediaQuery.of(context).size.width - 80),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(AntIcons.folder_add),
                SizedBox(width: 8.0),
                Flexible(
                  // Flexible needed for TextOverflow to work
                  child: Text(
                    text,
                    style: TextStyle(fontSize: 18),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
        onPressed: opacity < 1 ? null : onPressed,
      ),
    );
  }
}
