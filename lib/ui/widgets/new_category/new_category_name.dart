import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/globals/strings/strings.dart';
import 'package:to_do/models/new_category.dart';
import 'package:to_do/ui/widgets/simple_button.dart';

class CategoryName extends StatelessWidget {
  final Function onSubmitted;
  final Function onNextPressed;

  const CategoryName({
    Key key,
    this.onSubmitted,
    @required this.onNextPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 0.0),
          child: CupertinoTextField(
            autofocus: true,
            textInputAction: TextInputAction.done,
            onSubmitted: onSubmitted,
            style: Theme.of(context).textTheme.headline4,
            decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(color: Colors.grey[300], offset: Offset(0.0, -2.0)),
                  BoxShadow(color: Colors.white, offset: Offset(0.0, 1.0)),
                ]),
            onChanged: (text) =>
                Provider.of<NewCategory>(context, listen: false).name = text,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          CATEGORY_NAME,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        Spacer(),
        Row(
          children: [
            SizedBox(width: 16.0),
            SimpleButton(
              text: CANCEL,
              onPressed: () {
                Provider.of<NewCategory>(context, listen: false)
                    .addingNewCategoryCompleted = false;
                Navigator.of(context).pop();
              },
            ),
            Spacer(),
            SimpleButton(
              text: NEXT,
              color: Colors.green,
              onPressed: onNextPressed,
            ),
            SizedBox(width: 16.0),
          ],
        ),
      ],
    );
  }
}
