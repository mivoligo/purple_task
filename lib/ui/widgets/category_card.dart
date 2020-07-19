import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CategoryCard extends StatelessWidget {
  final String categoryName;
  final Color categoryColor;
  final IconData categoryIcon;
  final String editTooltip;

  const CategoryCard({
    Key key,
    this.categoryName,
    this.categoryColor,
    this.categoryIcon,
    this.editTooltip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _cardWidth = MediaQuery.of(context).size.width - 80;
    return Padding(
      padding: EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
      child: SizedBox(
        width: _cardWidth,
        child: Card(
          elevation: 8.0,
          child: Material(
            borderRadius: BorderRadius.circular(8.0),
            child: InkWell(
              onTap: () {},
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Icon(
                          categoryIcon,
                          size: 40,
                          color: categoryColor,
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.menu),
                          color: Colors.grey[500],
                          tooltip: editTooltip,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Container(
                    width: _cardWidth,
                    height: 150,
                    padding: EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('8 tasks'),
                        SizedBox(height: 8),
                        Text(
                          categoryName,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 24),
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Expanded(
                              child: LinearProgressIndicator(
                                value: 0.6,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    categoryColor),
                                backgroundColor: Colors.grey[300],
                              ),
                            ),
                            SizedBox(width: 8),
                            Text('70%'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
