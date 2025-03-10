import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purple_task/core/constants/supported_locales.dart';
import 'package:purple_task/features/settings/providers/providers.dart';

class LanguageSelector extends ConsumerWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localeController = ref.watch(appLocaleProvider.notifier);
    final currentLocale = Localizations.localeOf(context);

    return MenuAnchor(
      menuChildren: [
        ...AppLocalizations.supportedLocales.map(
          (locale) {
            return MenuItemButton(
              onPressed: () {
                localeController.update(locale);
              },
              child: Text(
                SupportedLocales.localeToString(locale),
                style: currentLocale == locale
                    ? const TextStyle(fontWeight: FontWeight.bold)
                    : null,
              ),
            );
          },
        ),
      ],
      builder: (context, controller, child) {
        return OutlinedButton(
          onPressed: () {
            controller.isOpen ? controller.close() : controller.open();
          },
          child: Text(
            SupportedLocales.localeToString(currentLocale),
          ),
        );
      },
    );
  }
}
