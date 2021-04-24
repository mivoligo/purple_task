import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        name,
        style: TextStyle(color: Colors.pink),
      ),
    );
  }
}
