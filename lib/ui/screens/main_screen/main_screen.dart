import 'package:flutter/material.dart';

import '../../../globals/strings/strings.dart' as s;
import '../../widgets/add_category_button.dart';
import '../../widgets/widgets.dart';
import 'widgets/widgets.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF303030),
              Colors.purple,
              Colors.purple,
            ]),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 1000) {
            return const NarrowLayout();
          } else {
            return const _WideLayout();
          }
        },
      ),
    );
  }
}

class _WideLayout extends StatelessWidget {
  const _WideLayout({
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
