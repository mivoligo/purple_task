import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../controllers/controllers.dart';
import '../../../globals/strings/strings.dart' as s;
import '../../../models/models.dart';
import '../../widgets/icon_button.dart';

import 'widgets/widgets.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({required this.category});

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, _) {
        final categoryColor = watch(categoryColorProvider(category.id));
        final currentCategory = watch(categoryProvider(category)).category;

        return Scaffold(
          body: LayoutBuilder(
            builder: (context, constrains) {
              if (constrains.maxWidth < 600) {
                return _CategoryCardWithControls(category: currentCategory);
              } else {
                return Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              const Color(0xFF303030),
                              categoryColor,
                              categoryColor,
                            ]),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: 600,
                        child: Card(
                          color: Colors.grey.shade200,
                          margin: const EdgeInsets.all(32),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          elevation: 6,
                          child: _CategoryCardWithControls(
                            category: currentCategory,
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
      },
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
                icon: const Icon(AntIcons.arrow_left),
                color: Colors.white,
                tooltip: s.close,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              // Menu button
              CategoryMenu(categoryId: category.id),
            ],
          ),
        ),
        Expanded(
          child: CategoryView(
            categoryId: category.id,
          ),
        ),
      ],
    );
  }
}
