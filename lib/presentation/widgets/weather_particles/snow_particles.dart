import 'dart:math';
import 'package:flutter/material.dart';

/// Snow particle system using CustomPainter for performance.
/// Creates soft, floating snowflakes with gentle drift and varying sizes.
class SnowParticles extends StatefulWidget {
  final int particleCount;
  final double intensity; // 0.0 to 1.0 (light snow to blizzard)
  final Color color;

  const SnowParticles({
    super.key,
    this.particleCount = 80,
    this.intensity = 0.5,
    this.color = Colors.white,
  });

  @override
  State<SnowParticles> createState() => _SnowParticlesState();
}

class _SnowParticlesState extends State<SnowParticles>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Snowflake> _flakes;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();

    _initFlakes();
  }

  void _initFlakes() {
    final count = (widget.particleCount * widget.intensity).round().clamp(15, 150);
    _flakes = List.generate(count, (_) => _createFlake());
  }

  Snowflake _createFlake({double? startY}) {
    return Snowflake(
      x: _random.nextDouble(),
      y: startY ?? _random.nextDouble(),
      speed: 0.05 + _random.nextDouble() * 0.15 * widget.intensity,
      size: 2 + _random.nextDouble() * 6,
      opacity: 0.4 + _random.nextDouble() * 0.5,
      drift: (_random.nextDouble() - 0.5) * 0.02,
      wobblePhase: _random.nextDouble() * pi * 2,
      wobbleSpeed: 1 + _random.nextDouble() * 2,
    );
  }

  @override
  void didUpdateWidget(SnowParticles oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.intensity != widget.intensity ||
        oldWidget.particleCount != widget.particleCount) {
      _initFlakes();
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

        for (var i = 0; i < _flakes.length; i++) {
          final flake = _flakes[i];
          // Gentle wobble side to side
          final wobble = sin(time * flake.wobbleSpeed + flake.wobblePhase) * 0.01;

          _flakes[i] = flake.copyWith(
            y: flake.y + flake.speed * 0.016,
            x: flake.x + flake.drift + wobble,
          );

          // Reset flakes that fall off screen
          if (_flakes[i].y > 1.1) {
            _flakes[i] = _createFlake(startY: -0.05);
          }
          // Wrap horizontally
          if (_flakes[i].x < -0.05) {
            _flakes[i] = _flakes[i].copyWith(x: 1.05);
          } else if (_flakes[i].x > 1.05) {
            _flakes[i] = _flakes[i].copyWith(x: -0.05);
          }
        }

        return CustomPaint(
          painter: SnowPainter(
            flakes: _flakes,
            color: widget.color,
          ),
          size: Size.infinite,
        );
      },
    );
  }
}

class Snowflake {
  final double x;
  final double y;
  final double speed;
  final double size;
  final double opacity;
  final double drift;
  final double wobblePhase;
  final double wobbleSpeed;

  const Snowflake({
    required this.x,
    required this.y,
    required this.speed,
    required this.size,
    required this.opacity,
    required this.drift,
    required this.wobblePhase,
    required this.wobbleSpeed,
  });

  Snowflake copyWith({
    double? x,
    double? y,
    double? speed,
    double? size,
    double? opacity,
    double? drift,
    double? wobblePhase,
    double? wobbleSpeed,
  }) {
    return Snowflake(
      x: x ?? this.x,
      y: y ?? this.y,
      speed: speed ?? this.speed,
      size: size ?? this.size,
      opacity: opacity ?? this.opacity,
      drift: drift ?? this.drift,
      wobblePhase: wobblePhase ?? this.wobblePhase,
      wobbleSpeed: wobbleSpeed ?? this.wobbleSpeed,
    );
  }
}

class SnowPainter extends CustomPainter {
  final List<Snowflake> flakes;
  final Color color;

  SnowPainter({
    required this.flakes,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final flake in flakes) {
      final paint = Paint()
        ..color = color.withValues(alpha: flake.opacity)
        ..style = PaintingStyle.fill;

      final x = flake.x * size.width;
      final y = flake.y * size.height;

      // Draw soft circular snowflake with blur effect
      canvas.drawCircle(
        Offset(x, y),
        flake.size,
        paint,
      );

      // Add subtle glow
      final glowPaint = Paint()
        ..color = color.withValues(alpha: flake.opacity * 0.3)
        ..style = PaintingStyle.fill
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);

      canvas.drawCircle(
        Offset(x, y),
        flake.size * 1.5,
        glowPaint,
      );
    }
  }

  @override
  bool shouldRepaint(SnowPainter oldDelegate) => true;
}
