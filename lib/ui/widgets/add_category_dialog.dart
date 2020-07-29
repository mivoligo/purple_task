import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:to_do/ui/view_models/category_model.dart';
import 'package:to_do/ui/widgets/colors_list.dart';
import 'package:to_do/ui/widgets/icons_list.dart';

class AddCategoryDialog extends StatefulWidget {
  final String title;
  final String nameLabel;
  final String colorLabel;
  final String iconLabel;
  final Color color;
  final IconData icon;
  final String cancelLabel;
  final String saveLabel;
  final VoidCallback onSave;

  const AddCategoryDialog({
    Key key,
    @required this.title,
    this.nameLabel = 'Name',
    @required this.colorLabel,
    @required this.iconLabel,
    this.color = Colors.blue,
    this.icon = Icons.folder,
    this.cancelLabel,
    this.saveLabel,
    this.onSave,
  }) : super(key: key);

  @override
  _AddCategoryDialogState createState() => _AddCategoryDialogState();
}

class _AddCategoryDialogState extends State<AddCategoryDialog> {
  bool _visibleColorsList = false;
  bool _visibleIconList = false;
  bool _validName = false;
  var newCategoryProvider;

  @override
  void dispose() {
    newCategoryProvider.resetNewCategory();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    newCategoryProvider = Provider.of<NewCategory>(context, listen: false);

    final categoryListProvider =
        Provider.of<CategoryList>(context, listen: false);

    void saveCategory() {
      String name = newCategoryProvider.name;
      int color = newCategoryProvider.color;
      int icon = newCategoryProvider.icon;
      Category category = Category(
        name: name,
        color: Color(color),
        icon: IconData(
          icon,
          fontFamily: 'AntIcons',
          fontPackage: 'ant_icons',
        ),
      );
      categoryListProvider.addCategory(category);
    }

    return Dialog(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Title
          Positioned(
            top: 12.0,
            child: Text(
              widget.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
          ),
          // Category name
          Positioned(
            left: 32.0,
            top: 60.0,
            right: 32.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  widget.nameLabel,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    textBaseline: TextBaseline.alphabetic,
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: TextField(
                    autofocus: true,
                    onChanged: (text) {
                      setState(() {
                        _validName = text.isNotEmpty;
                        newCategoryProvider.name = text;
                      });
                    },
                    style: TextStyle(
                      fontSize: 18.0,
                      textBaseline: TextBaseline.alphabetic,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Category color
          Positioned(
            left: 32.0,
            top: 112.0,
            right: 32.0,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.colorLabel,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  color: Colors.grey[300],
                  width: 40.0,
                  height: 40.0,
                  child: FlatButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      setState(() {
                        _visibleIconList = false;
                        _visibleColorsList = !_visibleColorsList;
                      });
                    },
                    child: Consumer<NewCategory>(
                      builder: (_, value, __) => Container(
                        width: 28,
                        height: 28,
                        color: Color(value.color),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // List of colors
          Positioned(
            left: 0.0,
            top: 162.0,
            right: 0.0,
            child: Container(
              height: _visibleColorsList ? 40.0 : 0.0,
              child: ColorsList(),
            ),
          ),
          // Category icon
          AnimatedPositioned(
            duration: Duration(milliseconds: 100),
            left: 32.0,
            top: _visibleColorsList ? 230.0 : 162.0,
            right: 32.0,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.iconLabel,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  color: Colors.grey[300],
                  child: FlatButton(
                    padding: EdgeInsets.all(0.0),
                    onPressed: () {
                      setState(() {
                        _visibleColorsList = false;
                        _visibleIconList = !_visibleIconList;
                      });
                    },
                    child: Consumer<NewCategory>(
                      builder: (_, value, __) => Icon(
                        IconData(
                          value.icon,
                          fontFamily: 'AntIcons',
                          fontPackage: 'ant_icons',
                        ),
                        color: Colors.black54,
                        size: 28.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // List of icons
          Positioned(
            left: 0.0,
            top: 216.0,
            right: 0.0,
            child: Container(
              height: _visibleIconList ? 40.0 : 0.0,
              child: IconsList(),
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
                      widget.cancelLabel,
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                Spacer(),
                FlatButton(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.saveLabel,
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  color: Colors.green,
                  onPressed: _validName
                      ? () {
                          saveCategory();
                          Navigator.of(context).pop();
//                    widget.onSave();
                        }
                      : null,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
