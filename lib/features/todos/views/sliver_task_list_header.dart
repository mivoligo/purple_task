import 'package:flutter/material.dart';

import 'package:purple_task/core/constants/custom_styles.dart';

class SliverTaskListHeader extends StatelessWidget {
  const SliverTaskListHeader({
    required this.title,
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 12, 8, 6),
        child: Column(
          children: [
            const Divider(),
            Text(
              title,
              style: CustomStyle.textStyleTaskFilter,
            ),
          ],
        ),
      ),
    );
  }
}
