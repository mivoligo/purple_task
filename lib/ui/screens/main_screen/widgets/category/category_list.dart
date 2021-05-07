import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../controllers/controllers.dart';
import '../../../screens.dart';
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
            return _HorizontalPages(state: state);
          } else if (_appWidth < 1000) {
            return _HorizontalList(state: state);
          } else {
            return _VerticalList(state: state);
          }
        }
        return const SizedBox();
      },
    );
  }
}

class _HorizontalPages extends StatelessWidget {
  const _HorizontalPages({
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
        return CategoryCard(
            category: category,
            onTap: () {
              Navigator.of(context).push(PageRouteBuilder(
                pageBuilder: (context, anim1, anim2) =>
                    CategoryScreen(category: category),
                transitionsBuilder: (context, anim1, anim2, child) {
                  return FadeTransition(
                    opacity: anim1,
                    child: child,
                  );
                },
              ));
            });
      },
    );
  }
}

class _HorizontalList extends StatelessWidget {
  const _HorizontalList({
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
          width: 400,
          child: CategoryCard(
            category: category,
            onTap: () {
              Navigator.of(context).push(PageRouteBuilder(
                pageBuilder: (context, anim1, anim2) =>
                    CategoryScreen(category: category),
                transitionsBuilder: (context, anim1, anim2, child) {
                  return FadeTransition(
                    opacity: anim1,
                    child: child,
                  );
                },
              ));
            },
          ),
        );
      },
    );
  }
}

class _VerticalList extends StatelessWidget {
  const _VerticalList({
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
        return CategoryCardTemp(
          category: category,
          isInVerticalList: true,
          onTap: () {},
        );
      },
    );
  }
}
