import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:to_do/globals/strings/strings.dart';
import 'package:to_do/ui/widgets/confirmation_dialog.dart';

class CategoryMenuWidget extends StatelessWidget {
  final VoidCallback onDeleteCompleted;
  final VoidCallback onDeleteAll;
  final VoidCallback onDeleteCategory;
  final VoidCallback onChangeName;
  final VoidCallback onChangeColor;
  final VoidCallback onChangeIcon;

  const CategoryMenuWidget({
    Key key,
    this.onDeleteCompleted,
    this.onDeleteAll,
    this.onDeleteCategory,
    this.onChangeName,
    this.onChangeColor,
    this.onChangeIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(AntIcons.menu),
      offset: Offset(0, 48),
      elevation: 4.0,
      onSelected: (item) => onItemSelected(context, item),
      itemBuilder: (context) {
        var list = List<PopupMenuEntry<Object>>();
        list.add(PopupMenuItem(
          child: Text(DELETE_COMPLETED),
          value: 1,
        ));
        list.add(PopupMenuItem(
          child: Text(DELETE_ALL_TASKS),
          value: 2,
        ));
        list.add(PopupMenuDivider());
        list.add(PopupMenuItem(
          child: Text(DELETE_CATEGORY),
          value: 3,
        ));
        list.add(PopupMenuDivider());
        list.add(PopupMenuItem(
          child: Text(CHANGE_NAME),
          value: 4,
        ));
        list.add(PopupMenuItem(
          child: Text(CHANGE_COLOR),
          value: 5,
        ));
        list.add(PopupMenuItem(
          child: Text(CHANGE_ICON),
          value: 6,
        ));

        return list;
      },
    );
  }

  void onItemSelected(context, item) {
    switch (item) {
      case 1:
        showDialog(
          context: context,
          builder: (context) => ConfirmationDialog(
            title: Q_DELETE_COMPLETED,
            content: Text(D_DELETE_COMPLETED),
            confirmationText: DELETE,
            confirmationColor: Colors.red,
            onConfirm: onDeleteCompleted,
          ),
        );
        break;
      case 2:
        showDialog(
          context: context,
          builder: (context) => ConfirmationDialog(
            title: Q_DELETE_ALL,
            content: Text(D_DELETE_ALL),
            confirmationText: DELETE,
            confirmationColor: Colors.red,
            onConfirm: onDeleteAll,
          ),
        );
        break;
      case 3:
        showDialog(
          context: context,
          builder: (context) => ConfirmationDialog(
            title: Q_DELETE_CATEGORY,
            content: Text(D_DELETE_CATEGORY),
            confirmationText: DELETE,
            confirmationColor: Colors.red,
            onConfirm: onDeleteCategory,
          ),
        );
        break;
      case 4:
        return onChangeName();
        break;
      case 5:
        return onChangeColor();
        break;
      case 6:
        return onChangeIcon();
        break;
    }
  }
}
