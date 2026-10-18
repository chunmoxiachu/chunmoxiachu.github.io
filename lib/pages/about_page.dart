import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/app_state.dart';
import '../core/content.dart';
import '../core/nav.dart';
import '../core/theme.dart';
import '../widgets/page_parts.dart';
import '../widgets/primitives.dart';
import '../widgets/site_shell.dart';

/// `/about` — who Liangzhu is, plus the direct contact details.
class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  bool _copied = false;

  Future<void> _copyWechat() async {
    await Clipboard.setData(const ClipboardData(text: SiteContent.wechatId));
    if (!mounted) return;
    setState(() => _copied = true);
    Future<void>.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _copied = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final factor = formFactorFor(width);
    final palette = context.palette;
    final isMobile = factor.isMobile;
    final twoUp = width >= 980;

    final portrait = RevealBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.asset(
                  'assets/brand/avatar-hd.webp',
                  width: twoUp ? 300 : width * 0.62,
                  filterQuality: FilterQuality.high,
                ),
              ),
              Positioned(
                right: -28,
                top: -22,
                child: Image.asset(
                  'assets/brand/stickers/bamboo.webp',
                  width: 78,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ],
          ),
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
                label: 'X · ${SiteContent.xHandle}',
                arrow: '\u2197',
                onTap: () => openExternal(SiteContent.xUrl),
              ),
              TextLink(
                label: SiteContent.contactInspiration.of(context),
                arrow: '\u2197',
                color: palette.inkSoft,
                size: 14,
                onTap: () => openExternal(SiteContent.inspirationUrl),
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
            lead: SiteContent.heroBio.of(context),
            meta: SiteContent.heroPhilosophy.of(context).replaceAll('\n', ' '),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(factor.gutter, 0, factor.gutter, isMobile ? 48 : 88),
          child: twoUp
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 360, child: portrait),
                    const SizedBox(width: 64),
                    Expanded(child: story),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    portrait,
                    const SizedBox(height: 40),
                    story,
                  ],
                ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: factor.gutter),
          child: HairLine(),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(factor.gutter, isMobile ? 40 : 64, factor.gutter, isMobile ? 40 : 72),
          child: twoUp
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _contactCopy(context)),
                    const SizedBox(width: 64),
                    _wechatCard(context, isMobile),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _contactCopy(context),
                    const SizedBox(height: 32),
                    _wechatCard(context, isMobile),
                  ],
                ),
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              SiteContent.contactWechat.of(context).toUpperCase(),
              style: Lz.label(size: 11, color: palette.inkFaint),
            ),
            const SizedBox(height: 8),
            TextLink(
              label: _copied
                  ? SiteContent.contactCopied.of(context)
                  : SiteContent.wechatId,
              arrow: '',
              size: 16,
              onTap: _copyWechat,
            ),
          ],
        ),
      ],
    );
  }

  Widget _wechatCard(BuildContext context, bool isMobile) {
    final palette = context.palette;
    return RevealBox(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: palette.paper,
          border: Border.all(color: palette.ink.withValues(alpha: 0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: isMobile ? 150 : 176,
              height: isMobile ? 150 : 176,
              padding: const EdgeInsets.all(8),
              color: Colors.white,
              child: Image.asset('assets/brand/wechat-qr.webp', filterQuality: FilterQuality.high),
            ),
            const SizedBox(height: 12),
            Text(
              SiteContent.contactScan.of(context),
              style: Lz.mono(size: 12.5, color: palette.inkSoft),
            ),
          ],
        ),
      ),
    );
  }
}
