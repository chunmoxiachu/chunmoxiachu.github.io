import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'app.dart';
import 'core/app_state.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Clean URLs (`/about?lang=zh`) instead of `/#/about`.
  usePathUrlStrategy();
  runApp(LzSiteApp(initialLang: _languageFromUri()));
}

AppLang _languageFromUri() {
  return switch (Uri.base.queryParameters['lang']) {
    'en' => AppLang.en,
    _ => AppLang.zh,
  };
}
