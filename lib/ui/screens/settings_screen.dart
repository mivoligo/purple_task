import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../globals/globals.dart';
import '../ui.dart';

class SettingsScreen extends StatelessWidget {
  final Color backgroundColor;

  const SettingsScreen({
    Key key,
    @required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _appWidth = MediaQuery.of(context).size.width;
    bool _isWide = MediaQuery.of(context).size.width > 600;
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
                      Colors.grey[850],
                      backgroundColor,
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
                          borderRadius: BorderRadius.circular(8.0),
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
                        tooltip: CLOSE,
                        onPressed: Navigator.of(context).pop,
                      ),
                      Spacer(),
                      Text(
                        SETTINGS,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      Spacer(),
                      const SizedBox(width: 48.0),
                    ],
                  ),
                  const SizedBox(height: 32.0),
                  Expanded(
                    child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        children: [
                          ListTile(
                            title: Text(TIME_FORMAT),
                            trailing: TimeFormatSelector(),
                          ),
                          Divider(),
                          ListTile(
                            title: Text(DATE_FORMAT),
                            trailing: DateFormatSelector(),
                          ),
                          Divider(),
                          ListTile(
                            title: Text(DISPLAY_TIME_COMPLETED),
                            trailing: Switch(
                              activeColor: Theme.of(context).primaryColor,
                              value: Provider.of<SettingsViewModel>(context)
                                  .getDisplayTaskDOneTimePref(),
                              onChanged: (value) =>
                                  Provider.of<SettingsViewModel>(context,
                                          listen: false)
                                      .setDisplayTaskDoneTimePref(value),
                            ),
                          ),
                        ]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
