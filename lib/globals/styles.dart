import 'package:flutter/material.dart';

class CustomStyles {
  final inputDecoration = BoxDecoration(
    color: Color(0xFFFAFAFA),
    borderRadius: BorderRadius.circular(20.0),
    boxShadow: const [
      BoxShadow(color: Color(0xFFE0E0E0), offset: Offset(0.0, -2.0)),
      BoxShadow(color: Colors.white, offset: Offset(0.0, 1.0)),
    ],
  );
}
