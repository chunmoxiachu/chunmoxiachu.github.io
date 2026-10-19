import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/app_state.dart';
import '../core/content.dart';
import '../core/theme.dart';

/// Fixed header: brand on the left, navigation / toggles on the right.
class SiteHeader extends StatelessWidget {
  const SiteHeader({
    super.key,
    required this.brand,
    required this.onHome,
    required this.onServices,
    required this.onLibrary,
    required this.onContact,
    required this.onAbout,
    required this.onMenu,
    required this.foreground,
  });

  final String brand;
  final VoidCallback onHome;
  final VoidCallback onServices;
  final VoidCallback onLibrary;
  final VoidCallback onContact;
  final VoidCallback onAbout;
  final VoidCallback onMenu;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final factor = formFactorFor(width);
    return IgnorePointer(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: factor.gutter, vertical: factor.isMobile ? 16 : 24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Hoverable(
              onTap: onHome,
              child: Text(
                brand,
                style: Lz.label(size: factor.isMobile ? 13 : 14, letterSpacing: 0.02, color: foreground),
              ),
            ),
            const Spacer(),
            if (factor.isDesktop) ...[
              _NavLink(label: SiteContent.navServices.of(context), onTap: onServices, color: foreground),
              const SizedBox(width: 28),
              _NavLink(label: SiteContent.navLibrary.of(context), onTap: onLibrary, color: foreground),
              const SizedBox(width: 28),
              _NavLink(label: SiteContent.navContact.of(context), onTap: onAbout, color: foreground),
              const SizedBox(width: 30),
              _ThemeToggle(color: foreground),
              const SizedBox(width: 22),
              _LangToggle(color: foreground),
            ] else ...[
              _LangToggle(color: foreground, compact: true),
              const SizedBox(width: 18),
              _Hoverable(
                onTap: onMenu,
                child: SizedBox(
                  width: 26,
                  height: 16,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(height: 1.6, color: foreground),
                      Container(height: 1.6, color: foreground),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  const _NavLink({required this.label, required this.onTap, required this.color});

  final String label;
  final VoidCallback onTap;
  final Color color;

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedOpacity(
          opacity: _hover ? 0.55 : 1,
          duration: const Duration(milliseconds: 150),
          child: Text(widget.label, style: Lz.sans(size: 15, color: widget.color)),
        ),
      ),
    );
  }
}

class _ThemeToggle extends StatelessWidget {
  const _ThemeToggle({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    final app = context.app;
    return _Hoverable(
      onTap: app.toggleDark,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(app.dark ? Icons.dark_mode_outlined : Icons.light_mode_outlined, size: 15, color: color),
          const SizedBox(width: 7),
          Text(
            app.dark
                ? (context.isZh ? '暗色' : 'Dark')
                : (context.isZh ? '明亮' : 'Light'),
            style: Lz.mono(size: 14, color: color),
          ),
        ],
      ),
    );
  }
}

class _LangToggle extends StatelessWidget {
  const _LangToggle({required this.color, this.compact = false});

  final Color color;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return _Hoverable(
      onTap: () => _switchLanguage(context),
      child: Text(
        compact ? (context.isZh ? 'EN' : '中文') : (context.isZh ? 'EN' : '中文'),
        style: Lz.label(size: 14, letterSpacing: 0.04, color: color),
      ),
    );
  }
}

void _switchLanguage(BuildContext context) {
  final app = context.app;
  app.toggleLang();
  final location = GoRouterState.of(context).uri.path;
  final lang = app.lang == AppLang.zh ? 'zh' : 'en';
  context.go('$location?lang=$lang');
}

class _Hoverable extends StatefulWidget {
  const _Hoverable({required this.child, required this.onTap});

  final Widget child;
  final VoidCallback onTap;

  @override
  State<_Hoverable> createState() => _HoverableState();
}

class _HoverableState extends State<_Hoverable> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedOpacity(
          opacity: _hover ? 0.6 : 1,
          duration: const Duration(milliseconds: 150),
          child: widget.child,
        ),
      ),
    );
  }
}

/// Bottom-left clock + bottom-right scroll progress button.
class SiteFooterBar extends StatelessWidget {
  const SiteFooterBar({
    super.key,
    required this.scrollController,
    required this.foreground,
  });

  final ScrollController scrollController;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    final factor = formFactorFor(MediaQuery.sizeOf(context).width);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: factor.gutter, vertical: factor.isMobile ? 16 : 22),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _BeijingClock(color: foreground),
          const Spacer(),
          _ScrollProgressButton(controller: scrollController, color: foreground),
        ],
      ),
    );
  }
}

