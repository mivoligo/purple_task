import 'package:flutter/material.dart';

class CustomStyle {
  static const standardBackground = BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF303030),
          Color(0xFF673AB7),
        ]),
  );

  static const categoryCardDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
    boxShadow: [
      BoxShadow(
        color: Color(0xff45000000),
        offset: Offset(0.0, 4.0),
        blurRadius: 8.0,
      ),
    ],
  );

  static const inputDecoration = BoxDecoration(
    color: Color(0xFFFAFAFA),
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
    boxShadow: [
      BoxShadow(color: Color(0xFFE0E0E0), offset: Offset(0.0, -2.0)),
      BoxShadow(color: Colors.white, offset: Offset(0.0, 1.0)),
    ],
  );

  static const dialogDecoration = BoxDecoration(
    color: Color(0xFFEEEEEE),
    borderRadius: BorderRadius.all(Radius.circular(24.0)),
    boxShadow: [
      BoxShadow(
        color: Color(0xff45000000),
        offset: Offset(0.0, 4.0),
        blurRadius: 8.0,
      ),
    ],
  );

  static const uncategorizedTasksDecoration = BoxDecoration(
    color: Colors.white70,
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(12),
      bottomRight: Radius.circular(12),
    ),
  );

  static const textStyleTitle = TextStyle(
    color: Color(0xFF616161),
    fontSize: 18.0,
    fontWeight: FontWeight.w400,
  );

  static const textStyle24 = TextStyle(
    color: Colors.black,
    fontSize: 24.0,
    fontWeight: FontWeight.w400,
  );

  static const textStyle20 = TextStyle(
    color: Colors.black,
    fontSize: 20,
  );

  static const textStyleTaskName = TextStyle(
    color: Colors.black,
    fontSize: 16.0,
  );

  static const textStyleTaskFilter = TextStyle(
    color: Colors.black,
    fontSize: 14.0,
  );

  static const textStyleWarning = TextStyle(
    color: Colors.red,
    fontSize: 16.0,
  );

  static const textStyleLabelSmall = TextStyle(
    color: Color(0xFF333333),
    fontSize: 12.0,
  );
}
