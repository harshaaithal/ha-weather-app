import 'dart:math';
import 'package:flutter/material.dart';

/// Screen shake effect for intense weather conditions like blizzards.
/// Applies subtle random displacement to child widget.
class ScreenShake extends StatefulWidget {
  final Widget child;
  final double intensity; // 0.0 to 1.0
  final bool enabled;

  const ScreenShake({
    super.key,
    required this.child,
    this.intensity = 0.5,
    this.enabled = true,
  });

  @override
  State<ScreenShake> createState() => _ScreenShakeState();
}

class _ScreenShakeState extends State<ScreenShake>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Random _random = Random();
  double _offsetX = 0;
  double _offsetY = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 50),
    );

    _controller.addListener(_updateShake);
    if (widget.enabled) {
      _controller.repeat();
    }
  }

  void _updateShake() {
    if (!widget.enabled) return;

    setState(() {
      // Max shake of 3 pixels at full intensity
      final maxOffset = 3.0 * widget.intensity;
      _offsetX = (_random.nextDouble() - 0.5) * 2 * maxOffset;
      _offsetY = (_random.nextDouble() - 0.5) * 2 * maxOffset;
    });
  }

  @override
  void didUpdateWidget(ScreenShake oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.enabled && !oldWidget.enabled) {
      _controller.repeat();
    } else if (!widget.enabled && oldWidget.enabled) {
      _controller.stop();
      setState(() {
        _offsetX = 0;
        _offsetY = 0;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) {
      return widget.child;
    }

    return Transform.translate(
      offset: Offset(_offsetX, _offsetY),
      child: widget.child,
    );
  }
}
