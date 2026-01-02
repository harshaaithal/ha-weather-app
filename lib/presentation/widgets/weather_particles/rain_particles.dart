import 'dart:math';
import 'package:flutter/material.dart';

/// Rain particle system using CustomPainter for performance.
/// Creates white streaks at 45° angle with varying speeds and opacity.
class RainParticles extends StatefulWidget {
  final int particleCount;
  final double intensity; // 0.0 to 1.0 (light drizzle to heavy rain)
  final Color color;

  const RainParticles({
    super.key,
    this.particleCount = 100,
    this.intensity = 0.5,
    this.color = Colors.white,
  });

  @override
  State<RainParticles> createState() => _RainParticlesState();
}

class _RainParticlesState extends State<RainParticles>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<RainDrop> _drops;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();

    _initDrops();
  }

  void _initDrops() {
    final count = (widget.particleCount * widget.intensity).round().clamp(20, 200);
    _drops = List.generate(count, (_) => _createDrop());
  }

  RainDrop _createDrop({double? startY}) {
    return RainDrop(
      x: _random.nextDouble(),
      y: startY ?? _random.nextDouble(),
      speed: 0.3 + _random.nextDouble() * 0.4 * widget.intensity,
      length: 10 + _random.nextDouble() * 20 * widget.intensity,
      opacity: 0.3 + _random.nextDouble() * 0.4,
      thickness: 1 + _random.nextDouble() * 1.5,
    );
  }

  @override
  void didUpdateWidget(RainParticles oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.intensity != widget.intensity ||
        oldWidget.particleCount != widget.particleCount) {
      _initDrops();
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
        // Update drop positions
        for (var i = 0; i < _drops.length; i++) {
          _drops[i] = _drops[i].copyWith(
            y: _drops[i].y + _drops[i].speed * 0.016, // ~60fps
            x: _drops[i].x + _drops[i].speed * 0.008, // 45° angle drift
          );

          // Reset drops that fall off screen
          if (_drops[i].y > 1.1 || _drops[i].x > 1.1) {
            _drops[i] = _createDrop(startY: -0.1);
          }
        }

        return CustomPaint(
          painter: RainPainter(
            drops: _drops,
            color: widget.color,
          ),
          size: Size.infinite,
        );
      },
    );
  }
}

class RainDrop {
  final double x;
  final double y;
  final double speed;
  final double length;
  final double opacity;
  final double thickness;

  const RainDrop({
    required this.x,
    required this.y,
    required this.speed,
    required this.length,
    required this.opacity,
    required this.thickness,
  });

  RainDrop copyWith({
    double? x,
    double? y,
    double? speed,
    double? length,
    double? opacity,
    double? thickness,
  }) {
    return RainDrop(
      x: x ?? this.x,
      y: y ?? this.y,
      speed: speed ?? this.speed,
      length: length ?? this.length,
      opacity: opacity ?? this.opacity,
      thickness: thickness ?? this.thickness,
    );
  }
}

class RainPainter extends CustomPainter {
  final List<RainDrop> drops;
  final Color color;

  RainPainter({
    required this.drops,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final drop in drops) {
      final paint = Paint()
        ..color = color.withValues(alpha: drop.opacity)
        ..strokeWidth = drop.thickness
        ..strokeCap = StrokeCap.round;

      final startX = drop.x * size.width;
      final startY = drop.y * size.height;
      // 45° angle for rain
      final endX = startX + drop.length * 0.7;
      final endY = startY + drop.length;

      canvas.drawLine(
        Offset(startX, startY),
        Offset(endX, endY),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(RainPainter oldDelegate) => true;
}
