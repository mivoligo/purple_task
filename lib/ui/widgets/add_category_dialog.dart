import 'package:flutter/material.dart';

class AddCategoryDialog extends StatelessWidget {
  final String title;
  final String colorLabel;
  final String iconLabel;
  final Color color;
  final IconData icon;
  final String cancelLabel;
  final String saveLabel;
  final VoidCallback onCancel;
  final VoidCallback onSave;

  const AddCategoryDialog({
    Key key,
    @required this.title,
    @required this.colorLabel,
    @required this.iconLabel,
    this.color = Colors.lightGreen,
    this.icon = Icons.folder,
    this.cancelLabel,
    this.saveLabel,
    this.onCancel,
    this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Title
          Positioned(
            top: 16.0,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          // Category name
          Positioned(
            top: 56.0,
            child: TextField(),
          ),
          // Category color
          Positioned(
            top: 72.0,
            child: Row(
              children: [
                Text(colorLabel),
                Container(
                  width: 64,
                  height: 64,
                  color: color,
                ),
              ],
            ),
          ),
          // Category icon
          Positioned(
            top: 100,
            child: Row(
              children: [
                Text(iconLabel),
                Icon(icon),
              ],
            ),
          ),
          // Buttons
          Positioned(
            bottom: 16,
            child: Row(
              children: [
                FlatButton(
                  child: Text(cancelLabel),
                  onPressed: onCancel,
                ),
                FlatButton(
                  child: Text(saveLabel),
                  onPressed: onSave,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
