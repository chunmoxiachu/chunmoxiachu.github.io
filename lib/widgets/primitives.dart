import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../core/app_state.dart';
import '../core/theme.dart';

/// The faint 12 column guide grid that sits behind the whole page.
class GridOverlay extends StatelessWidget {
  const GridOverlay({super.key, this.columns = 12, this.color});

  final int columns;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: CustomPaint(
        painter: _GridPainter(
          columns: columns,
          color: color ?? context.palette.line,
          gutter: formFactorFor(MediaQuery.sizeOf(context).width).gutter,
        ),
        size: Size.infinite,
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  _GridPainter({required this.columns, required this.color, required this.gutter});

  final int columns;
  final Color color;
  final double gutter;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;
    final usable = size.width - gutter * 2;
    if (usable <= 0) return;
    final step = usable / columns;
    for (var i = 0; i <= columns; i++) {
      final x = gutter + step * i;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(_GridPainter old) =>
      old.color != color || old.columns != columns || old.gutter != gutter;
}

/// Thin horizontal rule used at section edges.
class HairLine extends StatelessWidget {
  const HairLine({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(height: 1, color: color ?? context.palette.line);
  }
}

/// Pill button with the reference site's hover behaviour (lime on hover).
class ActionButton extends StatefulWidget {
  const ActionButton({
    super.key,
    required this.label,
    this.onTap,
    this.trailing = '\u2197',
    this.minWidth,
    this.small = false,
  });

  final String label;
  final VoidCallback? onTap;
  final String trailing;
  final double? minWidth;
  final bool small;

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final bg = _hover ? Lz.accent : palette.buttonBg;
    final fg = _hover ? const Color(0xFF101410) : palette.buttonFg;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(0, _hover ? -2 : 0, 0),
          constraints: BoxConstraints(minWidth: widget.minWidth ?? 0, minHeight: widget.small ? 44 : 48),
          padding: EdgeInsets.symmetric(
            horizontal: widget.small ? 15 : 22,
            vertical: widget.small ? 11 : 13,
          ),
          color: bg,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  widget.label,
                  style: Lz.sans(
                    size: widget.small ? 12 : 15,
                    weight: FontWeight.w500,
                    color: fg,
                  ),
                ),
              ),
              SizedBox(width: widget.small ? 16 : 28),
              Text(
                widget.trailing,
                style: Lz.sans(size: widget.small ? 15 : 18, color: fg),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Inline text link with an arrow, underlined on hover.
class TextLink extends StatefulWidget {
  const TextLink({
    super.key,
    required this.label,
    this.onTap,
    this.arrow = '\u2192',
    this.color,
    this.size = 15,
  });

  final String label;
  final VoidCallback? onTap;
  final String arrow;
  final Color? color;
  final double size;

  @override
  State<TextLink> createState() => _TextLinkState();
}

class _TextLinkState extends State<TextLink> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? context.palette.ink;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.label,
              style: Lz.sans(size: widget.size, color: color).copyWith(
                decoration: _hover ? TextDecoration.underline : TextDecoration.none,
                decorationColor: color,
                decorationThickness: 1,
              ),
            ),
            const SizedBox(width: 6),
            Text(widget.arrow, style: Lz.sans(size: widget.size, color: color)),
          ],
        ),
      ),
    );
  }
}

/// Small uppercase mono label used above section headings.
class Eyebrow extends StatelessWidget {
  const Eyebrow(this.text, {super.key, this.color});

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: Lz.label(size: 12, color: color ?? context.palette.inkSoft),
    );
  }
}

