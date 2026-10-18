import 'package:flutter/material.dart';

import '../core/app_state.dart';
import '../core/content.dart';
import '../core/nav.dart';
import '../core/theme.dart';
import '../widgets/page_parts.dart';
import '../widgets/primitives.dart';
import '../widgets/site_shell.dart';

/// `/privacy` and `/terms` — the plain-language policy pages.
class LegalPage extends StatelessWidget {
  const LegalPage({super.key, required this.kind});

  final LegalKind kind;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final factor = formFactorFor(width);
    final palette = context.palette;
    final isMobile = factor.isMobile;
    final sections = kind == LegalKind.privacy
        ? SiteContent.privacySections
        : SiteContent.termsSections;

    return SiteShell(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
            factor.gutter,
            isMobile ? 112 : 148,
            factor.gutter,
            isMobile ? 36 : 60,
          ),
          child: PageHeading(
            eyebrow: kind == LegalKind.privacy
                ? SiteContent.navPrivacy.of(context)
                : SiteContent.navTerms.of(context),
            title: kind == LegalKind.privacy
                ? SiteContent.legalIntroPrivacy.of(context)
                : SiteContent.legalIntroTerms.of(context),
            meta: SiteContent.legalUpdated.of(context),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(factor.gutter, 0, factor.gutter, 0),
          child: HairLine(),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(
            factor.gutter,
            isMobile ? 8 : 16,
            factor.gutter,
            isMobile ? 40 : 72,
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 820),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < sections.length; i++) ...[
                  RevealBox(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: isMobile ? 26 : 34),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 46,
                                child: Text(
                                  (i + 1).toString().padLeft(2, '0'),
                                  style: Lz.label(size: 12, color: palette.inkFaint),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  sections[i].title.of(context),
                                  style: Lz.sans(
                                    size: isMobile ? 19 : 22,
                                    weight: FontWeight.w600,
                                    height: 1.4,
                                    letterSpacing: -0.4,
                                    color: palette.ink,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Padding(
                            padding: EdgeInsets.only(left: isMobile ? 0 : 46),
                            child: Text(
                              sections[i].body.of(context),
                              style: Lz.sans(
                                size: isMobile ? 15 : 16,
                                height: 1.85,
                                color: palette.inkSoft,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  HairLine(),
                ],
              ],
            ),
          ),
        ),
        SizedBox(height: isMobile ? 32 : 56),
        ClosingCta(
          title: SiteContent.closingTitle.of(context),
          body: SiteContent.closingBody.of(context),
          showGlass: false,
        ),
        PageFooter(onHome: () => goTo(context, '/')),
      ],
    );
  }
}

enum LegalKind { privacy, terms }
