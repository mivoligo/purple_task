import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:purple_task/core/constants/custom_styles.dart';
import 'package:purple_task/core/constants/strings/strings.dart' as s;
import 'package:purple_task/core/helpers.dart';
import 'package:purple_task/core/ui/widgets/dialog_base.dart';
import 'package:purple_task/core/ui/widgets/simple_button.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context);
    return DialogBase(
      title: tr.aboutAppViewTitle,
      heroTag: 'about',
      content: Expanded(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          children: [
            Image.asset('assets/images/icon.png', height: 100),
            Text(
              '${s.appName} ${s.appVersion}',
              textAlign: TextAlign.center,
              style: CustomStyle.textStyleTitle.copyWith(
                color: const Color(0xFF673AB7),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                tr.appDescription,
                textAlign: TextAlign.center,
                style: CustomStyle.textStyleTaskName
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
            ),
            const Divider(),
            Material(
              color: const Color(0xFFEEEEEE),
              child: ListTile(
                title: Text(tr.license),
                trailing: const Text(s.licenseShort),
                onTap: () => _showLicenseDialog(context),
              ),
            ),
            const Divider(),
            Material(
              color: const Color(0xFFEEEEEE),
              child: ListTile(
                title: Text(tr.sourceCode),
                trailing: const Icon(AntIcons.arrowRight),
                onTap: () => UrlHelper().openUrl(s.sourceCodeUrl),
              ),
            ),
            const Divider(),
            Material(
              color: const Color(0xFFEEEEEE),
              child: ListTile(
                title: Text(tr.reportIssuesButton),
                trailing: const Icon(AntIcons.arrowRight),
                onTap: () => UrlHelper().openUrl(s.bugsUrl),
              ),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }

  Future<void> _showLicenseDialog(BuildContext context) {
    final tr = AppLocalizations.of(context);
    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          content: const SingleChildScrollView(
            child: Text(s.mitLicense),
          ),
          actions: [
            SimpleButton(
              text: tr.closeButton,
              onPressed: Navigator.of(context).pop,
            ),
          ],
        );
      },
    );
  }
}
