import 'package:flutter/material.dart';

/// Frost overlay effect for extreme cold conditions.
/// Creates frost creep from screen corners with ice crystal patterns.
class FrostOverlay extends StatefulWidget {
  final double intensity; // 0.0 to 1.0
  final Color color;

  const FrostOverlay({
    super.key,
    this.intensity = 0.5,
    this.color = Colors.white,
  });

  @override
  State<FrostOverlay> createState() => _FrostOverlayState();
}

class _FrostOverlayState extends State<FrostOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return IgnorePointer(
          child: CustomPaint(
            painter: FrostPainter(
              progress: _animation.value,
              intensity: widget.intensity,
              color: widget.color,
            ),
            size: Size.infinite,
          ),
        );
      },
    );
  }
}

class FrostPainter extends CustomPainter {
  final double progress;
  final double intensity;
  final Color color;

  FrostPainter({
    required this.progress,
    required this.intensity,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cornerRadius = size.width * 0.3 * intensity * progress;

    // Top-left corner frost
    _drawCornerFrost(
      canvas,
      Offset.zero,
      cornerRadius,
      0,
    );

    // Top-right corner frost
    _drawCornerFrost(
      canvas,
      Offset(size.width, 0),
      cornerRadius,
      90,
    );

    // Bottom-left corner frost
    _drawCornerFrost(
      canvas,
      Offset(0, size.height),
      cornerRadius,
      270,
    );

    // Bottom-right corner frost
    _drawCornerFrost(
      canvas,
      Offset(size.width, size.height),
      cornerRadius,
      180,
    );
  }

  void _drawCornerFrost(
    Canvas canvas,
    Offset corner,
    double radius,
    double rotationDegrees,
  ) {
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          color.withValues(alpha: 0.4 * intensity),
          color.withValues(alpha: 0.2 * intensity),
          color.withValues(alpha: 0.05 * intensity),
          Colors.transparent,
        ],
        stops: const [0.0, 0.3, 0.6, 1.0],
      ).createShader(Rect.fromCircle(center: corner, radius: radius));

    canvas.drawCircle(corner, radius, paint);
  }

  @override
  bool shouldRepaint(FrostPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.intensity != intensity;
  }
}
