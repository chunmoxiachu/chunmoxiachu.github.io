import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/app_state.dart';
import '../core/content.dart';
import '../core/theme.dart';
import 'primitives.dart';
import 'site_chrome.dart';

/// Shared page frame: background wash, guide grid, fixed chrome and scrolling
/// body. Every route is composed inside this shell.
class SiteShell extends StatefulWidget {
  const SiteShell({
    super.key,
    required this.children,
    this.darkAnchorKey,
    this.headerOpaque = false,
  });

  final List<Widget> children;

  /// Widget key of the dark band; when it slides under the header the chrome
  /// switches to its light-on-dark styling.
  final GlobalKey? darkAnchorKey;
  final bool headerOpaque;

  @override
  State<SiteShell> createState() => _SiteShellState();
}

class _SiteShellState extends State<SiteShell> {
  final _scrollController = ScrollController();
  bool _chromeOnDark = false;
  bool _menuOpen = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_syncChrome);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_syncChrome)
      ..dispose();
    super.dispose();
  }

  void _syncChrome() {
    final anchorContext = widget.darkAnchorKey?.currentContext;
    var onDark = false;
    if (anchorContext != null) {
      final box = anchorContext.findRenderObject();
      if (box is RenderBox && box.hasSize) {
        final top = box.localToGlobal(Offset.zero).dy;
        onDark = top <= 64 && top + box.size.height >= 64;
      }
    }
    if (onDark != _chromeOnDark && mounted) {
      setState(() => _chromeOnDark = onDark);
    }
  }

  void _navigate(String path, {bool replace = false}) {
    final lang = context.app.lang == AppLang.zh ? 'zh' : 'en';
    final target = '$path?lang=$lang';
    if (replace) {
      context.replace(target);
    } else {
      context.go(target);
    }
  }

  @override
  Widget build(BuildContext context) {
    final app = context.app;
    final palette = app.palette;
    final chromeFg = _chromeOnDark ? LzPalette.light.onDark : palette.chromeFg;
    return Scaffold(
      backgroundColor: palette.sky,
      body: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [palette.sky, palette.skyDeep],
                ),
              ),
            ),
          ),
          Positioned.fill(child: GridOverlay()),
          Positioned.fill(
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: widget.children,
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SiteHeader(
              brand: context.isZh ? SiteContent.brand : SiteContent.brandEn,
              foreground: chromeFg,
              onHome: () => _navigate('/'),
              onServices: () => _navigate('/services/consulting'),
              onLibrary: () => _navigate('/library'),
              onContact: () => _navigate('/about'),
              onAbout: () => _navigate('/about'),
              onMenu: () => setState(() => _menuOpen = true),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SiteFooterBar(scrollController: _scrollController, foreground: chromeFg),
          ),
          Positioned.fill(
            child: MenuOverlay(
              open: _menuOpen,
              onClose: () => setState(() => _menuOpen = false),
              onNavigate: _navigate,
            ),
          ),
        ],
      ),
    );
  }
}

/// Section wrapper that paints a background, keeps the page gutter and can
/// blend its top edge into the previous section.
class Section extends StatelessWidget {
  const Section({
    super.key,
    required this.child,
    this.color,
    this.padding,
    this.blendFrom,
    this.maxWidth,
  });

  final Widget child;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final Color? blendFrom;
  final double? maxWidth;

  @override
  Widget build(BuildContext context) {
    final factor = formFactorFor(MediaQuery.sizeOf(context).width);
    final palette = context.palette;
    final resolved = padding ?? EdgeInsets.symmetric(horizontal: factor.gutter);
    Widget content = Padding(padding: resolved, child: child);
    if (maxWidth != null) {
      content = Center(
        child: ConstrainedBox(constraints: BoxConstraints(maxWidth: maxWidth!), child: content),
      );
    }
    return DecoratedBox(
      decoration: BoxDecoration(color: color ?? palette.paper),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (blendFrom != null)
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [blendFrom!.withValues(alpha: 0), blendFrom!.withValues(alpha: 0.35), color ?? palette.paper],
                ),
              ),
              child: const SizedBox(height: 120),
            ),
          content,
        ],
      ),
    );
  }
}
