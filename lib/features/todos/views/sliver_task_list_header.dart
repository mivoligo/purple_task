import 'package:flutter/material.dart';

import '../../../core/constants/custom_styles.dart';

class SliverTaskListHeader extends StatelessWidget {
  const SliverTaskListHeader({
    Key? key,
    required this.title,
  }) : super(key: key);

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
