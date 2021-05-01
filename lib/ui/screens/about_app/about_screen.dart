import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import '../../../globals/globals.dart';
import '../../../globals/strings/strings.dart' as s;

import '../../../helpers.dart';
import '../../ui.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({
    Key? key,
    required this.backgroundColor,
  }) : super(key: key);

  final Color backgroundColor;

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen>
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
    final _appWidth = MediaQuery.of(context).size.width;
    final _isWide = MediaQuery.of(context).size.width > 600;
    return Scaffold(
      body: Container(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // colored background
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.grey[850]!,
                      widget.backgroundColor,
                    ]),
              ),
            ),
            // container for settings
            Positioned(
              width: _isWide ? 550 : _appWidth,
              top: _isWide ? 50 : 0,
              bottom: _isWide ? 50 : 0,
              child: Hero(
                tag: 'about',
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
                    // back button and title
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomIconButton(
                            icon: const Icon(AntIcons.arrow_left),
                            color: Colors.white,
                            tooltip: s.close,
                            onPressed: () {
                              _animationController.reverse();
                              Navigator.of(context).pop();
                            },
                          ),
                          const Text(
                            s.about,
                            style: CustomStyle.textStyleBigName,
                          ),
                          const SizedBox(width: 40.0),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32.0),
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        children: [
                          Image.asset('assets/images/icon.png', height: 100),
                          Text(
                            '${s.appName} ${s.appVersion}',
                            textAlign: TextAlign.center,
                            style: CustomStyle.textStyleTitle.copyWith(
                              color: const Color(0xFF673AB7),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              s.appDescription,
                              textAlign: TextAlign.center,
                              style: CustomStyle.textStyleTaskName,
                            ),
                          ),
                          const Divider(indent: 8, endIndent: 8),
                          Material(
                            color: const Color(0xFFEEEEEE),
                            child: ListTile(
                              title: const Text(s.license),
                              trailing: const Text(s.licenseShort),
                              onTap: _showLicenseDialog,
                            ),
                          ),
                          const Divider(indent: 8, endIndent: 8),
                          Material(
                            color: const Color(0xFFEEEEEE),
                            child: ListTile(
                              title: const Text(s.sourceCode),
                              trailing: const Icon(AntIcons.arrow_right),
                              onTap: () => UrlHelper().openUrl(s.sourceCodeUrl),
                            ),
                          ),
                          const Divider(indent: 8, endIndent: 8),
                          Material(
                            color: const Color(0xFFEEEEEE),
                            child: ListTile(
                              title: const Text(s.bugs),
                              trailing: const Icon(AntIcons.arrow_right),
                              onTap: () => UrlHelper().openUrl(s.bugsUrl),
                            ),
                          ),
                          const Divider(indent: 8, endIndent: 8),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showLicenseDialog() {
    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          content: const SingleChildScrollView(
            child: Text(s.mitLicense),
          ),
          actions: [
            SimpleButton(
              text: s.close,
              onPressed: Navigator.of(context).pop,
            )
          ],
        );
      },
    );
  }
}
