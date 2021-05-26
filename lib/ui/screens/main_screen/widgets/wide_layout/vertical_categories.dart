import 'package:flutter/material.dart';
import '../../../../../models/models.dart';
import 'category_tile.dart';

class VerticalList extends StatelessWidget {
  const VerticalList({
    Key? key,
    required this.categories,
  }) : super(key: key);

  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return CategoryTile(category: category);
      },
    );
  }
}
