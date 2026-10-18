import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/app_state.dart';
import '../core/content.dart';
import '../core/nav.dart';
import '../core/theme.dart';
import 'primitives.dart';

/// Display heading used at the top of every sub-page.
class PageHeading extends StatelessWidget {
  const PageHeading({
    super.key,
    required this.eyebrow,
    required this.title,
    this.lead,
    this.meta,
    this.actions = const <Widget>[],
  });

  final String eyebrow;
  final String title;
  final String? lead;

  /// Small mono note rendered under the lead copy.
  final String? meta;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final factor = formFactorFor(MediaQuery.sizeOf(context).width);
    final palette = context.palette;
    final size = switch (factor) {
      FormFactor.mobile => 30.0,
      FormFactor.tablet => 40.0,
      FormFactor.desktop => 52.0,
    };
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RevealBox(child: Eyebrow(eyebrow)),
        SizedBox(height: factor.isMobile ? 16 : 24),
        RevealBox(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Text(
              title,
              style: Lz.sans(
                size: size,
                weight: FontWeight.w600,
                height: 1.16,
                letterSpacing: size * -0.028,
                color: palette.ink,
              ),
            ),
          ),
        ),
        if (lead != null) ...[
          const SizedBox(height: 20),
          RevealBox(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 680),
              child: Text(
                lead!,
                style: Lz.sans(
                  size: factor.isMobile ? 15 : 17,
                  height: 1.75,
                  color: palette.inkSoft,
                ),
              ),
            ),
          ),
        ],
        if (meta != null) ...[
          const SizedBox(height: 18),
          RevealBox(
            child: Text(
              meta!,
              style: Lz.mono(size: 13, height: 1.7, color: palette.inkFaint),
            ),
          ),
        ],
        if (actions.isNotEmpty) ...[
          const SizedBox(height: 32),
          RevealBox(
            child: Wrap(spacing: 14, runSpacing: 12, children: actions),
          ),
        ],
      ],
    );
  }
}

/// Indexed, hairline separated list of notes / outcomes.
class NoteBoard extends StatelessWidget {
  const NoteBoard({
    super.key,
    required this.label,
    required this.notes,
    this.columns = 3,
  });

  final String label;
  final List<NoteItem> notes;
  final int columns;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final factor = formFactorFor(width);
    final palette = context.palette;
    final count = factor.isMobile ? 1 : (factor.isDesktop ? columns : columns.clamp(1, 2));
    final spacing = factor.isMobile ? 0.0 : 28.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Eyebrow(label),
        const SizedBox(height: 22),
        HairLine(),
        const SizedBox(height: 26),
        LayoutBuilder(
          builder: (context, constraints) {
            final cellWidth =
                (constraints.maxWidth - spacing * (count - 1)) / count;
            return Wrap(
              spacing: spacing,
              runSpacing: factor.isMobile ? 30 : 44,
              children: [
                for (var i = 0; i < notes.length; i++)
                  SizedBox(
                    width: cellWidth,
                    child: RevealBox(
                      delay: Duration(milliseconds: 50 * i),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            (i + 1).toString().padLeft(2, '0'),
                            style: Lz.label(size: 11, color: palette.inkFaint),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            notes[i].title.of(context),
                            style: Lz.sans(
                              size: factor.isMobile ? 17 : 19,
                              weight: FontWeight.w600,
                              height: 1.4,
                              letterSpacing: -0.4,
                              color: palette.ink,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            notes[i].body.of(context),
                            style: Lz.sans(size: 15, height: 1.7, color: palette.inkSoft),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}

/// Numbered process rows with the promised output of each step.
class ProcessBoard extends StatelessWidget {
  const ProcessBoard({super.key, required this.label, required this.steps});

  final String label;
  final List<ProcessStep> steps;

  @override
  Widget build(BuildContext context) {
    final factor = formFactorFor(MediaQuery.sizeOf(context).width);
    final palette = context.palette;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Eyebrow(label),
        const SizedBox(height: 22),
        HairLine(),
        for (final step in steps) ...[
          RevealBox(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: factor.isMobile ? 22 : 28),
              child: factor.isMobile
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _ProcessIndex(step.index, palette),
                        const SizedBox(height: 12),
                        _ProcessBody(step: step),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: 84, child: _ProcessIndex(step.index, palette)),
                        Expanded(
                          flex: 3,
                          child: Text(
                            step.title.of(context),
                            style: Lz.sans(
                              size: 21,
                              weight: FontWeight.w600,
                              height: 1.35,
                              letterSpacing: -0.5,
                              color: palette.ink,
                            ),
                          ),
                        ),
                        const SizedBox(width: 28),
                        Expanded(flex: 5, child: _ProcessBody(step: step, hideTitle: true)),
                      ],
                    ),
            ),
          ),
          HairLine(),
        ],
      ],
    );
  }
}

class _ProcessIndex extends StatelessWidget {
  const _ProcessIndex(this.index, this.palette);

  final String index;
  final LzPalette palette;

