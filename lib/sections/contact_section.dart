import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/app_state.dart';
import '../core/content.dart';
import '../core/theme.dart';
import '../widgets/primitives.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({
    super.key,
    required this.onGetInTouch,
    required this.onPrivacy,
    required this.onTerms,
  });

  final VoidCallback onGetInTouch;
  final VoidCallback onPrivacy;
  final VoidCallback onTerms;

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
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
    final gutter = factor.gutter;
    final glass = context.isZh
        ? 'assets/glass/contact_talk_zh.png'
        : 'assets/glass/contact_talk_en.png';

    final details = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RevealBox(
          child: Text(
            SiteContent.contactTitle.of(context),
            style: Lz.sans(
              size: isMobile ? 26 : 34,
              weight: FontWeight.w600,
              height: 1.24,
              letterSpacing: -1.1,
              color: palette.ink,
            ),
          ),
        ),
        const SizedBox(height: 14),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 460),
          child: Text(
            SiteContent.contactBody.of(context),
            style: Lz.sans(size: isMobile ? 15 : 16, height: 1.75, color: palette.inkSoft),
          ),
        ),
        const SizedBox(height: 26),
        ActionButton(label: SiteContent.contactCta.of(context), onTap: widget.onGetInTouch),
        const SizedBox(height: 34),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: isMobile ? 120 : 152,
                  height: isMobile ? 120 : 152,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.asset('assets/brand/wechat-qr.webp', filterQuality: FilterQuality.high),
                ),
                const SizedBox(height: 10),
                Text(
                  SiteContent.contactScan.of(context),
                  style: Lz.mono(size: 12, color: palette.inkSoft),
                ),
                const SizedBox(height: 2),
                GestureDetector(
                  onTap: _copyWechat,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Text(
                      _copied ? SiteContent.contactCopied.of(context) : SiteContent.wechatId,
                      style: Lz.mono(size: 12, color: palette.ink),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 32),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextLink(
                    label: 'X · ${SiteContent.xHandle}',
                    arrow: '\u2197',
                    onTap: () => _open(SiteContent.xUrl),
                  ),
                  const SizedBox(height: 14),
                  TextLink(
                    label: SiteContent.contactInspiration.of(context),
                    arrow: '',
                    color: palette.inkSoft,
                    size: 13,
                    onTap: () => _open(SiteContent.inspirationUrl),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );

    return Padding(
      padding: EdgeInsets.fromLTRB(gutter, isMobile ? 40 : 64, gutter, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RevealBox(child: Eyebrow(SiteContent.contactEyebrow.of(context))),
          const SizedBox(height: 24),
          RevealBox(
            child: Align(
              alignment: Alignment.center,
              child: Image.asset(
                glass,
                width: isMobile ? width * 0.9 : width * 0.72,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
          SizedBox(height: isMobile ? 24 : 40),
          details,
          SizedBox(height: isMobile ? 48 : 72),
          HairLine(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 22),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(SiteContent.exploreFurther.of(context), style: Lz.mono(size: 13, color: palette.inkSoft)),
                const Spacer(),
                Wrap(
                  spacing: 22,
                  children: [
                    TextLink(
                      label: SiteContent.navPrivacy.of(context),
                      arrow: '\u2197',
                      size: 13,
                      onTap: widget.onPrivacy,
                    ),
                    TextLink(
                      label: SiteContent.navTerms.of(context),
                      arrow: '\u2197',
                      size: 13,
                      onTap: widget.onTerms,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text(
            SiteContent.copyright.of(context),
            style: Lz.label(size: 12, color: palette.inkSoft),
          ),
          const SizedBox(height: 96),
        ],
      ),
    );
  }

  void _open(String url) {
    launchUrl(Uri.parse(url), webOnlyWindowName: '_blank');
  }
}
