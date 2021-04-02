import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purple_task/categories/ui/category_element.dart';

import '../bloc/category_cubit.dart';
import '../data/category_repository.dart';
import 'new_category/new_category_creator.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories test'),
      ),
      body: Container(
        child: BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, state) {
            if (state is CategoryLoading) {
              return CircularProgressIndicator();
            }
            if (state is CategoryLoaded) {
              final categories = state.categories;
              return ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  // return ListTile(
                  //   title: Text(
                  //     '${category.name}',
                  //   ),
                  //   trailing: IconButton(
                  //     icon: Icon(Icons.remove),
                  //     onPressed: () =>
                  //         context.read<CategoryCubit>().removeCategory(index),
                  //   ),
                  // );
                  return CategoryElement(
                    category: category,
                  );
                },
              );
            }

            return const SizedBox();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => NewCategoryCreator(),
          ));
          context.read<CategoryCubit>().loadCategories();
        },
      ),
    );
  }
}
