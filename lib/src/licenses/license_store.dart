import 'package:flutter/foundation.dart';
import 'package:safe_change_notifier/safe_change_notifier.dart';

class LicenseStore extends SafeChangeNotifier {
  final _licenses = <String, List<LicenseEntry>>{};

  List<String> get packages => _licenses.keys.toList();
  List<LicenseEntry> licenses(String package) => _licenses[package]!;

  Future<void> load(Stream<LicenseEntry> licenses) async {
    _licenses.clear();
    await for (final license in licenses) {
      final package = license.packages.first;
      _licenses.putIfAbsent(package, () => []).add(license);
    }
    notifyListeners();
  }
}
