import 'package:flutter/material.dart';
import 'package:to_do/ui/widgets/category_header.dart';

class CategoryScreen extends StatefulWidget {
  final Color color;
  final IconData icon;
  final String name;

  const CategoryScreen({
    Key key,
    this.color,
    this.icon,
    this.name,
  }) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _fadeAnimation;

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
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.grey[850], widget.color, widget.color],
          ),
        ),
        child: Stack(
          children: [
            Hero(
              tag: 'main${widget.color}',
              child: Container(
                height: MediaQuery.of(context).size.height,
                color: Colors.white,
              ),
            ),
            // Go back button
            Positioned(
              left: 16.0,
              top: 16.0,
              // Animation used to avoid showing back button to early
              child: AnimatedBuilder(
                  animation: _fadeAnimation,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _fadeAnimation.value,
                      child: Material(
                        type: MaterialType.transparency,
                        child: IconButton(
                          icon: Icon(Icons.arrow_back),
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
              top: 16.0,
              right: 16.0,
              child: Hero(
                tag: 'menu${widget.color}',
                child: Material(
                  type: MaterialType.transparency,
                  child: IconButton(
                    icon: Icon(Icons.menu),
                    color: Colors.grey,
                    onPressed: () {},
                  ),
                ),
              ),
            ),
            // Category icon
            Positioned(
              left: 48.0,
              top: 92.0,
              child: Hero(
                tag: 'icon${widget.color}',
                child: Icon(
                  widget.icon,
                  color: widget.color,
                  size: 40,
                ),
              ),
            ),
            Positioned(
              left: 48.0,
              top: 148.0,
              right: 48.0,
              child: Hero(
                tag: 'header${widget.color}',
                child: Material(
                  type: MaterialType.transparency,
                  child: CategoryHeader(
                    title: widget.name,
                    description: '8 tasks',
                    progress: 0.6,
                    color: widget.color,
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
