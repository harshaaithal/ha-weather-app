import 'dart:math';
import 'package:flutter/material.dart';

/// Lightning flash effect for thunderstorm weather.
/// Creates random screen flashes with varying intensity.
class LightningEffect extends StatefulWidget {
  final double frequency; // Flashes per minute (0-10)
  final Color flashColor;

  const LightningEffect({
    super.key,
    this.frequency = 3.0,
    this.flashColor = Colors.white,
  });

  @override
  State<LightningEffect> createState() => _LightningEffectState();
}

class _LightningEffectState extends State<LightningEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _flashAnimation;
  final Random _random = Random();
  bool _isFlashing = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );

    _flashAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 0.8)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 20,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 0.8, end: 0.2)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 0.2, end: 0.6)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 20,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 0.6, end: 0.0)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 30,
      ),
    ]).animate(_controller);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() => _isFlashing = false);
        _scheduleNextFlash();
      }
    });

    _scheduleNextFlash();
  }

  void _scheduleNextFlash() {
    if (widget.frequency <= 0) return;

    // Calculate random delay based on frequency
    // frequency = flashes per minute
    final avgDelay = 60000 / widget.frequency; // ms between flashes
    final variance = avgDelay * 0.5;
    final delay = avgDelay + (_random.nextDouble() - 0.5) * variance * 2;

    Future.delayed(Duration(milliseconds: delay.round()), () {
      if (mounted && !_isFlashing) {
        _triggerFlash();
      }
    });
  }

  void _triggerFlash() {
    setState(() => _isFlashing = true);
    _controller.forward(from: 0);

    // Occasionally do a double flash
    if (_random.nextDouble() < 0.3) {
      Future.delayed(const Duration(milliseconds: 200), () {
        if (mounted) {
          _controller.forward(from: 0);
        }
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
    return AnimatedBuilder(
      animation: _flashAnimation,
      builder: (context, child) {
        if (!_isFlashing && _flashAnimation.value == 0) {
          return const SizedBox.shrink();
        }

        return Positioned.fill(
          child: IgnorePointer(
            child: Container(
              color: widget.flashColor.withValues(alpha: _flashAnimation.value * 0.4),
            ),
          ),
        );
      },
    );
  }
}
