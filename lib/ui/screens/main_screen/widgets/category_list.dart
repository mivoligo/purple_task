import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../controllers/controllers.dart';

class CategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('====REBUILDING====');
    return Consumer(
      builder: (context, watch, child) {
        final state = watch(categoriesControllerProvider);
        final controller = watch(categoriesControllerProvider.notifier);
        if (state.status == CategoriesStateStatus.initial) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: state.categories.length,
          itemBuilder: (context, index) {
            final category = state.categories[index];
            return ListTile(
              title: Text(
                category.name,
              ),
            );
          },
        );
      },
    );
  }
}
