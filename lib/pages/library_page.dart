import 'package:flutter/material.dart';

import '../core/app_state.dart';
import '../core/content.dart';
import '../core/nav.dart';
import '../core/theme.dart';
import '../widgets/page_parts.dart';
import '../widgets/primitives.dart';
import '../widgets/site_shell.dart';

/// `/library` — overview of the four content collections.
class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final factor = formFactorFor(width);
    final isMobile = factor.isMobile;
    final twoUp = width >= 1080;
    final gutter = factor.gutter;
    final available = width - gutter * 2;

    return SiteShell(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(gutter, isMobile ? 112 : 148, gutter, isMobile ? 36 : 60),
          child: PageHeading(
            eyebrow: SiteContent.libraryLabel.of(context),
            title: SiteContent.libraryTitle.of(context),
            lead: SiteContent.collectionNote.of(context),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(gutter, 0, gutter, isMobile ? 56 : 92),
          child: Wrap(
            spacing: twoUp ? 28 : 0,
            runSpacing: isMobile ? 34 : 48,
            children: [
              for (var i = 0; i < SiteContent.library.length; i++)
                SizedBox(
                  width: twoUp ? (available - 28) / 2 : available,
                  child: RevealBox(
                    delay: Duration(milliseconds: 60 * i),
                    child: _CollectionCard(
                      item: SiteContent.library[i],
                      onTap: () => goTo(context, SiteContent.library[i].path),
                    ),
                  ),
                ),
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
}

class _CollectionCard extends StatefulWidget {
  const _CollectionCard({required this.item, required this.onTap});

  final LibraryItem item;
  final VoidCallback onTap;

  @override
  State<_CollectionCard> createState() => _CollectionCardState();
}

class _CollectionCardState extends State<_CollectionCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final factor = formFactorFor(MediaQuery.sizeOf(context).width);
    final palette = context.palette;
    final item = widget.item;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 260),
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(0, _hover ? -4 : 0, 0),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: palette.sky,
            border: Border.all(
              color: _hover ? palette.ink.withValues(alpha: 0.28) : palette.ink.withValues(alpha: 0.08),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  item.art,
                  height: factor.isMobile ? 150 : 200,
                  filterQuality: FilterQuality.high,
                ),
              ),
              const SizedBox(height: 24),
              Text(item.index, style: Lz.label(size: 11, color: palette.inkFaint)),
              const SizedBox(height: 10),
              Text(
                item.title.of(context),
                style: Lz.sans(
                  size: factor.isMobile ? 20 : 24,
                  weight: FontWeight.w600,
                  height: 1.35,
                  letterSpacing: -0.6,
                  color: palette.ink,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                item.blurb.of(context),
                style: Lz.sans(size: 15, height: 1.72, color: palette.inkSoft),
              ),
              const SizedBox(height: 20),
              Text(
                SiteContent.navLibrary.of(context),
                style: Lz.mono(size: 12.5, color: palette.ink),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// `/go-global`, `/learn-ai`, `/geo-wiki`, `/blog` — a single collection.
class LibraryCollectionPage extends StatelessWidget {
  const LibraryCollectionPage({super.key, required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final factor = formFactorFor(width);
    final isMobile = factor.isMobile;
    final entry = SiteContent.libraryPages[path];
    final others = SiteContent.library
        .where((item) => item.path != path)
        .toList(growable: false);
    final twoUp = width >= 1080;
    final available = width - factor.gutter * 2;

    return SiteShell(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
            factor.gutter,
            isMobile ? 112 : 148,
            factor.gutter,
            isMobile ? 40 : 72,
          ),
          child: PageHeading(
            eyebrow: SiteContent.collectionEyebrow.of(context),
            title: entry?.title.of(context) ?? SiteContent.libraryTitle.of(context),
            lead: entry?.body.of(context),
            meta: SiteContent.collectionNote.of(context),
            actions: [
              ActionButton(
                label: SiteContent.navLibrary.of(context),
                onTap: () => goTo(context, '/library'),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(factor.gutter, 0, factor.gutter, 0),
          child: HairLine(),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(
            factor.gutter,
            isMobile ? 36 : 56,
            factor.gutter,
            isMobile ? 48 : 84,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Eyebrow(SiteContent.collectionOthers.of(context)),
              const SizedBox(height: 24),
              Wrap(
                spacing: twoUp ? 28 : 0,
                runSpacing: isMobile ? 30 : 44,
                children: [
                  for (var i = 0; i < others.length; i++)
                    SizedBox(
                      width: twoUp ? (available - 28) / 2 : available,
                      child: RevealBox(
                        delay: Duration(milliseconds: 60 * i),
                        child: _CollectionRow(
                          item: others[i],
                          onTap: () => goTo(context, others[i].path),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
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

class _CollectionRow extends StatefulWidget {
  const _CollectionRow({required this.item, required this.onTap});

  final LibraryItem item;
  final VoidCallback onTap;

  @override
  State<_CollectionRow> createState() => _CollectionRowState();
}

class _CollectionRowState extends State<_CollectionRow> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final item = widget.item;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(
              color: _hover ? palette.ink.withValues(alpha: 0.26) : palette.ink.withValues(alpha: 0.08),
            ),
            color: palette.paper,
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(item.art, width: 84, filterQuality: FilterQuality.high),
                const SizedBox(width: 18),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.index, style: Lz.label(size: 11, color: palette.inkFaint)),
                      const SizedBox(height: 8),
                      Text(
                        item.title.of(context),
                        style: Lz.sans(
                          size: 19,
                          weight: FontWeight.w600,
                          height: 1.35,
                          letterSpacing: -0.4,
                          color: palette.ink,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item.blurb.of(context),
                        style: Lz.sans(size: 14.5, height: 1.7, color: palette.inkSoft),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  '\u2192',
                  style: Lz.sans(size: 16, color: palette.inkSoft),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
