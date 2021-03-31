import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../globals/globals.dart';
import '../../ui/widgets/simple_button.dart';
import 'color_selector.dart';

class CategoryColor extends StatelessWidget {
  CategoryColor({
    Key? key,
    required this.color,
    required this.onNext,
    required this.onCancel,
    required this.selectedColor,
  }) : super(key: key);

  final int color;
  final VoidCallback onNext;
  final VoidCallback onCancel;
  final int selectedColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(color),
      body: Center(
        child: SizedBox(
          width: 600,
          height: 500,
          child: Card(
            margin: const EdgeInsets.all(32),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 6,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const SizedBox(height: 4.0),
                      Text(
                        'color', // TODO use global
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      Spacer(),
                      const SizedBox(height: 8.0),
                      Expanded(
                        child: ColorSelector(
                          selectedColor: selectedColor,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Row(
                        children: [
                          const SizedBox(width: 16.0),
                          SimpleButton(
                            text: cancel,
                            onPressed: onCancel,
                          ),
                          Spacer(),
                          SimpleButton(
                            text: next,
                            color: Colors.green,
                            onPressed: onNext,
                          ),
                          const SizedBox(width: 16.0),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
