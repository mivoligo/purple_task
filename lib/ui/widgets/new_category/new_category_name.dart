import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/ui/strings/strings.dart';
import 'package:to_do/models/new_category.dart';

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
    Strings s = Provider.of<Strings>(context, listen: false);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 0.0),
          child: CupertinoTextField(
            autofocus: true,
            textInputAction: TextInputAction.done,
            onSubmitted: onSubmitted,
            style: TextStyle(fontSize: 24.0),
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
        Text(
          s.categoryName,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        Spacer(),
        Row(
          children: [
            SizedBox(width: 16.0),
            FlatButton(
              color: Colors.grey[400],
              child: Text(s.cancel),
              onPressed: () {
                Provider.of<NewCategory>(context, listen: false)
                    .addingNewCategoryCompleted = false;
                Navigator.of(context).pop();
              },
            ),
            Spacer(),
            FlatButton(
              color: Colors.green,
              child: Text(s.next),
              onPressed: onNextPressed,
            ),
            SizedBox(width: 16.0),
          ],
        ),
      ],
    );
  }
}
