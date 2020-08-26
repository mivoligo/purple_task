import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:to_do/globals/strings/strings.dart';

class CategoryMenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(AntIcons.menu),
      offset: Offset(0, 48),
      elevation: 4.0,
      onSelected: onItemSelected,
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

  void onItemSelected(item) {
    print('${item}');
  }
}
