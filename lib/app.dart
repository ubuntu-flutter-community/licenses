import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:yaru/yaru.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

import 'licenses.dart';
import 'settings.dart';

class LicenseApp extends StatelessWidget {
  const LicenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return YaruTheme(
      data: YaruThemeData(
        variant: context.select((Settings s) => s.variant),
      ),
      builder: (context, yaru, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: yaru.theme,
        darkTheme: yaru.darkTheme,
        themeMode: context.select((Settings s) => s.theme),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: LicensePage.create(context),
      ),
    );
  }
}

class LicensePage extends StatelessWidget {
  const LicensePage({super.key});

  static Widget create(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LicenseStore()..load(LicenseRegistry.licenses),
      child: const LicensePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final model = context.watch<LicenseStore>();
    if (model.packages.isEmpty) {
      return const Center(child: YaruCircularProgressIndicator());
    }
    return YaruMasterDetailPage(
      appBar: YaruWindowTitleBar(
        title: Text(l10n.appTitle),
      ),
      bottomBar: Material(
        color: Theme.of(context).colorScheme.background,
        shape: Border(top: BorderSide(color: Theme.of(context).dividerColor)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: YaruMasterTile(
            leading: const Icon(YaruIcons.gear),
            title: Text(l10n.settingsTitle),
            onTap: () => showSettingsDialog(context: context),
          ),
        ),
      ),
      length: model.packages.length,
      tileBuilder: (context, index, selected, availableWidth) => YaruMasterTile(
        selected: selected,
        title: Text(model.packages[index]),
      ),
      pageBuilder: (context, index) => LicenseView(
        licenses: model.licenses(model.packages[index]),
      ),
    );
  }
}
