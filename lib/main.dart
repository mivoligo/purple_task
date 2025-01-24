import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:purple_task/app.dart';
import 'package:purple_task/core/hive_legacy/hive_init.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveInit().initHive();

  // TODO(m): Set app window size

  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
