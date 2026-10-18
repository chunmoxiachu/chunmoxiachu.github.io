import 'package:flutter/material.dart';

import '../core/content.dart';
import '../core/nav.dart';
import '../core/theme.dart';
import '../widgets/page_parts.dart';
import '../widgets/primitives.dart';
import '../widgets/site_shell.dart';

/// Fallback route for unknown locations.
class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final factor = formFactorFor(width);
    final isMobile = factor.isMobile;

    return SiteShell(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
            factor.gutter,
            isMobile ? 120 : 168,
            factor.gutter,
            isMobile ? 60 : 110,
          ),
          child: PageHeading(
            eyebrow: SiteContent.notFoundEyebrow.of(context),
            title: SiteContent.notFoundTitle.of(context),
            lead: SiteContent.notFoundBody.of(context),
            actions: [
              ActionButton(
                label: SiteContent.navHome.of(context),
                onTap: () => goTo(context, '/'),
              ),
              ActionButton(
                label: SiteContent.navServices.of(context),
                onTap: () => goTo(context, '/services/consulting'),
                trailing: '\u2192',
              ),
              ActionButton(
                label: SiteContent.navLibrary.of(context),
                onTap: () => goTo(context, '/library'),
                trailing: '\u2192',
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(factor.gutter, 0, factor.gutter, 0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Image.asset(
              'assets/brand/stickers/fox.webp',
              width: isMobile ? 120 : 168,
              filterQuality: FilterQuality.high,
            ),
          ),
        ),
        const SizedBox(height: 72),
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
