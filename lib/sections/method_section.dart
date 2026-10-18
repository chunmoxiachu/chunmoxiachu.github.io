import 'package:flutter/material.dart';

import '../core/app_state.dart';
import '../core/content.dart';
import '../core/theme.dart';
import '../widgets/primitives.dart';

/// Dark band with the radial beam burst and four floating glass plaques.
class MethodSection extends StatelessWidget {
  const MethodSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final factor = formFactorFor(size.width);
    final isMobile = factor.isMobile;
    final height = isMobile ? 880.0 : 760.0;

    return Container(
      color: context.palette.darkStage,
      child: SizedBox(
        height: height,
        child: Stack(
          children: [
            const Positioned.fill(child: BeamBurst()),
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: factor.gutter),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(top: isMobile ? 48 : 72),
                        child: RevealBox(
                          child: Text(
                            SiteContent.methodTitleA.of(context),
                            style: Lz.sans(
                              size: isMobile ? 30 : 42,
                              weight: FontWeight.w600,
                              height: 1.2,
                              letterSpacing: -1.2,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: RevealBox(
                        delay: const Duration(milliseconds: 120),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              SiteContent.methodTitleB.of(context),
                              textAlign: TextAlign.center,
                              style: Lz.sans(
                                size: isMobile ? 34 : 52,
                                weight: FontWeight.w600,
                                height: 1.16,
                                letterSpacing: -1.6,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 18),
                            Text(
                              SiteContent.methodStepsLabel.of(context),
                              style: Lz.label(size: 11, color: const Color(0x99FFFFFF)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    _plaque(
                      context,
                      step: SiteContent.methodSteps[0],
                      alignment: Alignment.topLeft,
                      top: isMobile ? 168 : 176,
                      delay: 60,
                    ),
                    _plaque(
                      context,
                      step: SiteContent.methodSteps[1],
                      alignment: Alignment.topRight,
                      top: isMobile ? 196 : 208,
                      delay: 140,
                    ),
                    _plaque(
                      context,
                      step: SiteContent.methodSteps[2],
                      alignment: Alignment.bottomLeft,
                      bottom: isMobile ? 208 : 150,
                      delay: 220,
                    ),
                    _plaque(
                      context,
                      step: SiteContent.methodSteps[3],
                      alignment: Alignment.bottomRight,
                      bottom: isMobile ? 150 : 176,
                      delay: 300,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _plaque(
    BuildContext context, {
    required StepItem step,
    required Alignment alignment,
    double? top,
    double? bottom,
    required int delay,
  }) {
    final factor = formFactorFor(MediaQuery.sizeOf(context).width);
    final width = factor.isMobile ? 176.0 : 250.0;
    return Positioned(
      top: top,
      bottom: bottom,
      left: alignment == Alignment.topLeft || alignment == Alignment.bottomLeft ? 0 : null,
      right: alignment == Alignment.topRight || alignment == Alignment.bottomRight ? 0 : null,
      child: RevealBox(
        delay: Duration(milliseconds: delay),
        child: Transform.rotate(
          angle: (alignment == Alignment.topLeft || alignment == Alignment.bottomRight) ? -0.05 : 0.05,
          child: Container(
            width: width,
            padding: EdgeInsets.symmetric(horizontal: factor.isMobile ? 14 : 20, vertical: factor.isMobile ? 16 : 22),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xCC2B63D8), Color(0xCC1B3FA8)],
              ),
              border: Border.all(color: const Color(0x66FFFFFF), width: 1.2),
              boxShadow: const [
                BoxShadow(color: Color(0x66000000), blurRadius: 26, offset: Offset(0, 14)),
                BoxShadow(color: Color(0x33A9CBFF), blurRadius: 30, spreadRadius: -12),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${step.index}  ${step.tag.of(context)}',
                  style: Lz.label(
                    size: factor.isMobile ? 10 : 11,
                    color: const Color(0xCCBFD7FF),
                  ),
                ),
                SizedBox(height: factor.isMobile ? 10 : 14),
                Text(
                  step.title.of(context),
                  style: Lz.sans(
                    size: factor.isMobile ? 17 : 21,
                    weight: FontWeight.w600,
                    letterSpacing: -0.4,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  step.sub.of(context),
                  style: Lz.sans(
                    size: factor.isMobile ? 13 : 15,
                    color: const Color(0xCCE4EEFF),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
