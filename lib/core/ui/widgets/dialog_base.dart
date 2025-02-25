import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';

import 'package:purple_task/core/constants/custom_styles.dart';
import 'package:purple_task/core/constants/strings/strings.dart' as s;
import 'package:purple_task/core/ui/widgets/icon_button.dart';

class DialogBase extends StatefulWidget {
  const DialogBase({
    required this.title,
    required this.heroTag,
    required this.content,
    super.key,
  });

  final String title;
  final String heroTag;
  final Widget content;

  @override
  _DialogBaseState createState() => _DialogBaseState();
}

class _DialogBaseState extends State<DialogBase>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

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
    final appWidth = MediaQuery.sizeOf(context).width;

    final isWide = appWidth > 600;
    final colorScheme = Theme.of(context).colorScheme;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: CustomStyle.standardBackground,
            ),
            Positioned(
              width: isWide ? 550 : appWidth,
              top: isWide ? 50 : 0,
              bottom: isWide ? 50 : 0,
              child: Hero(
                tag: widget.heroTag,
                child: Container(
                  decoration: isWide
                      ? CustomStyle.dialogDecoration
                          .copyWith(color: colorScheme.surface)
                      : BoxDecoration(color: colorScheme.surface),
                ),
              ),
            ),
            Positioned(
              width: isWide ? 550 : appWidth,
              top: isWide ? 50 : 0,
              bottom: isWide ? 50 : 0,
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
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomIconButton(
                            icon: const Icon(AntIcons.close),
                            color: colorScheme.onSurface,
                            tooltip: s.close,
                            onPressed: () {
                              _animationController.reverse();
                              Navigator.of(context).pop();
                            },
                          ),
                          Text(
                            widget.title,
                            style: CustomStyle.textStyle24
                                .copyWith(color: colorScheme.onSurface),
                          ),
                          const SizedBox(width: 40),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
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
