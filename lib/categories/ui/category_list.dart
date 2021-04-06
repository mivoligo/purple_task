import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purple_task/categories/ui/category_page.dart';

import '../bloc/category_list_cubit.dart';
import 'category_element.dart';

class CategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryListCubit, CategoryListState>(
      builder: (context, state) {
        if (state is CategoryListLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is CategoryListLoaded) {
          final categories = state.categories;
          final appWindowWidth = MediaQuery.of(context).size.width;
          if (appWindowWidth < 600) {
            var _pageController = PageController(
              viewportFraction: (appWindowWidth - 48) / appWindowWidth,
              initialPage: 0,
            );
            return PageView.builder(
              controller: _pageController,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return CategoryElement(
                  category: category,
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return CategoryPage(
                          category: category,
                        );
                      },
                    ));
                  },
                );
              },
            );
          } else if (appWindowWidth < 1000) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return SizedBox(
                  width: 400,
                  child: CategoryElement(
                    category: category,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return CategoryPage(
                            category: category,
                          );
                        },
                      ));
                    },
                  ),
                );
              },
            );
          } else {
            return ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return CategoryElement(
                  category: category,
                  isInVerticalList: true,
                  onTap: () {},
                );
              },
            );
          }
        }

        return const SizedBox();
      },
    );
  }
}
