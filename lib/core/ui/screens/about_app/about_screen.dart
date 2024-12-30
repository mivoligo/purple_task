import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';

import '../../../constants/custom_styles.dart';
import '../../../constants/strings/strings.dart' as s;
import '../../../helpers.dart';
import '../../widgets/dialog_base.dart';
import '../../widgets/simple_button.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DialogBase(
      title: s.about,
      heroTag: 'about',
      content: Expanded(
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
                onTap: () => _showLicenseDialog(context),
              ),
            ),
            const Divider(indent: 8, endIndent: 8),
            Material(
              color: const Color(0xFFEEEEEE),
              child: ListTile(
                title: const Text(s.sourceCode),
                trailing: const Icon(AntIcons.arrowRight),
                onTap: () => UrlHelper().openUrl(s.sourceCodeUrl),
              ),
            ),
            const Divider(indent: 8, endIndent: 8),
            Material(
              color: const Color(0xFFEEEEEE),
              child: ListTile(
                title: const Text(s.bugs),
                trailing: const Icon(AntIcons.arrowRight),
                onTap: () => UrlHelper().openUrl(s.bugsUrl),
              ),
            ),
            const Divider(indent: 8, endIndent: 8),
          ],
        ),
      ),
    );
  }

  Future _showLicenseDialog(BuildContext context) {
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
            ),
          ],
        );
      },
    );
  }
}
