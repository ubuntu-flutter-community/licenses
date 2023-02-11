import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

import 'app.dart';
import 'settings.dart';

Future<void> main() async {
  await YaruWindowTitleBar.ensureInitialized();

  runApp(
    ChangeNotifierProvider(
      create: (_) => Settings(),
      child: const LicenseApp(),
    ),
  );
}
