import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/ui/strings/strings.dart';
import 'package:to_do/ui/view_models/category_model.dart';
import 'package:to_do/ui/widgets/icons_list.dart';

class CategoryIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(32.0, 24.0, 32.0, 0.0),
            child: Consumer<NewCategory>(
              builder: (_, value, __) => Text(
                value.name,
                style: TextStyle(fontSize: 24.0),
              ),
            ),
          ),
          SizedBox(height: 8.0),
          Expanded(
            child: IconsList(),
          ),
          Text(
            Provider.of<Strings>(context, listen: false).icon,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
