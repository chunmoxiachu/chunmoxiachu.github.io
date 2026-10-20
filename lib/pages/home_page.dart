import 'package:flutter/material.dart';

import '../core/app_state.dart';
import '../core/nav.dart';
import '../sections/about_section.dart';
import '../sections/contact_section.dart';
import '../sections/hero_section.dart';
import '../sections/library_section.dart';
import '../sections/method_section.dart';
import '../sections/services_section.dart';
import '../widgets/site_shell.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _methodKey = GlobalKey();
  final _servicesKey = GlobalKey();

  void _scrollToServices() {
    final anchor = _servicesKey.currentContext;
    if (anchor == null) return;
    final box = anchor.findRenderObject();
    final position = Scrollable.maybeOf(anchor)?.position;
    if (box is! RenderBox || position == null) return;
    final target = box.localToGlobal(Offset.zero).dy;
    position.animateTo(
      position.pixels + target - 72,
      duration: const Duration(milliseconds: 750),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return SiteShell(
      darkAnchorKey: _methodKey,
      children: [
        HeroSection(onExplore: _scrollToServices),
        Container(
          color: palette.paper,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 140,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [palette.sky.withValues(alpha: 0), palette.paper],
                  ),
                ),
              ),
              AboutSection(
                onStory: () => goTo(context, '/about'),
                onServices: () => goTo(context, '/services/consulting'),
              ),
              KeyedSubtree(
                key: _servicesKey,
                child: ServicesSection(onOpen: (slug) => goTo(context, '/services/$slug')),
              ),
              LibrarySection(onOpen: (path) => goTo(context, path)),
            ],
          ),
        ),
        KeyedSubtree(key: _methodKey, child: const MethodSection()),
        Container(
          color: palette.sky,
          child: ContactSection(
            onGetInTouch: () => goTo(context, '/about'),
            onPrivacy: () => goTo(context, '/privacy'),
            onTerms: () => goTo(context, '/terms'),
          ),
        ),
      ],
    );
  }
}
