import 'package:flutter/material.dart';

import '../core/app_state.dart';
import '../core/content.dart';
import '../core/theme.dart';
import '../widgets/primitives.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key, required this.onStory, required this.onX});

  final VoidCallback onStory;
  final VoidCallback onX;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final factor = formFactorFor(width);
    final palette = context.palette;
    final gutter = factor.gutter;

    final portrait = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RevealBox(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: Image.asset(
                'assets/brand/avatar-hd.webp',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(context.isZh ? '春末夏初' : 'CHUNMO XIACHU', style: Lz.mono(size: 13, color: palette.inkSoft)),
              Text(context.isZh ? 'CHUNMO XIACHU' : 'AI IN PRACTICE', style: Lz.mono(size: 13, color: palette.inkSoft)),
            ],
          ),
        ),
      ],
    );

    final copy = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RevealBox(
          child: Eyebrow(SiteContent.aboutEyebrow.of(context)),
        ),
        const SizedBox(height: 18),
        RevealBox(
          delay: const Duration(milliseconds: 80),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: Text(
              SiteContent.aboutTitle.of(context),
              style: Lz.sans(
                size: factor.isMobile ? 28 : (width < 1280 ? 38 : 46),
                weight: FontWeight.w600,
                height: 1.16,
                letterSpacing: factor.isMobile ? -0.9 : -1.6,
                color: palette.ink,
              ),
            ),
          ),
        ),
        const SizedBox(height: 22),
        RevealBox(
          delay: const Duration(milliseconds: 140),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Text(
              SiteContent.aboutBody1.of(context),
              style: Lz.sans(
                size: factor.isMobile ? 16 : 18,
                height: 1.7,
                color: palette.inkSoft,
              ),
            ),
          ),
        ),
        const SizedBox(height: 18),
        RevealBox(
          delay: const Duration(milliseconds: 200),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Text(
              SiteContent.aboutBody2.of(context),
              style: Lz.sans(
                size: factor.isMobile ? 16 : 18,
                height: 1.7,
                color: palette.inkSoft,
              ),
            ),
          ),
        ),
        const SizedBox(height: 26),
        RevealBox(
          delay: const Duration(milliseconds: 260),
          child: Wrap(
            spacing: 28,
            runSpacing: 12,
            children: [
              TextLink(label: SiteContent.aboutLinkStory.of(context), onTap: onStory),
              TextLink(label: SiteContent.aboutLinkX.of(context), arrow: '\u2197', onTap: onX),
            ],
          ),
        ),
      ],
    );

    return Padding(
      padding: EdgeInsets.fromLTRB(gutter, factor.isMobile ? 40 : 56, gutter, factor.isMobile ? 72 : 96),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RevealBox(
            child: Row(
              children: [
                Eyebrow(SiteContent.aboutKicker.of(context)),
                const Spacer(),
                Flexible(
                  child: Text(
                    SiteContent.aboutTagline.of(context),
                    textAlign: TextAlign.right,
                    style: Lz.mono(size: 14, color: palette.inkSoft),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          if (factor.isMobile) ...[
            portrait,
            const SizedBox(height: 28),
            copy,
          ] else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 4, child: portrait),
                SizedBox(width: gutter + 24),
                Expanded(flex: 8, child: copy),
              ],
            ),
        ],
      ),
    );
  }
}
