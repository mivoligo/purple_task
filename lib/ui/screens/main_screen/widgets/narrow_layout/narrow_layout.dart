import 'package:flutter/material.dart';
import '../../../../widgets/category_list.dart';

class NarrowLayout extends StatelessWidget {
  const NarrowLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text('Hello'),
        Expanded(
          child: CategoryList(),
        ),
      ],
    );
  }
}
