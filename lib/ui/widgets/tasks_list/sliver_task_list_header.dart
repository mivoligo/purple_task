import 'package:flutter/material.dart';
import '../../../constants/constants.dart';

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
        padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
        child: Text(
          title,
          style: CustomStyle.textStyleTaskFilter,
        ),
      ),
    );
  }
}
