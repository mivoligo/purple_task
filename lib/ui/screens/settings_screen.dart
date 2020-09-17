import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  final Color backgroundColor;

  const SettingsScreen({
    Key key,
    @required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _appWidth = MediaQuery.of(context).size.width;
    bool _isWide = MediaQuery.of(context).size.width > 600;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Stack(
          alignment: Alignment.center,
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
            Positioned(
              width: _isWide ? 550 : _appWidth,
              top: _isWide ? 50 : 0,
              bottom: _isWide ? 50 : 0,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      const BoxShadow(
                        color: Color(0xff45000000),
                        offset: Offset(0.0, 4.0),
                        blurRadius: 8.0,
                      ),
                    ]),
                child: Text('Im here'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
