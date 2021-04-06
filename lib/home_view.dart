import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'categories/bloc/category_list_cubit.dart';
import 'categories/data/category_repository.dart';
import 'categories/ui/category_list.dart';
import 'categories/ui/new_category/new_category_creator.dart';
import 'globals/globals.dart';
import 'ui/ui.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CategoryListCubit(CategoryRepository())..loadCategories(),
      child: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF303030),
              Colors.purple,
              Colors.purple,
            ]),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 1000) {
            //
            // NARROW LAYOUT
            //
            return Column(
              children: [
                Expanded(
                  child: Container(
                      // color: Colors.green,
                      ),
                ),
                SizedBox(
                  height: 260,
                  child: CategoryList(),
                ),
                NewCategoryButton(),
              ],
            );
          } else {
            //
            // WIDE LAYOUT
            //
            return Row(
              children: [
                SizedBox(
                  width: 500,
                  child: Column(
                    children: [
                      Expanded(child: CategoryList()),
                      NewCategoryButton(),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                      // color: Colors.blueGrey,
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

class NewCategoryButton extends StatelessWidget {
  const NewCategoryButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'addCategoryHero',
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AddCategoryButton(
          text: addCategory,
          onPressed: () async {
            await Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (context, anim1, anim2) => NewCategoryCreator(),
              transitionsBuilder: (context, anim1, anim2, child) {
                return FadeTransition(
                  opacity: anim1,
                  child: child,
                );
              },
            ));
            context.read<CategoryListCubit>().loadCategories();
          },
        ),
      ),
    );
  }
}