class _BeijingClock extends StatefulWidget {
  const _BeijingClock({required this.color});

  final Color color;

  @override
  State<_BeijingClock> createState() => _BeijingClockState();
}

class _BeijingClockState extends State<_BeijingClock> {
  Timer? _timer;
  String _time = '';

  @override
  void initState() {
    super.initState();
    _tick();
    _timer = Timer.periodic(const Duration(seconds: 20), (_) => _tick());
  }

  void _tick() {
    final now = DateTime.now().toUtc().add(const Duration(hours: 8));
    final value = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
    if (mounted && value != _time) setState(() => _time = value);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final label = context.isZh ? '北京时间' : 'BEIJING';
    return AnimatedDefaultTextStyle(
      duration: const Duration(milliseconds: 300),
      style: Lz.mono(size: 14, color: widget.color),
      child: Text('$label $_time'),
    );
  }
}

class _ScrollProgressButton extends StatelessWidget {
  const _ScrollProgressButton({required this.controller, required this.color});

  final ScrollController controller;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        // `maxScrollExtent` throws until the scroll view has been laid out,
        // which happens on the very first frame of every route.
        final position = controller.hasClients ? controller.position : null;
        final ready = position != null && position.hasContentDimensions;
        final max = ready ? position.maxScrollExtent : 0.0;
        final value = ready && max > 0
            ? (position.pixels / max).clamp(0.0, 1.0)
            : 0.0;
        return _Hoverable(
          onTap: () {
            if (controller.hasClients) {
              controller.animateTo(0, duration: const Duration(milliseconds: 700), curve: Curves.easeOutCubic);
            }
          },
          child: SizedBox(
            width: 40,
            height: 40,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  size: const Size(40, 40),
                  painter: _ProgressRingPainter(progress: value, color: color),
                ),
                // The ring around the brand mark doubles as the reading
                // progress meter.
                Text(
                  'CX',
                  style: Lz.label(size: 11.5, letterSpacing: 0.14, color: color),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ProgressRingPainter extends CustomPainter {
  _ProgressRingPainter({required this.progress, required this.color});

  final double progress;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final rect = Rect.fromCircle(center: center, radius: size.width / 2 - 2);
    canvas.drawCircle(
      center,
      size.width / 2 - 2,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = color.withValues(alpha: 0.18),
    );
    if (progress <= 0) return;
    canvas.drawArc(
      rect,
      -1.5708,
      6.28319 * progress,
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..strokeCap = StrokeCap.round
        ..color = color,
    );
  }

  @override
  bool shouldRepaint(_ProgressRingPainter old) => old.progress != progress || old.color != color;
}

/// Full screen navigation overlay shown from the compact header.
class MenuOverlay extends StatelessWidget {
  const MenuOverlay({
    super.key,
    required this.open,
    required this.onClose,
    required this.onNavigate,
  });

  final bool open;
  final VoidCallback onClose;
  final void Function(String path) onNavigate;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final entries = <(String, String)>[
      (SiteContent.navServices.of(context), '/services/consulting'),
      (SiteContent.navLibrary.of(context), '/library'),
      (SiteContent.navAbout.of(context), '/about'),
      (SiteContent.navPrivacy.of(context), '/privacy'),
      (SiteContent.navTerms.of(context), '/terms'),
    ];
    return IgnorePointer(
      ignoring: !open,
      child: AnimatedOpacity(
        opacity: open ? 1 : 0,
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOut,
        child: Container(
          color: palette.paper,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: formFactorFor(MediaQuery.sizeOf(context).width).gutter,
                vertical: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        SiteContent.brand,
                        style: Lz.label(size: 13, color: palette.ink),
                      ),
                      const Spacer(),
                      _Hoverable(
                        onTap: onClose,
                        child: Text(
                          SiteContent.navClose.of(context),
                          style: Lz.label(size: 13, color: palette.ink),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 48),
                  for (final entry in entries)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: _Hoverable(
                        onTap: () {
                          onClose();
                          onNavigate(entry.$2);
                        },
                        child: Text(
                          entry.$1,
                          style: Lz.sans(
                            size: 34,
                            weight: FontWeight.w600,
                            letterSpacing: -0.02 * 34,
                            color: palette.ink,
                          ),
                        ),
                      ),
                    ),
                  const Spacer(),
                  Text(
                    SiteContent.wechatId,
                    style: Lz.mono(size: 13, color: palette.inkSoft),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
