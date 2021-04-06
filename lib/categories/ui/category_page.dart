import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';

import '../../db_models/category.dart';
import '../../globals/globals.dart';
import '../../ui/ui.dart';
import 'category_view.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key, required this.category}) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constrains) {
          if (constrains.maxWidth < 600) {
            return _CategoryCardWithControls(category: category);
          } else {
            return Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF303030),
                          Color(category.color),
                          Color(category.color),
                        ]),
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: 600,
                    child: Card(
                      margin: const EdgeInsets.all(32),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      elevation: 6,
                      child: _CategoryCardWithControls(
                        category: category,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class _CategoryCardWithControls extends StatelessWidget {
  const _CategoryCardWithControls({
    Key? key,
    required this.category,
  }) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 8.0,
            top: 8.0,
            right: 8.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Go back button
              CustomIconButton(
                icon: Icon(AntIcons.arrow_left),
                color: Colors.white,
                tooltip: close,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              // Menu button
              CategoryMenuWidget(
                categoryIndex: 2,
              ),
            ],
          ),
        ),
        CategoryView(
          category: category,
        ),
      ],
    );
  }
}
