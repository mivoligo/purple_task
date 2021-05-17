import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../controllers/controllers.dart';
import '../../../screens.dart';
import '../widgets.dart';

enum CategoryCreatorStatus { normal, success }

final categoryCreatorStatusProvider =
    StateProvider((_) => CategoryCreatorStatus.normal);

class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _appWidth = MediaQuery.of(context).size.width;
    _pageController = PageController(
      viewportFraction: (_appWidth - 48) / _appWidth,
      initialPage: 0,
    );
    return Consumer(
      builder: (context, watch, _) {
        final state = watch(categoriesProvider);
        if (state.status == CategoriesStateStatus.initial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.status == CategoriesStateStatus.data) {
          if (_appWidth < 600) {
            return _HorizontalPages(
              state: state,
              pageController: _pageController,
            );
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
    required this.pageController,
  }) : super(key: key);

  final CategoriesState state;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return ProviderListener<StateController<CategoryCreatorStatus>>(
      provider: categoryCreatorStatusProvider,
      // move to the end of the list of categories
      onChange: (context, value) {
        if (value.state == CategoryCreatorStatus.success) {
          pageController.animateToPage(
            state.categories.length,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
          );
        }
      },
      child: PageView.builder(
        controller: pageController,
        itemCount: state.categories.length,
        onPageChanged: (index) => context.read(backgroundColorProvider).state =
            state.categories[index].color,
        itemBuilder: (context, index) {
          final category = state.categories[index];

          return CategoryCard(
            category: category,
            onTap: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, anim1, anim2) =>
                      CategoryScreen(category: category),
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

class _HorizontalList extends StatefulWidget {
  const _HorizontalList({
    Key? key,
    required this.state,
  }) : super(key: key);

  final CategoriesState state;

  @override
  __HorizontalListState createState() => __HorizontalListState();
}

class __HorizontalListState extends State<_HorizontalList> {
  late final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderListener<StateController<CategoryCreatorStatus>>(
      provider: categoryCreatorStatusProvider,
      onChange: (context, value) {
        // move to the end of the list of categories
        if (value.state == CategoryCreatorStatus.success) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent + 400,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
          );
        }
      },
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: widget.state.categories.length,
        itemBuilder: (context, index) {
          final category = widget.state.categories[index];
          return SizedBox(
            width: 400,
            child: CategoryCard(
              category: category,
              onFocusChange: (_) =>
                  context.read(backgroundColorProvider).state = category.color,
              onHover: (_) =>
                  context.read(backgroundColorProvider).state = category.color,
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
      ),
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
