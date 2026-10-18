import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import 'app_state.dart';

/// Navigates while keeping the `?lang=` query parameter in the address bar so
/// links stay shareable.
void goTo(BuildContext context, String path) {
  final lang = context.app.lang == AppLang.zh ? 'zh' : 'en';
  context.go('$path?lang=$lang');
}

Future<void> openExternal(String url) {
  return launchUrl(Uri.parse(url), webOnlyWindowName: '_blank');
}
