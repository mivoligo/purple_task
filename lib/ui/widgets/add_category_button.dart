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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.create_new_folder),
            SizedBox(width: 8.0),
            Text(
              text,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
      onPressed: onPressed,
    );
  }
}
