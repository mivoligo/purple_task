import 'package:flutter/material.dart';

class CustomStyle {
  static const standardBackground = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFF303030),
        Color(0xFF673AB7),
      ],
    ),
  );

  static const inputDecoration = BoxDecoration(
    // color: Color(0xFFFAFAFA),
    borderRadius: BorderRadius.all(Radius.circular(8)),
    border: Border.fromBorderSide(BorderSide(color: Colors.grey, width: 0.5)),
    // boxShadow: [
    //   BoxShadow(color: Color(0xFFE0E0E0), offset: Offset(0, -1)),
    //   BoxShadow(color: Colors.white, offset: Offset(0, 1)),
    // ],
  );

  static const dialogDecoration = BoxDecoration(
    // color: Color(0xFFEEEEEE),
    borderRadius: BorderRadius.all(Radius.circular(12)),
    boxShadow: [
      BoxShadow(
        color: Color(0x45000000),
        offset: Offset(0, 4),
        blurRadius: 8,
      ),
    ],
  );

  static const uncategorizedTasksDecoration = BoxDecoration(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(12),
      topRight: Radius.circular(12),
      bottomLeft: Radius.circular(12),
      bottomRight: Radius.circular(12),
    ),
  );

  static const textStyleTitle = TextStyle(
    color: Color(0xFF616161),
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );

  static const textStyle24 = TextStyle(
    color: Colors.black,
    fontSize: 24,
    fontWeight: FontWeight.w400,
  );

  static const textStyle20 = TextStyle(
    color: Colors.black,
    fontSize: 20,
  );

  static const textStyleTaskName = TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static const textStyleTaskFilter = TextStyle(
    fontSize: 16,
  );

  static const textStyleWarning = TextStyle(
    color: Colors.red,
    fontSize: 16,
  );

  static const textStyleLabelSmall = TextStyle(
    color: Color(0xFF333333),
    fontSize: 12,
  );
}