  @override
  Widget build(BuildContext context) {
    return Text(index, style: Lz.label(size: 13, color: palette.inkFaint));
  }
}

class _ProcessBody extends StatelessWidget {
  const _ProcessBody({required this.step, this.hideTitle = false});

  final ProcessStep step;
  final bool hideTitle;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!hideTitle) ...[
          Text(
            step.title.of(context),
            style: Lz.sans(
              size: 19,
              weight: FontWeight.w600,
              height: 1.35,
              letterSpacing: -0.4,
              color: palette.ink,
            ),
          ),
          const SizedBox(height: 10),
        ],
        Text(
          step.body.of(context),
          style: Lz.sans(size: 15, height: 1.72, color: palette.inkSoft),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(
            border: Border.all(color: palette.ink.withValues(alpha: 0.16)),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            step.output.of(context),
            style: Lz.mono(size: 12.5, color: palette.ink),
          ),
        ),
      ],
    );
  }
}

/// Closing band shared by the home page and every sub-page.
class ClosingCta extends StatefulWidget {
  const ClosingCta({
    super.key,
    required this.title,
    required this.body,
    this.actionLabel,
    this.showGlass = true,
  });

  final String title;
  final String body;
  final String? actionLabel;
  final bool showGlass;

  @override
  State<ClosingCta> createState() => _ClosingCtaState();
}

class _ClosingCtaState extends State<ClosingCta> {
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
    final glass = context.isZh
        ? 'assets/glass/contact_talk_zh.png'
        : 'assets/glass/contact_talk_en.png';

    return Padding(
      padding: EdgeInsets.fromLTRB(factor.gutter, isMobile ? 44 : 76, factor.gutter, 0),
      child: Container(
        decoration: BoxDecoration(
          color: palette.paper,
          border: Border.all(color: palette.ink.withValues(alpha: 0.08)),
        ),
        padding: EdgeInsets.fromLTRB(
          isMobile ? 22 : 44,
          isMobile ? 30 : 46,
          isMobile ? 22 : 44,
          isMobile ? 30 : 46,
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Align(
                alignment: Alignment.topRight,
                child: LightRays(
                  rayCount: 6,
                  color: palette.ink.withValues(alpha: 0.05),
                  angle: -0.5,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.showGlass) ...[
                  RevealBox(
                    child: Image.asset(
                      glass,
                      width: isMobile ? width * 0.62 : 420,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                  SizedBox(height: isMobile ? 20 : 28),
                ],
                Text(
                  widget.title,
                  style: Lz.sans(
                    size: isMobile ? 24 : 32,
                    weight: FontWeight.w600,
                    height: 1.24,
                    letterSpacing: -1,
                    color: palette.ink,
                  ),
                ),
                const SizedBox(height: 14),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 620),
                  child: Text(
                    widget.body,
                    style: Lz.sans(size: isMobile ? 15 : 16.5, height: 1.75, color: palette.inkSoft),
                  ),
                ),
                const SizedBox(height: 26),
                Wrap(
                  spacing: 18,
                  runSpacing: 14,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    ActionButton(
                      label: widget.actionLabel ?? SiteContent.contactCta.of(context),
                      onTap: () => goTo(context, '/about'),
                    ),
                    TextLink(
                      label: _copied
                          ? SiteContent.contactCopied.of(context)
                          : '${SiteContent.contactWechat.of(context)} · ${SiteContent.wechatId}',
                      arrow: '',
                      onTap: _copyWechat,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Footer used by every sub-page (the home page keeps its own contact footer).
class PageFooter extends StatelessWidget {
  const PageFooter({super.key, required this.onHome});

  final VoidCallback onHome;

  @override
  Widget build(BuildContext context) {
    final factor = formFactorFor(MediaQuery.sizeOf(context).width);
    final palette = context.palette;
    return Padding(
      padding: EdgeInsets.fromLTRB(factor.gutter, 40, factor.gutter, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HairLine(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 22),
            child: factor.isMobile
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        SiteContent.exploreFurther.of(context),
                        style: Lz.mono(size: 13, color: palette.inkSoft),
                      ),
                      const SizedBox(height: 16),
                      _links(context),
                    ],
                  )
                : Row(
                    children: [
                      Text(
                        SiteContent.exploreFurther.of(context),
                        style: Lz.mono(size: 13, color: palette.inkSoft),
                      ),
                      const Spacer(),
                      _links(context),
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

  Widget _links(BuildContext context) {
    return Wrap(
      spacing: 22,
      runSpacing: 10,
      children: [
        TextLink(label: SiteContent.navHome.of(context), size: 13, onTap: onHome),
        TextLink(
          label: SiteContent.navPrivacy.of(context),
          arrow: '\u2197',
          size: 13,
          onTap: () => goTo(context, '/privacy'),
        ),
        TextLink(
          label: SiteContent.navTerms.of(context),
          arrow: '\u2197',
          size: 13,
          onTap: () => goTo(context, '/terms'),
        ),
      ],
    );
  }
}
