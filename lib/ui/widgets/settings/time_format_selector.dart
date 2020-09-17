import 'package:flutter/material.dart';

class TimeFormatSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      child: Text('current format'),
      itemBuilder: (context) {
        var list = List<PopupMenuEntry<Object>>();
        list.add(PopupMenuItem(
          child: Text('12-hour'),
          value: 1,
        ));
        list.add(
          PopupMenuItem(
            child: Text('24-hour'),
            value: 2,
          ),
        );
        return list;
      },
    );
  }
}
