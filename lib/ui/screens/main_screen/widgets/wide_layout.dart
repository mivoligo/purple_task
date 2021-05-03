import 'package:flutter/material.dart';
import '../../../../globals/strings/strings.dart' as s;

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
                    onPressed: () {
                      // _openNewCategoryCreator(context);
                    },
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
}
