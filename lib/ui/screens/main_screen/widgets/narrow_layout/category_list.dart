import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../controllers/controllers.dart';
import '../../../../../providers/providers.dart';
import '../../../screens.dart';
import 'category_card.dart';

class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  Widget build(BuildContext context) {
    final _appWidth = MediaQuery.of(context).size.width;

    return Consumer(
      builder: (context, watch, _) {
        final state = watch(categoriesProvider);
        if (state.status == CategoriesStateStatus.initial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.status == CategoriesStateStatus.data) {
          return _HorizontalPages(
            state: state,
            appWidth: _appWidth,
          );
        }
        return const SizedBox();
      },
    );
  }
}

class _HorizontalPages extends StatefulWidget {
  const _HorizontalPages({
    Key? key,
    required this.state,
    required this.appWidth,
  }) : super(key: key);

  final CategoriesState state;
  final double appWidth;

  @override
  __HorizontalPagesState createState() => __HorizontalPagesState();
}

class __HorizontalPagesState extends State<_HorizontalPages> {
  late final _pageController = PageController(
      viewportFraction: (widget.appWidth - 48) / widget.appWidth);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderListener<StateController<CategoryCreatorStatus>>(
      provider: categoryCreatorStatusProvider,
      // move to the end of the list of categories
      onChange: (context, value) {
        if (value.state == CategoryCreatorStatus.success) {
          _pageController.animateToPage(
            widget.state.categories.length,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
          );
        }
      },
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.state.categories.length,
        onPageChanged: (index) =>
            context.read(currentCategoryIndexProvider).state = index,
        itemBuilder: (context, index) {
          final category = widget.state.categories[index];

          return CategoryCard(
            category: category,
            onTap: () {
              context.read(currentCategoryProvider).state = category;
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, anim1, anim2) =>
                      CategoryScreen(heroId: category.id),
                  transitionsBuilder: (context, anim1, anim2, child) {
                    return FadeTransition(
                      opacity: anim1,
                      child: child,
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
