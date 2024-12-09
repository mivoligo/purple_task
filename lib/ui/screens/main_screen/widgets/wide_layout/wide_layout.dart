import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../constants/constants.dart';
import '../../../../../constants/strings/strings.dart';
import '../../../../../controllers/category/category_controller.dart';
import '../../../../../models/models.dart';
import '../../../../widgets/category_element.dart';
import '../../../../widgets/category_list.dart';
import '../../../../widgets/uncategorized_menu.dart';
import '../add_category_button.dart';
import '../category_details.dart';
import '../top_bar.dart';
import '../uncategorized_tasks.dart';

class WideLayout extends ConsumerWidget {
  const WideLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final category = ref.watch(categoryNotifierProvider);

    final uncategorizedCategory = const Category.empty()
        .copyWith(id: -1, name: noCategory, icon: AntIcons.appstore.codePoint);

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: TopBar(),
        ),
        Expanded(
          child: Row(
            children: [
              SizedBox(
                width: 360,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8,
                      ),
                      child: InkWell(
                        onTap: () => ref
                            .read(categoryNotifierProvider.notifier)
                            .setCurrentCategory(null),
                        child: Transform.scale(
                          scale: category == null ? 1.03 : 1,
                          child: Card(
                            margin: EdgeInsets.zero,
                            shape: category == null
                                ? RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    side: const BorderSide(
                                      color: Colors.deepPurple,
                                      width: 4,
                                      strokeAlign: -4,
                                    ),
                                  )
                                : null,
                            child: Padding(
                              padding: category == null
                                  ? const EdgeInsets.symmetric(
                                      vertical: 16.0,
                                      horizontal: 16,
                                    )
                                  : const EdgeInsets.all(8.0),
                              child: IntrinsicHeight(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: CategoryElement(
                                        uncategorizedCategory,
                                      ),
                                    ),
                                    const Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        VerticalDivider(),
                                        UncategorizedMenu(iconSize: 16),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      height: 16,
                      indent: 16,
                      endIndent: 16,
                    ),
                    const Expanded(
                      child: CategoryList(shouldPushDetails: false),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 16,
                        bottom: 16,
                        left: 16,
                        right: 16,
                      ),
                      child: Center(child: AddCategoryButton()),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 8, bottom: 16, right: 16),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 500),
                      child: DecoratedBox(
                        decoration: CustomStyle.uncategorizedTasksDecoration,
                        child: category != null
                            ? CategoryDetails(category: category)
                            : const UncategorizedTasks(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
