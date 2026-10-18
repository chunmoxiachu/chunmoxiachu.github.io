import 'package:flutter/material.dart';

import '../core/app_state.dart';
import '../core/content.dart';
import '../core/theme.dart';
import '../widgets/primitives.dart';

class LibrarySection extends StatelessWidget {
  const LibrarySection({super.key, required this.onOpen});

  final void Function(String path) onOpen;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final factor = formFactorFor(width);
    final palette = context.palette;
    final gutter = factor.gutter;
    final twoUp = width >= 1080;

    return Padding(
      padding: EdgeInsets.fromLTRB(gutter, factor.isMobile ? 48 : 72, gutter, factor.isMobile ? 64 : 104),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RevealBox(child: Eyebrow(SiteContent.libraryLabel.of(context))),
          const SizedBox(height: 14),
          RevealBox(
            child: Text(
              SiteContent.libraryTitle.of(context),
              style: Lz.sans(
                size: factor.isMobile ? 27 : 36,
                weight: FontWeight.w600,
                height: 1.24,
                letterSpacing: factor.isMobile ? -0.9 : -1.3,
                color: palette.ink,
              ),
            ),
          ),
          SizedBox(height: factor.isMobile ? 28 : 44),
          Wrap(
            spacing: twoUp ? 28 : 0,
            runSpacing: factor.isMobile ? 36 : 52,
            children: [
              for (var i = 0; i < SiteContent.library.length; i++)
                SizedBox(
                  width: twoUp ? (width - gutter * 2 - 28) / 2 : width - gutter * 2,
                  child: RevealBox(
                    delay: Duration(milliseconds: 60 * i),
                    child: _LibraryCard(
                      item: SiteContent.library[i],
                      onTap: () => onOpen(SiteContent.library[i].path),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LibraryCard extends StatefulWidget {
  const _LibraryCard({required this.item, required this.onTap});

  final LibraryItem item;
  final VoidCallback onTap;

  @override
  State<_LibraryCard> createState() => _LibraryCardState();
}

class _LibraryCardState extends State<_LibraryCard> {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: AnimatedScale(
                      scale: _hover ? 1.03 : 1,
                      duration: const Duration(milliseconds: 420),
                      curve: Curves.easeOutCubic,
                      child: Image.asset(
                        item.art,
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 18,
                    top: 18,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      color: const Color(0x33FFFFFF),
                      child: Text(
                        '${item.index} /',
                        style: Lz.mono(size: 12, color: const Color(0xFF0F1C28)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    item.title.of(context),
                    style: Lz.sans(
                      size: factor.isMobile ? 22 : 26,
                      weight: FontWeight.w600,
                      letterSpacing: -0.7,
                      color: palette.ink,
                    ),
                  ),
                ),
                AnimatedSlide(
                  offset: _hover ? const Offset(0.12, -0.12) : Offset.zero,
                  duration: const Duration(milliseconds: 260),
                  child: Text('\u2197', style: Lz.sans(size: 20, color: palette.ink)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Text(
                item.blurb.of(context),
                style: Lz.sans(size: factor.isMobile ? 14 : 15, height: 1.7, color: palette.inkSoft),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
