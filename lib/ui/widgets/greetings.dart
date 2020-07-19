import 'package:flutter/material.dart';

class Greetings extends StatelessWidget {
  final String greetings;

  const Greetings({Key key, this.greetings}) : super(key: key);

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
          greetings,
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
