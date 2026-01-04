import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Accessibility utilities for the weather app.
/// Handles reduced motion preferences, haptic feedback, and other a11y features.
class AccessibilityHelper {
  AccessibilityHelper._();

  /// Check if animations should be reduced based on system preferences.
  static bool shouldReduceMotion(BuildContext context) {
    return MediaQuery.of(context).disableAnimations;
  }

  /// Get animation duration respecting reduced motion preferences.
  /// Returns Duration.zero if reduced motion is enabled.
  static Duration getAnimationDuration(
    BuildContext context,
    Duration normalDuration,
  ) {
    return shouldReduceMotion(context) ? Duration.zero : normalDuration;
  }

  /// Get animation curve respecting reduced motion preferences.
  /// Returns Curves.linear if reduced motion is enabled for instant transitions.
  static Curve getAnimationCurve(BuildContext context, Curve normalCurve) {
    return shouldReduceMotion(context) ? Curves.linear : normalCurve;
  }
}

/// Haptic feedback utilities for weather events.
class WeatherHaptics {
  WeatherHaptics._();

  /// Light haptic for UI interactions (button taps, selections).
  static Future<void> light() async {
    await HapticFeedback.lightImpact();
  }

  /// Medium haptic for state changes (weather condition change).
  static Future<void> medium() async {
    await HapticFeedback.mediumImpact();
  }

  /// Heavy haptic for significant events (pull-to-refresh complete).
  static Future<void> heavy() async {
    await HapticFeedback.heavyImpact();
  }

  /// Selection haptic for toggles and picks.
  static Future<void> selection() async {
    await HapticFeedback.selectionClick();
  }

  /// Thunder rumble effect - series of haptics simulating thunder.
  static Future<void> thunderRumble() async {
    await HapticFeedback.heavyImpact();
    await Future.delayed(const Duration(milliseconds: 100));
    await HapticFeedback.mediumImpact();
    await Future.delayed(const Duration(milliseconds: 150));
    await HapticFeedback.lightImpact();
  }

  /// Refresh complete haptic feedback.
  static Future<void> refreshComplete() async {
    await HapticFeedback.mediumImpact();
  }

  /// Weather condition change haptic.
  static Future<void> conditionChange() async {
    await HapticFeedback.selectionClick();
  }
}
