import 'package:flutter/material.dart';
import '../../db_models/category.dart';
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
            return CategoryView(
              category: category,
            );
          } else {
            return Stack(
              children: [
                SizedBox.expand(
                  child: ColoredBox(
                    color: Color(category.color),
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: 600,
                    child: Card(
                      margin: const EdgeInsets.all(32),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 6,
                      child: CategoryView(
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
