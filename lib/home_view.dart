import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'categories/bloc/category_cubit.dart';
import 'categories/data/category_repository.dart';
import 'categories/ui/category_list.dart';
import 'categories/ui/new_category/new_category_creator.dart';
import 'globals/globals.dart';
import 'ui/ui.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CategoryCubit(CategoryRepository())..loadCategories(),
      child: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 1000) {
          return Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.green,
                ),
              ),
              SizedBox(
                height: 260,
                child: CategoryView(),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: AddCategoryButton(
                  text: addCategory,
                  onPressed: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => NewCategoryCreator(),
                      ),
                    );
                    context.read<CategoryCubit>().loadCategories();
                  },
                ),
              ),
            ],
          );
        } else {
          return Row(
            children: [
              SizedBox(
                width: 500,
                child: CategoryView(),
              ),
              Expanded(
                child: Container(
                  color: Colors.blueGrey,
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
