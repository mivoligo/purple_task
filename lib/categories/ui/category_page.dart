import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../globals/globals.dart';
import '../../ui/ui.dart';
import '../bloc/category_cubit.dart';
import '../data/models/category.dart';
import 'category_menu.dart';
import 'category_view.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({required this.category});

  final Category category;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<CategoryCubit>(context)
        ..loadCategory(category: category),
      child: CategoryDetail(category: category),
    );
  }
}

class CategoryDetail extends StatelessWidget {
  const CategoryDetail({Key? key, required this.category}) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        return Scaffold(
          body: LayoutBuilder(
            builder: (context, constrains) {
              if (constrains.maxWidth < 600) {
                return _CategoryCardWithControls(category: state.category!);
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
                              state.category!.color,
                              state.category!.color,
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
                            category: state.category!,
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
                icon: Icon(AntIcons.arrow_left),
                color: Colors.white,
                tooltip: close,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              // Menu button
              CategoryMenu(category: category),
            ],
          ),
        ),
        Expanded(
          child: CategoryView(
            category: category,
          ),
        ),
      ],
    );
  }
}
