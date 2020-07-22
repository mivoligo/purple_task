import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CategoryCard extends StatelessWidget {
  final String categoryName;
  final Color categoryColor;
  final IconData categoryIcon;
  final String editTooltip;
  final String closeTooltip;
  final bool visibleCloseButton;
  final bool isExpanded;

  final VoidCallback onCloseTap;
  final VoidCallback onTap;

  const CategoryCard({
    Key key,
    this.categoryName,
    this.categoryColor,
    this.categoryIcon,
    this.editTooltip,
    this.closeTooltip,
    this.visibleCloseButton,
    this.isExpanded = false,
    this.onCloseTap,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _cardWidth = MediaQuery.of(context).size.width - 80;
    double _appHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.fromLTRB(4.0, 16.0, 4.0, 16.0),
      child: SizedBox(
        width: _cardWidth,
        child: Card(
          elevation: 8.0,
          child: Material(
            borderRadius: BorderRadius.circular(8.0),
            child: InkWell(
              onTap: onTap,
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.ease,
                    top: isExpanded ? 80.0 : 16.0,
                    left: isExpanded ? 32.0 : 16.0,
                    child: Icon(
                      categoryIcon,
                      size: 40,
                      color: categoryColor,
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                        child: Row(
                          children: [
                            AnimatedOpacity(
                              duration: Duration(milliseconds: 300),
                              opacity: isExpanded ? 1.0 : 0.0,
                              child: IconButton(
                                icon: Icon(Icons.close),
                                color: Colors.grey,
                                tooltip: closeTooltip,
                                onPressed: onCloseTap,
                              ),
                            ),
                            Spacer(),
                            IconButton(
                              icon: Icon(Icons.menu),
                              color: Colors.grey,
                              tooltip: editTooltip,
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: _cardWidth,
                        height: 120,
                        padding: EdgeInsets.all(16.0),
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
                      AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.decelerate,
                        width: _cardWidth - 32.0,
                        height: isExpanded ? _appHeight - 280.0 : 0.0,
                      )
                    ],
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