/// Corporate identity card used where the reference site had a portrait.
class CompanyMark extends StatelessWidget {
  const CompanyMark({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFC0FE04),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: _CompanyMarkPainter(color: const Color(0xFF111111).withValues(alpha: 0.12)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CHUNMO\nXIACHU',
                    style: Lz.label(
                      size: 13,
                      height: 1.55,
                      letterSpacing: 0.08,
                      color: const Color(0xFF111111),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '春末夏初',
                    style: Lz.sans(
                      size: 42,
                      weight: FontWeight.w600,
                      height: 1.1,
                      letterSpacing: -1.6,
                      color: const Color(0xFF111111),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(width: 56, height: 2, color: const Color(0xFF111111)),
                  const SizedBox(height: 12),
                  Text(
                    'ENTERPRISE AI\nDELIVERY COMPANY',
                    style: Lz.mono(
                      size: 10,
                      height: 1.65,
                      letterSpacing: 0.08,
                      color: const Color(0xB3111111),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CompanyMarkPainter extends CustomPainter {
  const _CompanyMarkPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;
    for (var x = size.width * 0.2; x < size.width; x += size.width * 0.2) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (var y = size.height * 0.2; y < size.height; y += size.height * 0.2) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_CompanyMarkPainter old) => old.color != color;
}

/// Fades + lifts its child the first time it enters the viewport.
class RevealBox extends StatefulWidget {
  const RevealBox({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.offset = 28,
    this.threshold = 0.88,
  });

  final Widget child;
  final Duration delay;
  final double offset;
  final double threshold;

  @override
  State<RevealBox> createState() => _RevealBoxState();
}

class _RevealBoxState extends State<RevealBox> {
  ScrollPosition? _position;
  bool _shown = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final position = Scrollable.maybeOf(context)?.position;
    if (!identical(position, _position)) {
      _position?.removeListener(_evaluate);
      _position = position;
      _position?.addListener(_evaluate);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => _evaluate());
  }

  @override
  void dispose() {
    _position?.removeListener(_evaluate);
    super.dispose();
  }

  void _evaluate() {
    if (_shown || !mounted) return;
    final box = context.findRenderObject();
    if (box is! RenderBox || !box.hasSize) return;
    final viewport = MediaQuery.sizeOf(context).height;
    final top = box.localToGlobal(Offset.zero).dy;
    if (top < viewport * widget.threshold) {
      Future<void>.delayed(widget.delay, () {
        if (mounted) setState(() => _shown = true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _shown ? 1 : 0,
      duration: const Duration(milliseconds: 620),
      curve: Curves.easeOutCubic,
      child: AnimatedSlide(
        offset: _shown ? Offset.zero : Offset(0, widget.offset / 100),
        duration: const Duration(milliseconds: 620),
        curve: Curves.easeOutCubic,
        child: widget.child,
      ),
    );
  }
}

/// Diagonal sun rays used in the hero and the contact band.
class LightRays extends StatefulWidget {
  const LightRays({
    super.key,
    this.rayCount = 7,
    this.color = const Color(0x40FFFFFF),
    this.angle = -0.42,
    this.animate = true,
  });

  final int rayCount;
  final Color color;
  final double angle;
  final bool animate;

  @override
  State<LightRays> createState() => _LightRaysState();
}

class _LightRaysState extends State<LightRays> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 26),
  );

  @override
  void initState() {
    super.initState();
    if (widget.animate) _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) => CustomPaint(
          painter: _RayPainter(
            progress: _controller.value,
            rayCount: widget.rayCount,
            color: widget.color,
            angle: widget.angle,
          ),
          size: Size.infinite,
        ),
      ),
    );
  }
}

class _RayPainter extends CustomPainter {
  _RayPainter({
    required this.progress,
    required this.rayCount,
    required this.color,
    required this.angle,
  });

  final double progress;
  final int rayCount;
  final Color color;
  final double angle;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.translate(size.width * 0.5, size.height * 0.55);
    canvas.rotate(angle);
    final span = math.sqrt(size.width * size.width + size.height * size.height);
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [color.withValues(alpha: 0), color, color.withValues(alpha: 0)],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(Rect.fromLTWH(0, -span / 2, span, span));
    for (var i = 0; i < rayCount; i++) {
      final t = (i + 0.5) / rayCount;
      final y = (t - 0.5) * size.height * 1.9;
      final width = size.height * (0.04 + 0.05 * ((i * 37) % 7) / 7);
      final drift = math.sin((progress * math.pi * 2) + i) * size.width * 0.03;
      canvas.drawRect(
        Rect.fromLTWH(-span / 2 + drift, y, span, width),
        paint,
      );
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(_RayPainter old) =>
      old.progress != progress || old.color != color || old.rayCount != rayCount;
}

/// Radial burst of coloured beams used behind the "how I work" section.
class BeamBurst extends StatefulWidget {
  const BeamBurst({super.key, this.beamCount = 150});

  final int beamCount;

  @override
  State<BeamBurst> createState() => _BeamBurstState();
}

class _BeamBurstState extends State<BeamBurst> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 40),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) => CustomPaint(
          painter: _BeamPainter(progress: _controller.value, count: widget.beamCount),
          size: Size.infinite,
        ),
      ),
    );
  }
}

class _BeamPainter extends CustomPainter {
  _BeamPainter({required this.progress, required this.count});

  final double progress;
  final int count;

  static const _colors = <Color>[
    Color(0xFF7CE7C4),
    Color(0xFF6FA8F5),
    Color(0xFFB58CF0),
    Color(0xFF9BE8FF),
    Color(0xFFE0E4EA),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final rnd = math.Random(20261018);
    final center = Offset(size.width * 0.5, size.height * 0.52);
    final reach = math.sqrt(size.width * size.width + size.height * size.height);
    for (var i = 0; i < count; i++) {
      final angle = rnd.nextDouble() * math.pi * 2;
      final inner = reach * (0.06 + rnd.nextDouble() * 0.34);
      final length = reach * (0.06 + rnd.nextDouble() * 0.3);
      final color = _colors[(rnd.nextDouble() * _colors.length).floor()];
      final pulse = 0.55 + 0.45 * math.sin(progress * math.pi * 2 + i * 0.7);
      final paint = Paint()
        ..color = color.withValues(alpha: 0.08 + 0.5 * pulse * rnd.nextDouble())
        ..strokeWidth = 1.2 + rnd.nextDouble() * 2.6
        ..strokeCap = StrokeCap.round;
      canvas.drawLine(
        center + Offset(math.cos(angle), math.sin(angle)) * inner,
        center + Offset(math.cos(angle), math.sin(angle)) * (inner + length),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_BeamPainter old) => old.progress != progress || old.count != count;
}

/// Floating glass sticker used across the hero and contact sections.
class Sticker extends StatelessWidget {
  const Sticker({
    super.key,
    required this.asset,
    required this.size,
    this.rotation = 0,
    this.duration = Duration.zero,
    this.parallax = Offset.zero,
  });

  final String asset;
  final double size;
  final double rotation;
  final Duration duration;
  final Offset parallax;

  @override
  Widget build(BuildContext context) {
    Widget image = Image.asset(asset, width: size, filterQuality: FilterQuality.high);
    if (rotation != 0) {
      image = Transform.rotate(angle: rotation, child: image);
    }
    return RevealBox(
      delay: duration,
      offset: 40,
      threshold: 1.05,
      child: Transform.translate(offset: parallax, child: image),
    );
  }
}
