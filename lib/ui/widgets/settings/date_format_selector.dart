import 'package:flutter/material.dart';

class DateFormatSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      child: Text('current format'),
      itemBuilder: (context) {
        var list = List<PopupMenuEntry<Object>>();
        list.add(PopupMenuItem(
          child: Text('14 Aug '),
          value: 1,
        ));
        list.add(
          PopupMenuItem(
            child: Text('35 aosu 89'),
            value: 2,
          ),
        );
        return list;
      },
    );
  }
}
