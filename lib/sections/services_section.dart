import 'package:flutter/material.dart';

import '../core/app_state.dart';
import '../core/content.dart';
import '../core/theme.dart';
import '../widgets/primitives.dart';

/// Home page services: three colour panels side by side, split by hairlines.
class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key, required this.onOpen});

  final void Function(String slug) onOpen;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final factor = formFactorFor(width);
    final palette = context.palette;
    final gutter = factor.gutter;
    final threeUp = factor.isDesktop;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        gutter,
        factor.isMobile ? 48 : 72,
        gutter,
        factor.isMobile ? 56 : 92,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RevealBox(child: Eyebrow(SiteContent.servicesLabel.of(context))),
          const SizedBox(height: 14),
          RevealBox(
            child: Text(
              SiteContent.servicesTitle.of(context),
              style: Lz.sans(
                size: factor.isMobile ? 30 : 52,
                weight: FontWeight.w600,
                height: 1.2,
                letterSpacing: factor.isMobile ? -0.9 : -1.6,
                color: palette.ink,
              ),
            ),
          ),
          const SizedBox(height: 18),
          RevealBox(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 760),
              child: Text(
                SiteContent.servicesLead.of(context),
                style: Lz.sans(size: factor.isMobile ? 15 : 16, height: 1.7, color: palette.inkSoft),
              ),
            ),
          ),
          SizedBox(height: factor.isMobile ? 32 : 52),
          HairLine(),
          if (threeUp)
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var i = 0; i < SiteContent.services.length; i++)
                    Expanded(child: _serviceColumn(context, SiteContent.services[i], i, true)),
                ],
              ),
            )
          else
            Column(
              children: [
                for (var i = 0; i < SiteContent.services.length; i++) ...[
                  _serviceColumn(context, SiteContent.services[i], i, false),
                  if (i < SiteContent.services.length - 1) HairLine(),
                ],
              ],
            ),
        ],
      ),
    );
  }

  Widget _serviceColumn(BuildContext context, ServiceItem service, int index, bool threeUp) {
    final factor = formFactorFor(MediaQuery.sizeOf(context).width);
    final palette = context.palette;
    final isMobile = factor.isMobile;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: threeUp
            ? Border(
                left: BorderSide(
                  color: index == 0 ? Colors.transparent : palette.line,
                ),
              )
            : null,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          right: threeUp ? (index == SiteContent.services.length - 1 ? 0 : 28) : 0,
          left: threeUp ? (index == 0 ? 0 : 28) : 0,
          top: factor.isMobile ? 28 : 36,
          bottom: factor.isMobile ? 4 : 12,
        ),
        child: RevealBox(
          delay: Duration(milliseconds: 80 * index),
          child: _ServicePanel(service: service, onOpen: onOpen, isMobile: isMobile),
        ),
      ),
    );
  }
}

class _ServicePanel extends StatefulWidget {
  const _ServicePanel({
    required this.service,
    required this.onOpen,
    required this.isMobile,
  });

  final ServiceItem service;
  final void Function(String slug) onOpen;
  final bool isMobile;

  @override
  State<_ServicePanel> createState() => _ServicePanelState();
}

class _ServicePanelState extends State<_ServicePanel> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final service = widget.service;
    final isMobile = widget.isMobile;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: () => widget.onOpen(service.slug),
        behavior: HitTestBehavior.opaque,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedScale(
              scale: _hover ? 1.012 : 1,
              duration: const Duration(milliseconds: 320),
              curve: Curves.easeOutCubic,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(service.panel), Color(service.panelAlt)],
                  ),
                ),
                padding: EdgeInsets.fromLTRB(
                  isMobile ? 18 : 24,
                  isMobile ? 20 : 26,
                  isMobile ? 18 : 24,
                  isMobile ? 18 : 22,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: isMobile ? 180 : 230,
                      child: Center(
                        child: Image.asset(
                          service.art,
                          height: isMobile ? 170 : 215,
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                    ),
                    SizedBox(height: isMobile ? 20 : 26),
                    Text(
                      SiteContent.servicesOutcomeLabel.of(context).toUpperCase(),
                      style: Lz.label(size: 11, color: const Color(0xCC111111)),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      service.deliverables.of(context),
                      style: Lz.sans(
                        size: isMobile ? 17 : 20,
                        weight: FontWeight.w600,
                        height: 1.5,
                        letterSpacing: -0.4,
                        color: const Color(0xFF111111),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: isMobile ? 20 : 26),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    service.name.of(context),
                    style: Lz.sans(
                      size: isMobile ? 26 : 28,
                      weight: FontWeight.w600,
                      height: 1.2,
                      letterSpacing: -0.7,
                      color: palette.ink,
                    ),
                  ),
                ),
                Text('\u2197', style: Lz.sans(size: 20, color: palette.ink)),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              service.blurb.of(context),
              style: Lz.sans(size: 15, height: 1.72, color: palette.inkSoft),
            ),
            const SizedBox(height: 14),
            Text(
              service.deliverables.of(context),
              style: Lz.mono(size: 12.5, height: 1.6, color: palette.inkFaint),
            ),
            const SizedBox(height: 18),
            TextLink(
              label: service.action.of(context),
              onTap: () => widget.onOpen(service.slug),
            ),
          ],
        ),
      ),
    );
  }
}
