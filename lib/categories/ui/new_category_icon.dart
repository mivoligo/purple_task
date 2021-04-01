import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../globals/globals.dart';
import '../../ui/widgets/simple_button.dart';
import 'icon_selector.dart';

class CategoryIcon extends StatelessWidget {
  CategoryIcon({
    Key? key,
    required this.name,
    required this.color,
    required this.onNext,
    required this.onCancel,
    required this.selectedIcon,
  }) : super(key: key);

  final String name;
  final int color;
  final VoidCallback onNext;
  final VoidCallback onCancel;
  final int selectedIcon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF303030),
                    Color(color),
                    Color(color),
                  ]),
            ),
          ),
          Center(
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        newCategory,
                        textAlign: TextAlign.center,
                        style: CustomStyles().textStyleTitle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 15.0, 32.0, 4.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 2),
                            child: Icon(
                              IconData(
                                selectedIcon,
                                fontFamily: 'AntIcons',
                                fontPackage: 'ant_icons',
                              ),
                              color: Color(color),
                              size: 38,
                            ),
                          ),
                          Text(
                            name,
                            style: CustomStyles().textStyleBigName,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: IconSelector(
                        selectedIcon: selectedIcon,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        'Icon', // TODO use const string
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SimpleButton(
                            text: cancel,
                            onPressed: onCancel,
                          ),
                          SimpleButton(
                            text: next,
                            color: Colors.green,
                            onPressed: onNext,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
