import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../controllers/controllers.dart';
import '../../../../../globals/globals.dart';
import '../../../../../globals/strings/strings.dart' as s;
import '../../../../../models/models.dart';
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
  final Function(bool)? onHover;
  final Function(bool)? onFocusChange;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    String description;
    final activeTasksNumber = watch(activeTasksNumberProvider(category.id));
    final progress = watch(progressProvider(category.id));
    switch (activeTasksNumber) {
      case 0:
        description = '$activeTasksNumber ${s.taskPlural}';
        break;
      case 1:
        description = '$activeTasksNumber ${s.taskSingular}';
        break;
      default:
        description = '$activeTasksNumber ${s.taskPlural}';
    }
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
