import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:to_do/ui/view_models/category_model.dart';
import 'package:to_do/ui/widgets/category_header.dart';

class CategoryScreen extends StatefulWidget {
  final Category currentCategory;

  const CategoryScreen({
    Key key,
    this.currentCategory,
  }) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _fadeAnimation;
  double _appWidth;
  double _appHeight;
  bool get _isPortrait => _appWidth < _appHeight;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInExpo,
    );
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _paddingTop = MediaQuery.of(context).padding.top;
    _appWidth = MediaQuery.of(context).size.width;
    _appHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.grey[850],
              widget.currentCategory.color,
              widget.currentCategory.color
            ],
          ),
        ),
        child: Stack(
          children: [
            Hero(
              tag: 'main${widget.currentCategory.name}',
              child: Container(
                height: MediaQuery.of(context).size.height,
                color: Colors.grey[200],
              ),
            ),
            // Go back button
            Positioned(
              left: 16.0,
              top: 16.0 + _paddingTop,
              // Animation used to avoid showing back button to early
              child: AnimatedBuilder(
                  animation: _fadeAnimation,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _fadeAnimation.value,
                      child: Material(
                        type: MaterialType.transparency,
                        child: IconButton(
                          icon: Icon(AntIcons.arrow_left),
                          color: Colors.grey,
                          onPressed: () {
                            _animationController.reverse();
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    );
                  }),
            ),
            // menu button
            Positioned(
              top: 16.0 + _paddingTop,
              right: 16.0,
              child: Hero(
                tag: 'menu${widget.currentCategory.name}',
                child: Material(
                  type: MaterialType.transparency,
                  child: IconButton(
                    icon: Icon(AntIcons.menu),
                    color: Colors.grey,
                    onPressed: () {},
                  ),
                ),
              ),
            ),
            // Category icon
            Positioned(
              left: 48.0,
              top: 92.0 + _paddingTop,
              child: Hero(
                tag: 'icon${widget.currentCategory.name}',
                child: Icon(
                  widget.currentCategory.icon,
                  color: widget.currentCategory.color,
                  size: 40,
                ),
              ),
            ),
            // Header
            Positioned(
              left: 48.0,
              top: 148.0 + _paddingTop,
              // TODO Make sure to improve this for desktop
              right: _isPortrait ? 48.0 : _appWidth / 2 + 32.0,
              child: Hero(
                tag: 'header${widget.currentCategory.name}',
                child: Material(
                  type: MaterialType.transparency,
                  child: CategoryHeader(
                    title: widget.currentCategory.name,
                    description: '8 tasks',
                    progress: 0.6,
                    color: widget.currentCategory.color,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
