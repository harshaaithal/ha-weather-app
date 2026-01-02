import 'dart:math';
import 'package:flutter/material.dart';

/// Star field effect for clear night skies.
/// Creates twinkling stars with varying brightness and sizes.
class StarField extends StatefulWidget {
  final int starCount;
  final Color starColor;
  final double twinkleIntensity; // 0.0 to 1.0

  const StarField({
    super.key,
    this.starCount = 50,
    this.starColor = Colors.white,
    this.twinkleIntensity = 0.6,
  });

  @override
  State<StarField> createState() => _StarFieldState();
}

class _StarFieldState extends State<StarField>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Star> _stars;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();

    _initStars();
  }

  void _initStars() {
    _stars = List.generate(widget.starCount, (_) => _createStar());
  }

  Star _createStar() {
    return Star(
      x: _random.nextDouble(),
      y: _random.nextDouble() * 0.6, // Stars in upper 60% of screen
      size: 1 + _random.nextDouble() * 2.5,
      baseOpacity: 0.4 + _random.nextDouble() * 0.6,
      twinkleSpeed: 0.5 + _random.nextDouble() * 2,
      twinklePhase: _random.nextDouble() * pi * 2,
      isBright: _random.nextDouble() < 0.15, // 15% chance of bright star
    );
  }

  @override
  void didUpdateWidget(StarField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.starCount != widget.starCount) {
      _initStars();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final time = DateTime.now().millisecondsSinceEpoch / 1000.0;

        return CustomPaint(
          painter: StarPainter(
            stars: _stars,
            color: widget.starColor,
            time: time,
            twinkleIntensity: widget.twinkleIntensity,
          ),
          size: Size.infinite,
        );
      },
    );
  }
}

class Star {
  final double x;
  final double y;
  final double size;
  final double baseOpacity;
  final double twinkleSpeed;
  final double twinklePhase;
  final bool isBright;

  const Star({
    required this.x,
    required this.y,
    required this.size,
    required this.baseOpacity,
    required this.twinkleSpeed,
    required this.twinklePhase,
    required this.isBright,
  });
}

class StarPainter extends CustomPainter {
  final List<Star> stars;
  final Color color;
  final double time;
  final double twinkleIntensity;

  StarPainter({
    required this.stars,
    required this.color,
    required this.time,
    required this.twinkleIntensity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final star in stars) {
      // Calculate twinkle effect
      final twinkle = sin(time * star.twinkleSpeed + star.twinklePhase);
      final twinkleAmount = twinkle * 0.3 * twinkleIntensity;
      final opacity = (star.baseOpacity + twinkleAmount).clamp(0.1, 1.0);

      final x = star.x * size.width;
      final y = star.y * size.height;

      if (star.isBright) {
        // Bright stars get a glow effect
        final glowPaint = Paint()
          ..color = color.withValues(alpha: opacity * 0.3)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
        canvas.drawCircle(Offset(x, y), star.size * 3, glowPaint);

        // Cross sparkle for bright stars
        final sparklePaint = Paint()
          ..color = color.withValues(alpha: opacity * 0.5)
          ..strokeWidth = 1
          ..strokeCap = StrokeCap.round;

        final sparkleSize = star.size * 4 * (0.8 + twinkle * 0.2);
        canvas.drawLine(
          Offset(x - sparkleSize, y),
          Offset(x + sparkleSize, y),
          sparklePaint,
        );
        canvas.drawLine(
          Offset(x, y - sparkleSize),
          Offset(x, y + sparkleSize),
          sparklePaint,
        );
      }

      // Core star
      final paint = Paint()
        ..color = color.withValues(alpha: opacity)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(x, y), star.size, paint);
    }
  }

  @override
  bool shouldRepaint(StarPainter oldDelegate) => true;
}
