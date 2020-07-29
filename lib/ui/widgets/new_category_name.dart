import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/ui/strings/strings.dart';
import 'package:to_do/ui/view_models/category_model.dart';

class CategoryName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 0.0),
          child: TextField(
            autofocus: true,
            style: TextStyle(fontSize: 24.0),
            onChanged: (text) =>
                Provider.of<NewCategory>(context, listen: false).name = text,
          ),
        ),
        Text(
          Provider.of<Strings>(context, listen: false).categoryName,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
