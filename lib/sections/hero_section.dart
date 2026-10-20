import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../core/app_state.dart';
import '../core/content.dart';
import '../core/theme.dart';
import '../widgets/primitives.dart';

/// First screen: oversized headline, glass 3D greeting and floating stickers.
class HeroSection extends StatefulWidget {
  const HeroSection({super.key, required this.onExplore});

  final VoidCallback onExplore;

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  final _tilt = ValueNotifier<Offset>(Offset.zero);
  final _scroll = ValueNotifier<double>(0);
  ScrollPosition? _position;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final position = Scrollable.maybeOf(context)?.position;
    if (!identical(position, _position)) {
      _position?.removeListener(_onScroll);
      _position = position;
      _position?.addListener(_onScroll);
    }
  }

  void _onScroll() {
    _scroll.value = _position?.pixels ?? 0;
  }

  @override
  void dispose() {
    _position?.removeListener(_onScroll);
    _tilt.dispose();
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final factor = formFactorFor(size.width);
    final palette = context.palette;
    final height = math.max(size.height, factor.isMobile ? 720.0 : 640.0);
    final headlineSize = factor.isMobile
        ? size.width * 0.155
        : math.min(size.width * 0.067, size.height * 0.13);
    final glassWidth = factor.isMobile
        ? size.width
        : math.min(size.width * 0.76, size.height * 1.22);

    return MouseRegion(
      onHover: (event) {
        final local = event.localPosition;
        _tilt.value = Offset(
          (local.dx / size.width - 0.5) * 2,
          (local.dy / height - 0.5) * 2,
        );
      },
      onExit: (_) => _tilt.value = Offset.zero,
      child: SizedBox(
        height: height,
        child: Stack(
          children: [
            Positioned.fill(
              child: LightRays(
                color: palette.ink.withValues(alpha: 0.05),
                angle: -0.38,
                rayCount: factor.isMobile ? 4 : 6,
              ),
            ),
            _glass(factor, glassWidth, height, size.width),
            _stickerLayer(factor, size),
            if (factor.isDesktop)
              Positioned(
                top: 96,
                left: factor.gutter,
                right: factor.gutter,
                child: RevealBox(
                  child: _IntroRow(factor: factor, palette: palette),
                ),
              ),
            Positioned(
              left: factor.gutter,
              right: factor.gutter,
              top: factor.isMobile ? 84 : null,
              bottom: factor.isMobile ? null : 96,
              child: RevealBox(
                child: _Headline(
                  size: headlineSize,
                  lines: SiteContent.heroHeadline.of(context).split('|'),
                  color: palette.ink,
                ),
              ),
            ),
            if (factor.isMobile)
              Positioned(
                left: factor.gutter,
                right: factor.gutter,
                bottom: 132,
                child: RevealBox(
                  delay: const Duration(milliseconds: 160),
                  child: Text(
                    SiteContent.heroBioShort.of(context),
                    style: Lz.mono(size: 14, height: 1.65, color: palette.ink),
                  ),
                ),
              ),
            Positioned(
              right: factor.isMobile ? factor.gutter : 64,
              bottom: factor.isMobile ? 62 : 160,
              child: RevealBox(
                delay: const Duration(milliseconds: 240),
                child: ActionButton(
                  label: SiteContent.heroCta.of(context),
                  minWidth: factor.isMobile ? 0 : 240,
                  onTap: widget.onExplore,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _glass(FormFactor factor, double width, double height, double viewportWidth) {
    final asset = context.isZh
        ? (factor.isMobile ? 'assets/glass/hello_zh_mobile.png' : 'assets/glass/hello_zh.png')
        : 'assets/glass/hello_en.png';
    final notifier = Listenable.merge([_tilt, _scroll]);
    return Positioned.fill(
      child: IgnorePointer(
        child: AnimatedBuilder(
          animation: notifier,
          builder: (context, child) {
            final progress = (_scroll.value / math.max(height, 1)).clamp(0.0, 1.2);
            final tilt = _tilt.value;
            final matrix = Matrix4.identity()
              ..setEntry(3, 2, 0.0016)
              ..rotateX(-tilt.dy * 0.05)
              ..rotateY(tilt.dx * 0.07);
            return Transform.translate(
              offset: Offset(tilt.dx * 6, progress * height * 0.18 - height * 0.03 + tilt.dy * 4),
              child: Transform.scale(
                scale: 1 + progress * 0.05 - tilt.dy.abs() * 0.01,
                child: Transform(
                  alignment: Alignment.center,
                  transform: matrix,
                  child: Center(
                    child: SizedBox(
                      width: width,
                      child: Image.asset(asset, filterQuality: FilterQuality.high),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  /// Floating stickers arranged around the glass greeting.
  Widget _stickerLayer(FormFactor factor, Size size) {
    final notifier = Listenable.merge([_tilt, _scroll]);
    // Scattered around the glass lettering, mirroring the reference hero.
    final layout = factor.isMobile
        ? const [
            _StickerSpec('assets/brand/stickers/rocket.webp', 0.19, 0.66, 0.075, -0.26, 220),
            _StickerSpec('assets/brand/stickers/bamboo.webp', 0.14, 0.06, 0.155, 0.10, 300),
            _StickerSpec('assets/brand/stickers/smiley.webp', 0.11, 0.11, 0.415, -0.05, 0),
            _StickerSpec('assets/brand/stickers/fox.webp', 0.17, 0.74, 0.47, 0.04, 120),
            _StickerSpec('assets/brand/stickers/spark.webp', 0.19, 0.72, 0.72, 0.10, 380),
          ]
        : const [
            _StickerSpec('assets/brand/stickers/rocket.webp', 0.062, 0.255, -0.02, -0.28, 240),
            _StickerSpec('assets/brand/stickers/code.webp', 0.048, 0.575, -0.015, 0.10, 120),
            _StickerSpec('assets/brand/stickers/spark.webp', 0.045, 0.300, 0.100, 0.12, 320),
            _StickerSpec('assets/brand/stickers/fox.webp', 0.060, 0.105, 0.535, 0.02, 140),
            _StickerSpec('assets/brand/stickers/smiley.webp', 0.045, 0.635, 0.575, -0.04, 0),
            _StickerSpec('assets/brand/stickers/bamboo.webp', 0.055, 0.615, 0.745, 0.10, 500),
            _StickerSpec('assets/brand/stickers/heart.webp', 0.062, 0.690, 0.900, 0.04, 440),
            _StickerSpec('assets/brand/stickers/ai.webp', 0.078, 0.845, 0.495, -0.05, 380),
          ];
    return Positioned.fill(
      child: IgnorePointer(
        child: AnimatedBuilder(
          animation: notifier,
          builder: (context, _) {
            final progress = (_scroll.value / math.max(size.height, 1)).clamp(0.0, 1.2);
            final tilt = _tilt.value;
            return Stack(
              children: [
                Positioned(
                  left: size.width * (factor.isMobile ? 0.52 : 0.655),
                  top: size.height * (factor.isMobile ? 0.215 : 0.145) - progress * size.height * 0.1,
                  child: Transform.translate(
                    offset: Offset(tilt.dx * -18, tilt.dy * -12),
                    child: RevealBox(
                      delay: const Duration(milliseconds: 380),
                      child: YearBadge(
                        size: size.width * (factor.isMobile ? 0.046 : 0.033),
                        rotation: 0.1,
                      ),
                    ),
                  ),
                ),
                for (final spec in layout)
                  Positioned(
                    left: size.width * spec.x,
                    top: size.height * spec.y - progress * size.height * 0.12,
                    child: Transform.translate(
                      offset: Offset(tilt.dx * 26, tilt.dy * 20),
                      child: Sticker(
                        asset: spec.asset,
                        size: size.width * spec.scale,
                        rotation: spec.rotation,
                        duration: Duration(milliseconds: spec.delay),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _StickerSpec {
  const _StickerSpec(this.asset, this.scale, this.x, this.y, this.rotation, this.delay);

  final String asset;
  final double scale;
  final double x;
  final double y;
  final double rotation;
  final int delay;
}

class _IntroRow extends StatelessWidget {
  const _IntroRow({required this.factor, required this.palette});

  final FormFactor factor;
  final LzPalette palette;

  @override
  Widget build(BuildContext context) {
    // Column widths follow the reference layout: 332 / 245 / 443 of 1328.
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 360,
          child: Text(
            SiteContent.heroRole.of(context),
            style: Lz.sans(
              size: 28,
              weight: FontWeight.w500,
              height: 1.25,
              letterSpacing: -0.6,
              color: palette.ink,
            ),
          ),
        ),
        const Spacer(flex: 84),
        Expanded(
          flex: 245,
          child: Text(
            SiteContent.heroPhilosophy.of(context),
            style: Lz.mono(size: 15, height: 1.6, color: palette.ink),
          ),
        ),
        const Spacer(flex: 166),
        Expanded(
          flex: 360,
          child: Text(
            SiteContent.heroBioShort.of(context),
            style: Lz.mono(size: 13, height: 1.55, color: palette.ink),
          ),
        ),
      ],
    );
  }
}

class _Headline extends StatelessWidget {
  const _Headline({required this.size, required this.lines, required this.color});

  final double size;
  final List<String> lines;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final line in lines)
          Text(
            line,
            style: Lz.sans(
              size: size,
              weight: FontWeight.w700,
              height: 1.08,
              letterSpacing: -size * 0.045,
              color: color,
            ),
          ),
      ],
    );
  }
}

/// The rotated studio badge that floats over the hero artwork.
class YearBadge extends StatelessWidget {
  const YearBadge({super.key, required this.size, required this.rotation});

  final double size;
  final double rotation;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotation,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: size * 0.26, vertical: size * 0.14),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF2F55C4), Color(0xFF3B63D8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(size * 0.3),
          border: Border.all(color: const Color(0x66FFFFFF), width: 2),
          boxShadow: const [
            BoxShadow(color: Color(0x33000000), blurRadius: 18, offset: Offset(0, 8)),
          ],
        ),
        child: Text(
          SiteContent.heroSticker.of(context),
          style: Lz.sans(
            size: size * 0.82,
            weight: FontWeight.w700,
            letterSpacing: size * 0.02,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
