import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../globals/globals.dart';
import '../ui.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    Key? key,
    required this.backgroundColor,
  }) : super(key: key);

  final Color backgroundColor;

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _fadeAnimation;

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
                tag: 'settings',
                child: Container(
                  decoration: _isWide
                      ? BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(24.0),
                          boxShadow: [
                              const BoxShadow(
                                color: Color(0xff45000000),
                                offset: Offset(0.0, 4.0),
                                blurRadius: 8.0,
                              ),
                            ])
                      : BoxDecoration(color: Colors.grey[200]),
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
                    const SizedBox(height: 8.0),
                    // back button and title
                    Row(
                      children: [
                        const SizedBox(width: 8.0),
                        CustomIconButton(
                          icon: Icon(AntIcons.arrow_left),
                          color: Colors.white,
                          tooltip: close,
                          onPressed: () {
                            _animationController.reverse();
                            Navigator.of(context).pop();
                          },
                        ),
                        Spacer(),
                        Text(
                          settings,
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        Spacer(),
                        const SizedBox(width: 48.0),
                      ],
                    ),
                    const SizedBox(height: 32.0),
                    Expanded(
                      child: ListView(
                          padding: const EdgeInsets.symmetric(horizontal: 28.0),
                          children: [
                            ListTile(
                              title: Text(timeFormat),
                              trailing: TimeFormatSelector(),
                            ),
                            const Divider(indent: 8, endIndent: 8),
                            ListTile(
                              title: Text(dateFormat),
                              trailing: DateFormatSelector(),
                            ),
                            const Divider(indent: 8, endIndent: 8),
                            ListTile(
                              title: Text(displayTimeCompleted),
                              trailing: Switch(
                                activeColor: Theme.of(context).primaryColor,
                                value: Provider.of<SettingsViewModel>(context)
                                    .getDisplayTaskDOneTimePref(),
                                onChanged: (value) =>
                                    Provider.of<SettingsViewModel>(context,
                                            listen: false)
                                        .setDisplayTaskDoneTimePref(
                                            value: value),
                              ),
                            ),
                          ]),
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
}
