import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../ui/ui.dart';
import '../bloc/category_cubit.dart';

class CategoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is CategoryInitial) {
          return Container();
        }
        if (state is CategoryLoaded) {
          final category = state.category;
          return Column(
            children: [
              Row(),
              Icon(
                IconData(
                  category.icon,
                  fontFamily: 'AntIcons',
                  fontPackage: 'ant_icons',
                ),
                size: 38.0,
                color: Color(category.color),
              ),
              Text('data'),
              Text(category.name),
              AnimatedProgressBar(
                color: Color(category.color),
                value: 0.6,
              ),
              AddTaskField(addTask: () {}),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
