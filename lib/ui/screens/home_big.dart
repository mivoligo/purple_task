import 'package:flutter/material.dart';
import 'package:to_do/globals/strings/strings.dart';
import 'package:to_do/ui/widgets/category_card.dart';
import 'package:to_do/ui/widgets/greetings.dart';

class HomeBig extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Greetings(
            greetings: GREETINGS,
          ),
          ListView.builder(
            itemBuilder: (context, index) {
              return CategoryCard();
            },
          )
        ],
      ),
    );
  }
}
