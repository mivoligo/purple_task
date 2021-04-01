import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/new_category_cubit.dart';
import '../data/category_repository.dart';
import 'new_category_color.dart';
import 'new_category_icon.dart';
import 'new_category_name.dart';
import 'new_category_tasks.dart';

class NewCategoryCreator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          NewCategoryCubit(CategoryRepository())..startNewCategoryCreator(),
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
        final newCategoryCubit = context.read<NewCategoryCubit>();
        if (state is NewCategoryInitial) {
          return CircularProgressIndicator();
        }
        if (state is NewCategoryName) {
          return CategoryName(
            textEditingController: nameController,
            color: state.color,
            onSubmitted: () => newCategoryCubit.setName(nameController.text),
            onNext: () => newCategoryCubit.setName(nameController.text),
            onCancel: () {
              newCategoryCubit.cancelNewCategoryCreator();
              Navigator.of(context).pop();
            },
          );
        }
        if (state is NewCategoryColor) {
          return CategoryColor(
            name: state.name,
            color: state.color,
            selectedColor: state.color,
            onNext: () => newCategoryCubit.setColor(state.color),
            onCancel: () {
              newCategoryCubit.cancelNewCategoryCreator();
              Navigator.of(context).pop();
            },
          );
        }
        if (state is NewCategoryIcon) {
          return CategoryIcon(
            name: state.name,
            color: state.color,
            onNext: () => newCategoryCubit.setIcon(state.icon),
            onCancel: () {
              newCategoryCubit.cancelNewCategoryCreator();
              Navigator.of(context).pop();
            },
            selectedIcon: state.icon,
          );
        }
        if (state is NewCategoryTasks) {
          return CategoryTasks(
            name: state.name,
            color: state.color,
            onNext: () {
              newCategoryCubit.addNewCategory();
              Navigator.of(context).pop();
            },
            onCancel: () {
              newCategoryCubit.cancelNewCategoryCreator();
              Navigator.of(context).pop();
            },
            selectedIcon: state.icon,
          );
        }
        return const SizedBox();
      },
    );
  }
}
