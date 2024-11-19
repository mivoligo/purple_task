import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../constants/constants.dart';
import '../../../../../constants/strings/strings.dart' as s;
import '../../../../../models/models.dart';
import '../../../../../providers/providers.dart';
import '../../../../widgets/category_header.dart';

class CategoryCard extends ConsumerWidget {
  const CategoryCard({
    required this.category,
    required this.onTap,
    this.onHover,
    this.onFocusChange,
  });

  final Category category;
  final VoidCallback onTap;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocusChange;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeTasksNumber =
        ref.watch(numberOfActiveTasksInCategoryProvider(category.id));
    final progress = ref.watch(completionProgressProvider(category.id));
    final description = switch (activeTasksNumber) {
      0 => '$activeTasksNumber ${s.taskPlural}',
      1 => '$activeTasksNumber ${s.taskSingular}',
      _ => '$activeTasksNumber ${s.taskPlural}',
    };
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
      child: Stack(
        children: [
          Hero(
            tag: 'main${category.id}',
            child: Container(
              decoration: CustomStyle.categoryCardDecoration,
            ),
          ),
          Positioned(
            left: 16.0,
            top: 16.0,
            child: Hero(
              tag: 'icon${category.id}',
              child: Icon(
                IconData(
                  category.icon,
                  fontFamily: 'AntIcons',
                  fontPackage: 'ant_icons',
                ),
                size: 40.0,
                color: category.color,
              ),
            ),
          ),
          Positioned(
            left: 24.0,
            right: 24.0,
            bottom: 16.0,
            child: Hero(
              tag: 'header${category.id}',
              // get rid of overflow error
              // https://github.com/flutter/flutter/issues/27320
              flightShuttleBuilder: (
                flightContext,
                animation,
                flightDirection,
                fromHeroContext,
                toHeroContext,
              ) {
                return SingleChildScrollView(
                  child: toHeroContext.widget,
                );
              },
              child: Material(
                type: MaterialType.transparency,
                child: CategoryHeader(
                  title: category.name,
                  color: category.color,
                  description: description,
                  progress: progress,
                ),
              ),
            ),
          ),
          Material(
            type: MaterialType.transparency,
            borderRadius: const BorderRadius.all(Radius.circular(12.0)),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: onTap,
              onHover: onHover,
              onFocusChange: onFocusChange,
            ),
          ),
        ],
      ),
    );
  }
}
