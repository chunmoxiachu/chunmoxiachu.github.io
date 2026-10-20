import 'package:flutter/material.dart';

import '../core/app_state.dart';
import '../core/content.dart';
import '../core/nav.dart';
import '../core/theme.dart';
import '../widgets/page_parts.dart';
import '../widgets/primitives.dart';
import '../widgets/site_shell.dart';

/// `/about` — company profile and business contact details.
class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final factor = formFactorFor(width);
    final palette = context.palette;
    final isMobile = factor.isMobile;
    final twoUp = width >= 1080;

    final brandPanel = RevealBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CompanyMark(),
          const SizedBox(height: 22),
          Text(
            SiteContent.heroRole.of(context),
            style: Lz.mono(size: 12.5, height: 1.6, color: palette.inkSoft),
          ),
        ],
      ),
    );

    final story = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final (label, value) in SiteContent.companyFacts) ...[
          RevealBox(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: twoUp ? 116 : 92,
                  child: Text(
                    label.of(context),
                    style: Lz.mono(size: 12, height: 1.6, color: palette.inkFaint),
                  ),
                ),
                Expanded(
                  child: Text(
                    value.of(context),
                    style: Lz.sans(size: 15.5, height: 1.6, color: palette.ink),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          HairLine(),
          const SizedBox(height: 16),
        ],
        for (final fact in SiteContent.aboutPageFacts) ...[
          RevealBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fact.title.of(context),
                  style: Lz.sans(
                    size: 19,
                    weight: FontWeight.w600,
                    height: 1.4,
                    letterSpacing: -0.4,
                    color: palette.ink,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  fact.body.of(context),
                  style: Lz.sans(size: 15.5, height: 1.75, color: palette.inkSoft),
                ),
              ],
            ),
          ),
          const SizedBox(height: 26),
          HairLine(),
          const SizedBox(height: 26),
        ],
        RevealBox(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 620),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  SiteContent.aboutBody1.of(context),
                  style: Lz.sans(size: 16, height: 1.85, color: palette.ink),
                ),
                const SizedBox(height: 18),
                Text(
                  SiteContent.aboutBody2.of(context),
                  style: Lz.sans(size: 16, height: 1.85, color: palette.ink),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 26),
        RevealBox(
          child: Wrap(
            spacing: 24,
            runSpacing: 12,
            children: [
              TextLink(
                label: SiteContent.companyGithubLabel,
                arrow: '\u2197',
                onTap: () => openExternal(SiteContent.companyGithubUrl),
              ),
              TextLink(
                label: SiteContent.aboutLinkServices.of(context),
                arrow: '\u2197',
                color: palette.inkSoft,
                size: 14,
                onTap: () => goTo(context, '/services/consulting'),
              ),
            ],
          ),
        ),
      ],
    );

    return SiteShell(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(factor.gutter, isMobile ? 112 : 148, factor.gutter, isMobile ? 44 : 76),
          child: PageHeading(
            eyebrow: SiteContent.aboutPageEyebrow.of(context),
            title: SiteContent.aboutPageTitle.of(context),
            lead: SiteContent.aboutPageLead.of(context),
            meta: SiteContent.heroPhilosophy.of(context).replaceAll('\n', ' '),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(factor.gutter, 0, factor.gutter, isMobile ? 48 : 88),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (twoUp)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 300, child: brandPanel),
                    const SizedBox(width: 64),
                    Expanded(child: story),
                  ],
                )
              else ...[
                SizedBox(
                  width: isMobile ? width - factor.gutter * 2 : 360,
                  child: brandPanel,
                ),
                const SizedBox(height: 40),
                story,
              ],
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: factor.gutter),
          child: HairLine(),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(factor.gutter, isMobile ? 40 : 64, factor.gutter, isMobile ? 40 : 72),
          child: _contactCopy(context),
        ),
        ClosingCta(
          title: SiteContent.closingTitle.of(context),
          body: SiteContent.closingBody.of(context),
        ),
        PageFooter(onHome: () => goTo(context, '/')),
      ],
    );
  }

  Widget _contactCopy(BuildContext context) {
    final factor = formFactorFor(MediaQuery.sizeOf(context).width);
    final palette = context.palette;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Eyebrow(SiteContent.contactEyebrow.of(context)),
        const SizedBox(height: 20),
        Text(
          SiteContent.contactTitle.of(context),
          style: Lz.sans(
            size: factor.isMobile ? 26 : 32,
            weight: FontWeight.w600,
            height: 1.24,
            letterSpacing: -1,
            color: palette.ink,
          ),
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Text(
            SiteContent.contactBody.of(context),
            style: Lz.sans(size: 16, height: 1.78, color: palette.inkSoft),
          ),
        ),
        const SizedBox(height: 26),
        TextLink(
          label: SiteContent.companyGithubLabel,
          arrow: '\u2197',
          onTap: () => openExternal(SiteContent.companyGithubUrl),
        ),
      ],
    );
  }
}
