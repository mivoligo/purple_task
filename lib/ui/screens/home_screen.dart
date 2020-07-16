import 'package:flutter/material.dart';
import 'package:to_do/ui/widgets/category_card.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: CategoryCard(
          isEmpty: true,
          categoryName: 'Work',
        ),
      ),
    );
  }
}
