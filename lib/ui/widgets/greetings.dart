import 'package:flutter/material.dart';

class Greetings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey,
        ),
        SizedBox(height: 32.0),
        Text(
          'Hello',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        SizedBox(height: 8.0),
        Text(
          'You have 8 task to do',
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
      ],
    );
  }
}
