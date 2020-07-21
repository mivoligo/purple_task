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
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(60.0)),
        child: Container(
          height: 48,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.create_new_folder),
                SizedBox(width: 8.0),
                Text(
                  // TODO Make sure to handle long text
                  text,
                  style: TextStyle(fontSize: 18),
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
