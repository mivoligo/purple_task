import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../globals/globals.dart';
import '../../ui.dart';

class CategoryIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(32.0, 24.0, 32.0, 0.0),
          child: Consumer<NewCategoryViewModel>(
            builder: (_, value, __) => Text(
              value.name,
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Expanded(
          child: IconsList(),
        ),
        const SizedBox(height: 4.0),
        Text(
          ICON,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        Spacer(),
      ],
    );
  }
}
