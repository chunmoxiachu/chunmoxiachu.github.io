import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';

import 'core/app_state.dart';
import 'core/content.dart';
import 'core/theme.dart';
import 'pages/about_page.dart';
import 'pages/home_page.dart';
import 'pages/legal_page.dart';
import 'pages/library_page.dart';
import 'pages/not_found_page.dart';
import 'pages/service_detail_page.dart';

/// Root widget: owns the shared [AppState], the router and keeps the address
/// bar (`?lang=`) in sync with the language toggle.
class LzSiteApp extends StatefulWidget {
  const LzSiteApp({super.key, this.initialLang = AppLang.zh});

  final AppLang initialLang;

  @override
  State<LzSiteApp> createState() => _LzSiteAppState();
}

class _LzSiteAppState extends State<LzSiteApp> {
  late final AppState _state = AppState(lang: widget.initialLang);
  late final GoRouter _router = GoRouter(
    initialLocation: _locationFromBrowser(),
    routes: [
      GoRoute(path: '/', name: 'home', builder: (_, _) => const HomePage()),
      GoRoute(path: '/about', name: 'about', builder: (_, _) => const AboutPage()),
      GoRoute(
        path: '/services/:slug',
        name: 'service',
        builder: (context, state) =>
            ServiceDetailPage(slug: state.pathParameters['slug'] ?? ''),
      ),
      GoRoute(path: '/library', name: 'library', builder: (_, _) => const LibraryPage()),
      for (final path in const ['/go-global', '/learn-ai', '/geo-wiki', '/blog'])
        GoRoute(
          path: path,
          name: 'collection$path',
          builder: (_, _) => LibraryCollectionPage(path: path),
        ),
      GoRoute(
        path: '/privacy',
        name: 'privacy',
        builder: (_, _) => const LegalPage(kind: LegalKind.privacy),
      ),
      GoRoute(
        path: '/terms',
        name: 'terms',
        builder: (_, _) => const LegalPage(kind: LegalKind.terms),
      ),
    ],
    errorBuilder: (context, state) => const NotFoundPage(),
  );

  @override
  void initState() {
    super.initState();
    _router.routerDelegate.addListener(_syncLanguageFromUrl);
    _syncLanguageFromUrl();
  }

  @override
  void dispose() {
    _router.routerDelegate.removeListener(_syncLanguageFromUrl);
    _router.dispose();
    _state.dispose();
    super.dispose();
  }

  /// The URL is the source of truth for the language, so deep links such as
  /// `/?lang=en` open in English.
  void _syncLanguageFromUrl() {
    final requested = _requestedLanguage();
    if (requested == null || requested == _state.lang) return;
    if (SchedulerBinding.instance.schedulerPhase == SchedulerPhase.persistentCallbacks) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _state.lang = requested;
      });
    } else {
      _state.lang = requested;
    }
  }

  AppLang? _requestedLanguage() {
    try {
      final value =
          _router.routerDelegate.currentConfiguration.uri.queryParameters['lang'];
      return switch (value) {
        'zh' => AppLang.zh,
        'en' => AppLang.en,
        _ => null,
      };
    } on StateError {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScope(
      state: _state,
      child: AnimatedBuilder(
        animation: _state,
        builder: (context, _) => MaterialApp.router(
          title: SiteContent.pageTitle.of(context),
          debugShowCheckedModeBanner: false,
          theme: LzTheme.build(
            palette: _state.palette,
            brightness: _state.brightness,
          ),
          routerConfig: _router,
          scrollBehavior: const _SiteScrollBehavior(),
        ),
      ),
    );
  }
}

String _locationFromBrowser() {
  const indexSuffix = '/index.html';
  var path = Uri.base.path;
  if (path.endsWith(indexSuffix)) {
    path = path.substring(0, path.length - indexSuffix.length);
  }
  if (path.isEmpty) path = '/';
  final query = Uri.base.query;
  return query.isEmpty ? path : '$path?$query';
}

/// Trackpad scrolling on the desktop and no Android-style overscroll glow.
class _SiteScrollBehavior extends MaterialScrollBehavior {
  const _SiteScrollBehavior();

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) => child;

  @override
  Set<PointerDeviceKind> get dragDevices => const {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.trackpad,
    PointerDeviceKind.stylus,
  };
}
