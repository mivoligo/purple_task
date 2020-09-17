import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  final Color backgroundColor;

  const SettingsScreen({
    Key key,
    @required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.grey[850],
                      backgroundColor,
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
