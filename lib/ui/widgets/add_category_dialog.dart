import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AddCategoryDialog extends StatelessWidget {
  final String title;
  final String nameLabel;
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
    this.nameLabel = 'Category name',
    @required this.colorLabel,
    @required this.iconLabel,
    this.color = Colors.blue,
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
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          // Category name
          Positioned(
            left: 32.0,
            top: 60.0,
            right: 32.0,
            child: SizedBox(
              height: 60,
              child: TextField(
                style: TextStyle(fontSize: 18.0),
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: nameLabel),
              ),
            ),
          ),
          // Category color
          Positioned(
            left: 32.0,
            top: 120.0,
            right: 32.0,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    colorLabel,
                    style: TextStyle(fontSize: 18.0),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  color: Colors.grey[300],
                  width: 40.0,
                  height: 40.0,
                  child: FlatButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () {},
                    child: Container(
                      width: 28,
                      height: 28,
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Category icon
          Positioned(
            left: 32.0,
            top: 168.0,
            right: 32.0,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    iconLabel,
                    style: TextStyle(fontSize: 18.0),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  color: Colors.grey[300],
                  child: FlatButton(
                    padding: EdgeInsets.all(0.0),
                    onPressed: () {},
                    child: Icon(
                      icon,
                      size: 28.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Buttons
          Positioned(
            left: 16.0,
            right: 16.0,
            bottom: 12.0,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                FlatButton(
                  color: Colors.grey[300],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      cancelLabel,
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  onPressed: onCancel,
                ),
                Spacer(),
                FlatButton(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      saveLabel,
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  color: Colors.green,
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
