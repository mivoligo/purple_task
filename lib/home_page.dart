import 'package:flutter/material.dart';

import 'categories/ui/category_list.dart';
import 'globals/globals.dart';
import 'ui/ui.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1000) {
          return Row(
            children: [
              SizedBox(
                width: 500,
                child: CategoryView(),
              ),
              Expanded(
                child: Container(
                  color: Colors.blueGrey,
                ),
              ),
            ],
          );
        } else {
          return Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.green,
                ),
              ),
              SizedBox(
                height: 260,
                child: CategoryView(),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: AddCategoryButton(text: addCategory, onPressed: () {}),
              ),
            ],
          );
        }
      },
    );
  }
}
