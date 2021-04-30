import 'package:flutter/material.dart';

class CustomStyle {
  static const inputDecoration = BoxDecoration(
    color: Color(0xFFFAFAFA),
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
    boxShadow: [
      BoxShadow(color: Color(0xFFE0E0E0), offset: Offset(0.0, -2.0)),
      BoxShadow(color: Colors.white, offset: Offset(0.0, 1.0)),
    ],
  );

  static const textStyleTitle = TextStyle(
    color: Color(0xFF616161),
    fontSize: 18.0,
    fontWeight: FontWeight.w400,
  );

  static const textStyleBigName = TextStyle(
    color: Colors.black,
    fontSize: 24.0,
    fontWeight: FontWeight.w400,
  );

  static const textStyleTaskName = TextStyle(
    color: Colors.black,
    fontSize: 16.0,
  );
}
