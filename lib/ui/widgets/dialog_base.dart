import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../constants/strings/strings.dart' as s;
import 'widgets.dart';

class DialogBase extends StatefulWidget {
  const DialogBase({
    Key? key,
    required this.title,
    required this.heroTag,
    required this.content,
  }) : super(key: key);

  final String title;
  final String heroTag;
  final Widget content;

  @override
  _DialogBaseState createState() => _DialogBaseState();
}

class _DialogBaseState extends State<DialogBase>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInExpo,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _appWidth = MediaQuery.sizeOf(context).width;
    final _isWide = _appWidth > 600;
    return Scaffold(
      body: Container(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: CustomStyle.standardBackground,
            ),
            Positioned(
              width: _isWide ? 550 : _appWidth,
              top: _isWide ? 50 : 0,
              bottom: _isWide ? 50 : 0,
              child: Hero(
                tag: widget.heroTag,
                child: Container(
                  decoration: _isWide
                      ? CustomStyle.dialogDecoration
                      : const BoxDecoration(color: Color(0xFFEEEEEE)),
                ),
              ),
            ),
            Positioned(
              width: _isWide ? 550 : _appWidth,
              top: _isWide ? 50 : 0,
              bottom: _isWide ? 50 : 0,
              child: AnimatedBuilder(
                animation: _fadeAnimation,
                builder: (context, child) {
                  return Opacity(
                    opacity: _fadeAnimation.value,
                    child: child,
                  );
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(width: 40.0),
                          Text(
                            widget.title,
                            style: CustomStyle.textStyle24,
                          ),
                          CustomIconButton(
                            icon: const Icon(AntIcons.close),
                            color: Colors.white,
                            tooltip: s.close,
                            onPressed: () {
                              _animationController.reverse();
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32.0),
                    widget.content,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
