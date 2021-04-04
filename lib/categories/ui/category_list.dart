import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/category_cubit.dart';
import '../data/category_repository.dart';
import 'category_element.dart';

class CategoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CategoryCubit(
        CategoryRepository(),
      )..loadCategories(),
      child: CategoryList(),
    );
  }
}

class CategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is CategoryLoaded) {
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
                return CategoryElement(category: category);
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
                );
              },
            );
          }
        }

        return const SizedBox();
      },
    );
    // floatingActionButton: FloatingActionButton(
    //   onPressed: () async {
    //     await Navigator.of(context).push(MaterialPageRoute(
    //       builder: (context) => NewCategoryCreator(),
    //     ));
    //     context.read<CategoryCubit>().loadCategories();
    //   },
    // ),
  }
}
