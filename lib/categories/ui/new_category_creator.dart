import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purple_task/categories/ui/new_category_icon.dart';

import '../bloc/new_category_cubit.dart';
import '../data/category_repository.dart';
import 'new_category_color.dart';
import 'new_category_name.dart';

class NewCategoryCreator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewCategoryCubit(
        CategoryRepository(),
      )..startNewCategoryCreator(),
      child: NewCategoryCreatorView(),
    );
  }
}

class NewCategoryCreatorView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewCategoryCubit, NewCategoryState>(
      builder: (context, state) {
        final nameController = TextEditingController();
        if (state is NewCategoryInitial) {
          return CircularProgressIndicator();
        }
        if (state is NewCategoryName) {
          return CategoryName(
            textEditingController: nameController,
            color: state.color,
            onSubmitted: () =>
                context.read<NewCategoryCubit>().setName(nameController.text),
            onNext: () =>
                context.read<NewCategoryCubit>().setName(nameController.text),
            onCancel: () {
              context.read<NewCategoryCubit>().cancelNewCategoryCreator();
              Navigator.of(context).pop();
            },
          );
          // return Container();
        }
        if (state is NewCategoryColor) {
          return CategoryColor(
            name: state.name,
            color: state.color,
            selectedColor: state.color,
            onNext: () =>
                context.read<NewCategoryCubit>().setColor(state.color),
            onCancel: () {
              context.read<NewCategoryCubit>().cancelNewCategoryCreator();
              Navigator.of(context).pop();
            },
          );
        }
        if (state is NewCategoryIcon) {
          return CategoryIcon(
            name: state.name,
            color: state.color,
            onNext: () => context.read<NewCategoryCubit>().setIcon(state.icon),
            onCancel: () {
              context.read<NewCategoryCubit>().cancelNewCategoryCreator();
              Navigator.of(context).pop();
            },
            selectedIcon: state.icon,
          );
        }
        if (state is NewCategoryTasks) {
          return Container();
        }
        return const SizedBox();
      },
    );
  }
}
