import 'package:flutter/material.dart';

class SliverTaskListHeader extends StatelessWidget {
  final String title;

  const SliverTaskListHeader({
    Key key,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(
          title,
          style: Theme.of(context).textTheme.subtitle2,
        ),
      ),
    );
  }
}
