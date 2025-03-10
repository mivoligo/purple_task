import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:purple_task/core/constants/supported_locales.dart';
import 'package:purple_task/features/settings/controllers/settings_controller.dart';
import 'package:purple_task/features/settings/settings_repository/providers/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@riverpod
bool isUncategorizedViewPreferred(Ref ref) {
  final settings = ref.watch(settingsNotifierProvider);

  return settings.value?.isUncategorizedViewPreferred ?? true;
}

@riverpod
Future<String?> savedLocale(Ref ref) async {
  return ref.read(settingsRepositoryProvider).getLocale();
}

@riverpod
class AppLocale extends _$AppLocale {
  @override
  Locale? build() {
    final savedLocale = ref.watch(savedLocaleProvider).valueOrNull;
    return savedLocale != null ? Locale(savedLocale) : null;
  }

  Future<void> update(Locale locale) async {
    await ref
        .read(settingsNotifierProvider.notifier)
        .setLocale(value: locale.languageCode);

    final savedLocale = ref.read(settingsNotifierProvider).valueOrNull?.locale;

    final updatedLocale = switch (savedLocale) {
      null => SupportedLocales.en,
      _ => Locale(savedLocale),
    };

    state = updatedLocale;
  }
}
