import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/globals/strings/strings.dart';
import 'package:to_do/models/new_category.dart';
import 'package:to_do/ui/widgets/new_category/icons_list.dart';

class CategoryIcon extends StatelessWidget {
  final Function onNextPressed;

  const CategoryIcon({
    Key key,
    @required this.onNextPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(32.0, 24.0, 32.0, 0.0),
          child: Consumer<NewCategory>(
            builder: (_, value, __) => Text(
              value.name,
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Expanded(
          child: IconsList(),
        ),
        SizedBox(height: 4.0),
        Text(
          ICON,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        Spacer(),
        Row(
          children: [
            SizedBox(width: 16.0),
            FlatButton(
              color: Colors.grey[400],
              child: Text(CANCEL),
              onPressed: () {
                Provider.of<NewCategory>(context, listen: false)
                    .addingNewCategoryCompleted = false;
                Navigator.of(context).pop();
              },
            ),
            Spacer(),
            FlatButton(
              autofocus: true,
              color: Colors.green,
              child: Text(NEXT),
              onPressed: onNextPressed,
            ),
            SizedBox(width: 16.0),
          ],
        )
      ],
    );
  }
}
