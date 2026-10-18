import 'package:flutter/material.dart';

import 'theme.dart';

enum AppLang { zh, en }

/// Small global store for language + colour scheme. Kept dependency free so the
/// site stays a single lightweight bundle.
class AppState extends ChangeNotifier {
  AppState({AppLang lang = AppLang.zh, bool dark = false})
    // ignore: prefer_initializing_formals — named parameters cannot be private.
    : _lang = lang,
      // ignore: prefer_initializing_formals
      _dark = dark;

  AppLang _lang;
  bool _dark;

  AppLang get lang => _lang;
  bool get dark => _dark;
  LzPalette get palette => _dark ? LzPalette.dark : LzPalette.light;
  Brightness get brightness => _dark ? Brightness.dark : Brightness.light;

  set lang(AppLang value) {
    if (_lang == value) return;
    _lang = value;
    notifyListeners();
  }

  set dark(bool value) {
    if (_dark == value) return;
    _dark = value;
    notifyListeners();
  }

  void toggleLang() => lang = _lang == AppLang.zh ? AppLang.en : AppLang.zh;
  void toggleDark() => dark = !_dark;
}

class AppScope extends InheritedNotifier<AppState> {
  const AppScope({super.key, required AppState state, required super.child})
    : super(notifier: state);

  static AppState of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppScope>();
    assert(scope?.notifier != null, 'AppScope was not found in the widget tree.');
    return scope!.notifier!;
  }
}

extension AppContextX on BuildContext {
  AppState get app => AppScope.of(this);
  LzPalette get palette => AppScope.of(this).palette;
  bool get isZh => AppScope.of(this).lang == AppLang.zh;
}
