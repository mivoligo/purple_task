import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/new_category_cubit.dart';
import '../../data/repositories/category_repository.dart';
import 'new_category_color.dart';
import 'new_category_icon.dart';
import 'new_category_initial.dart';
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
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewCategoryCubit, NewCategoryState>(
      builder: (context, state) {
        final nameController = TextEditingController();
        final newCategoryCubit = context.read<NewCategoryCubit>();
        if (state.status == NewCategoryStatus.initial) {
          return CategoryInitial(color: state.color);
        }
        if (state.status == NewCategoryStatus.name) {
          return CategoryName(
            focusNode: focusNode,
            textEditingController: nameController,
            color: state.color,
            onSubmitted: () {
              focusNode.unfocus();
              print('unfocused');
              FocusScope.of(context).requestFocus(focusNode);
              newCategoryCubit.setName(nameController.text);
            },
            onNext: () => newCategoryCubit.setName(nameController.text),
            onCancel: () {
              Navigator.of(context).pop();
            },
          );
        }
        if (state.status == NewCategoryStatus.color) {
          return CategoryColor(
            focusNode: focusNode,
            name: state.name,
            color: state.color,
            selectedColor: state.color,
            onNext: () => newCategoryCubit.setColor(state.color),
            onCancel: () {
              Navigator.of(context).pop();
            },
          );
        }
        if (state.status == NewCategoryStatus.icon) {
          return CategoryIcon(
            focusNode: focusNode,
            name: state.name,
            color: state.color,
            onNext: () => newCategoryCubit.setIcon(state.icon),
            onCancel: () {
              Navigator.of(context).pop();
            },
            selectedIcon: state.icon,
          );
        }
        if (state.status == NewCategoryStatus.tasks) {
          return CategoryTasks(
            focusNode: focusNode,
            name: state.name,
            color: state.color,
            onNext: () {
              newCategoryCubit.addNewCategory();
              Navigator.of(context).pop();
            },
            onCancel: () {
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
