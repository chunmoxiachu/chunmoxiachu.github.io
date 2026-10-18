import 'package:flutter/material.dart';

import '../core/content.dart';
import '../core/nav.dart';
import '../core/theme.dart';
import '../widgets/page_parts.dart';
import '../widgets/primitives.dart';
import '../widgets/site_shell.dart';
import 'not_found_page.dart';

/// `/services/:slug` — consulting, training and FDE detail pages.
class ServiceDetailPage extends StatelessWidget {
  const ServiceDetailPage({super.key, required this.slug});

  final String slug;

  @override
  Widget build(BuildContext context) {
    final detail = SiteContent.serviceDetails[slug];
    ServiceItem? service;
    for (final item in SiteContent.services) {
      if (item.slug == slug) {
        service = item;
        break;
      }
    }
    if (detail == null || service == null) {
      return const NotFoundPage();
    }

    final width = MediaQuery.sizeOf(context).width;
    final factor = formFactorFor(width);
    final isMobile = factor.isMobile;
    final twoUp = width >= 1000;

    final copy = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PageHeading(
          eyebrow: detail.eyebrow.of(context),
          title: detail.title.of(context),
          lead: detail.lead.of(context),
          meta: detail.tags.of(context),
          actions: [
            ActionButton(
              label: detail.cta.of(context),
              onTap: () => goTo(context, '/about'),
            ),
          ],
        ),
      ],
    );

    final art = RevealBox(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(service.panel), Color(service.panelAlt)],
          ),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 20 : 34,
          vertical: isMobile ? 28 : 44,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              service.art,
              height: isMobile ? 210 : 320,
              filterQuality: FilterQuality.high,
            ),
            SizedBox(height: isMobile ? 26 : 40),
            Text(
              SiteContent.servicesOutcomeLabel.of(context).toUpperCase(),
              style: Lz.label(size: 11, color: const Color(0xCC111111)),
            ),
            const SizedBox(height: 8),
            Text(
              service.deliverables.of(context),
              style: Lz.sans(
                size: isMobile ? 18 : 21,
                weight: FontWeight.w600,
                height: 1.5,
                letterSpacing: -0.4,
                color: const Color(0xFF111111),
              ),
            ),
          ],
        ),
      ),
    );

    return SiteShell(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
            factor.gutter,
            isMobile ? 112 : 148,
            factor.gutter,
            isMobile ? 36 : 64,
          ),
          child: twoUp
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: copy),
                    const SizedBox(width: 64),
                    SizedBox(width: 380, child: art),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    copy,
                    const SizedBox(height: 36),
                    art,
                  ],
                ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(factor.gutter, isMobile ? 40 : 64, factor.gutter, 0),
          child: NoteBoard(
            label: detail.notesLabel.of(context),
            notes: detail.notes,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(factor.gutter, isMobile ? 56 : 96, factor.gutter, 0),
          child: ProcessBoard(
            label: detail.processLabel.of(context),
            steps: detail.process,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(factor.gutter, isMobile ? 56 : 96, factor.gutter, 0),
          child: NoteBoard(
            label: detail.outcomeLabel.of(context),
            notes: detail.outcomes,
            columns: 2,
          ),
        ),
        const SizedBox(height: 84),
        ClosingCta(
          title: detail.closingTitle.of(context),
          body: detail.closingBody.of(context),
          actionLabel: detail.cta.of(context),
          showGlass: false,
        ),
        PageFooter(onHome: () => goTo(context, '/')),
      ],
    );
  }
}
