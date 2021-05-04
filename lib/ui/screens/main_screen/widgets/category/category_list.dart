import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../controllers/controllers.dart';
import '../widgets.dart';

class CategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('====REBUILDING====');
    final _appWidth = MediaQuery.of(context).size.width;
    return Consumer(
      builder: (context, watch, child) {
        final state = watch(categoriesProvider);
        if (state.status == CategoriesStateStatus.initial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.status == CategoriesStateStatus.data) {
          if (_appWidth < 600) {
            return HorizontalPages(state: state);
          } else if (_appWidth < 1000) {
            return HorizontalList(state: state);
          } else {
            return VerticalList(state: state);
          }
        }
        return const SizedBox();
      },
    );
  }
}

class HorizontalPages extends StatelessWidget {
  const HorizontalPages({
    Key? key,
    required this.state,
  }) : super(key: key);

  final CategoriesState state;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: state.categories.length,
      itemBuilder: (context, index) {
        final category = state.categories[index];
        return CategoryCard(category: category, onTap: () {});
      },
    );
  }
}

class HorizontalList extends StatelessWidget {
  const HorizontalList({
    Key? key,
    required this.state,
  }) : super(key: key);

  final CategoriesState state;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: state.categories.length,
      itemBuilder: (context, index) {
        final category = state.categories[index];
        return SizedBox(
            width: 400, child: CategoryCard(category: category, onTap: () {}));
      },
    );
  }
}

class VerticalList extends StatelessWidget {
  const VerticalList({
    Key? key,
    required this.state,
  }) : super(key: key);

  final CategoriesState state;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: state.categories.length,
      itemBuilder: (context, index) {
        final category = state.categories[index];
        return CategoryCard(
          category: category,
          isInVerticalList: true,
          onTap: () {},
        );
      },
    );
  }
}
