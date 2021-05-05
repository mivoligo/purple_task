import 'package:flutter/material.dart';
import '../../../../globals/strings/strings.dart' as s;

import '../../screens.dart';
import 'widgets.dart';

class WideLayout extends StatelessWidget {
  const WideLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 500,
          child: Column(
            children: [
              Expanded(child: CategoryList()),
              Hero(
                tag: 'new_category',
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: AddCategoryButton(
                    text: s.addCategory,
                    onPressed: () => Navigator.of(context).push(
                      _createRoute(NewCategoryScreen()),
                      // _openNewCategoryCreator(context);
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
              // color: Colors.blueGrey,
              ),
        ),
      ],
    );
  }

  Route _createRoute(Widget target) {
    return PageRouteBuilder(
      pageBuilder: (context, anim1, anim2) => target,
      transitionsBuilder: (context, anim1, anim2, child) {
        return FadeTransition(
          opacity: anim1,
          child: child,
        );
      },
    );
  }
}
