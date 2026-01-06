import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Custom line icons for weather stats.
/// All icons use 1.5px stroke as per STYLE_GUIDE.md.
class WeatherIcons {
  WeatherIcons._();

  /// Thermometer icon for "Feels like" temperature.
  static Widget thermometer({double size = 18, required Color color}) {
    return CustomPaint(
      size: Size(size, size),
      painter: _ThermometerPainter(color: color),
    );
  }

  /// Wind icon showing flowing air.
  static Widget wind({double size = 18, required Color color}) {
    return CustomPaint(
      size: Size(size, size),
      painter: _WindPainter(color: color),
    );
  }

  /// Water drop icon for precipitation.
  static Widget waterDrop({double size = 18, required Color color}) {
    return CustomPaint(
      size: Size(size, size),
      painter: _WaterDropPainter(color: color),
    );
  }

  /// Humidity icon (water drop with percentage implication).
  static Widget humidity({double size = 18, required Color color}) {
    return CustomPaint(
      size: Size(size, size),
      painter: _HumidityPainter(color: color),
    );
  }

  /// Location pin icon.
  static Widget locationPin({double size = 20, required Color color}) {
    return CustomPaint(
      size: Size(size, size),
      painter: _LocationPinPainter(color: color),
    );
  }

  /// Search/magnifying glass icon.
  static Widget search({double size = 24, required Color color}) {
    return CustomPaint(
      size: Size(size, size),
      painter: _SearchPainter(color: color),
    );
  }

  /// Back arrow icon.
  static Widget arrowBack({double size = 24, required Color color}) {
    return CustomPaint(
      size: Size(size, size),
      painter: _ArrowBackPainter(color: color),
    );
  }

  /// Close/X icon.
  static Widget close({double size = 24, required Color color}) {
    return CustomPaint(
      size: Size(size, size),
      painter: _ClosePainter(color: color),
    );
  }

  /// Chevron right icon.
  static Widget chevronRight({double size = 24, required Color color}) {
    return CustomPaint(
      size: Size(size, size),
      painter: _ChevronRightPainter(color: color),
    );
  }

  /// My location/GPS icon.
  static Widget myLocation({double size = 20, required Color color}) {
    return CustomPaint(
      size: Size(size, size),
      painter: _MyLocationPainter(color: color),
    );
  }

  /// City/building icon.
  static Widget city({double size = 24, required Color color}) {
    return CustomPaint(
      size: Size(size, size),
      painter: _CityPainter(color: color),
    );
  }

  /// Cloud off/error icon.
  static Widget cloudOff({double size = 64, required Color color}) {
    return CustomPaint(
      size: Size(size, size),
      painter: _CloudOffPainter(color: color),
    );
  }

  /// Refresh icon.
  static Widget refresh({double size = 24, required Color color}) {
    return CustomPaint(
      size: Size(size, size),
      painter: _RefreshPainter(color: color),
    );
  }

  /// Error/warning circle icon.
  static Widget errorOutline({double size = 48, required Color color}) {
    return CustomPaint(
      size: Size(size, size),
      painter: _ErrorOutlinePainter(color: color),
    );
  }

  /// Heart outline icon for favorites.
  static Widget heartOutline({double size = 24, required Color color}) {
    return CustomPaint(
      size: Size(size, size),
      painter: _HeartOutlinePainter(color: color),
    );
  }

  /// Heart filled icon for favorites.
  static Widget heartFilled({double size = 24, required Color color}) {
    return CustomPaint(
      size: Size(size, size),
      painter: _HeartFilledPainter(color: color),
    );
  }

  /// Grid icon for favorites list.
  static Widget grid({double size = 24, required Color color}) {
    return CustomPaint(
      size: Size(size, size),
      painter: _GridPainter(color: color),
    );
  }

  // ============ Weather Condition Icons ============

  /// Sun icon for clear weather.
  static Widget sun({double size = 24, required Color color}) {
    return CustomPaint(
      size: Size(size, size),
      painter: _SunPainter(color: color),
    );
  }

  /// Cloud icon for cloudy weather.
  static Widget cloud({double size = 24, required Color color}) {
    return CustomPaint(
      size: Size(size, size),
      painter: _CloudPainter(color: color),
    );
  }

  /// Fog icon for foggy/misty weather.
  static Widget fog({double size = 24, required Color color}) {
    return CustomPaint(
      size: Size(size, size),
      painter: _FogPainter(color: color),
    );
  }

  /// Snowflake icon for snow weather.
  static Widget snowflake({double size = 24, required Color color}) {
    return CustomPaint(
      size: Size(size, size),
      painter: _SnowflakePainter(color: color),
    );
  }

  /// Rain icon for rainy weather.
  static Widget rain({double size = 24, required Color color}) {
    return CustomPaint(
      size: Size(size, size),
      painter: _RainPainter(color: color),
    );
  }

  /// Thunderstorm icon.
  static Widget thunderstorm({double size = 24, required Color color}) {
    return CustomPaint(
      size: Size(size, size),
      painter: _ThunderstormPainter(color: color),
    );
  }

  /// Moon icon for clear night.
  static Widget moon({double size = 24, required Color color}) {
    return CustomPaint(
      size: Size(size, size),
      painter: _MoonPainter(color: color),
    );
  }

  /// Partly cloudy icon (cloud with sun/moon peeking).
  static Widget partlyCloudy({double size = 24, required Color color, bool isDay = true}) {
    return CustomPaint(
      size: Size(size, size),
      painter: _PartlyCloudyPainter(color: color, isDay: isDay),
    );
  }

  /// Returns appropriate weather icon widget based on WMO weather code.
  /// If [isDay] is provided, shows day/night variants for clear and partly cloudy.
  static Widget fromWeatherCode(int code, {double size = 24, required Color color, bool? isDay}) {
    if (code == 0) {
      // Clear sky
      if (isDay == false) {
        return moon(size: size, color: color);
      }
      return sun(size: size, color: color);
    } else if (code <= 3) {
      // Partly cloudy (1-3)
      if (isDay != null) {
        return partlyCloudy(size: size, color: color, isDay: isDay);
      }
      return cloud(size: size, color: color);
    } else if (code <= 48) {
      return fog(size: size, color: color);
    } else if (code <= 67) {
      return rain(size: size, color: color);
    } else if (code <= 77) {
      return snowflake(size: size, color: color);
    } else if (code <= 82) {
      return rain(size: size, color: color);
    } else if (code <= 86) {
      return snowflake(size: size, color: color);
    } else {
      return thunderstorm(size: size, color: color);
    }
  }
}

/// Base painter with common stroke settings.
abstract class _BaseIconPainter extends CustomPainter {
  final Color color;
  static const double strokeWidth = 1.5;

  _BaseIconPainter({required this.color});

  Paint get strokePaint => Paint()
    ..color = color
    ..style = PaintingStyle.stroke
    ..strokeWidth = strokeWidth
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round;

  Paint get fillPaint => Paint()
    ..color = color
    ..style = PaintingStyle.fill;

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ThermometerPainter extends _BaseIconPainter {
  _ThermometerPainter({required super.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = strokePaint;
    final w = size.width;
    final h = size.height;

    // Thermometer body (tall rectangle with rounded top)
    final bodyPath = Path();
    final bodyWidth = w * 0.3;
    final bodyLeft = (w - bodyWidth) / 2;
    final bodyTop = h * 0.1;
    final bodyBottom = h * 0.6;

    bodyPath.moveTo(bodyLeft + bodyWidth / 2, bodyTop);
    bodyPath.lineTo(bodyLeft + bodyWidth, bodyTop + bodyWidth / 2);
    bodyPath.lineTo(bodyLeft + bodyWidth, bodyBottom);
    bodyPath.lineTo(bodyLeft, bodyBottom);
    bodyPath.lineTo(bodyLeft, bodyTop + bodyWidth / 2);
    bodyPath.close();

    // Bulb at bottom (circle)
    final bulbRadius = w * 0.25;
    final bulbCenter = Offset(w / 2, h * 0.75);

    canvas.drawCircle(bulbCenter, bulbRadius, paint);

    // Stem
    canvas.drawLine(
      Offset(w / 2, bodyTop + bodyWidth / 2),
      Offset(w / 2, h * 0.6),
      paint,
    );

    // Temperature marks
    for (var i = 0; i < 3; i++) {
      final y = bodyTop + bodyWidth / 2 + (i + 1) * (bodyBottom - bodyTop - bodyWidth / 2) / 4;
      canvas.drawLine(
        Offset(bodyLeft + bodyWidth, y),
        Offset(bodyLeft + bodyWidth + w * 0.1, y),
        paint,
      );
    }
  }
}

class _WindPainter extends _BaseIconPainter {
  _WindPainter({required super.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = strokePaint;
    final w = size.width;
    final h = size.height;

    // Three curved wind lines
    // Top line
    final path1 = Path();
    path1.moveTo(w * 0.1, h * 0.3);
    path1.quadraticBezierTo(w * 0.5, h * 0.3, w * 0.7, h * 0.2);
    path1.quadraticBezierTo(w * 0.85, h * 0.15, w * 0.85, h * 0.25);
    path1.quadraticBezierTo(w * 0.85, h * 0.35, w * 0.7, h * 0.35);
    canvas.drawPath(path1, paint);

    // Middle line (longer)
    final path2 = Path();
    path2.moveTo(w * 0.05, h * 0.5);
    path2.lineTo(w * 0.75, h * 0.5);
    path2.quadraticBezierTo(w * 0.95, h * 0.5, w * 0.95, h * 0.6);
    path2.quadraticBezierTo(w * 0.95, h * 0.7, w * 0.75, h * 0.7);
    canvas.drawPath(path2, paint);

    // Bottom line
    final path3 = Path();
    path3.moveTo(w * 0.2, h * 0.7);
    path3.lineTo(w * 0.5, h * 0.7);
    canvas.drawPath(path3, paint);
  }
}

class _WaterDropPainter extends _BaseIconPainter {
  _WaterDropPainter({required super.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = strokePaint;
    final w = size.width;
    final h = size.height;

    // Water drop shape
    final path = Path();
    path.moveTo(w / 2, h * 0.1);
    path.quadraticBezierTo(w * 0.9, h * 0.5, w * 0.8, h * 0.7);
    path.quadraticBezierTo(w * 0.7, h * 0.9, w / 2, h * 0.9);
    path.quadraticBezierTo(w * 0.3, h * 0.9, w * 0.2, h * 0.7);
    path.quadraticBezierTo(w * 0.1, h * 0.5, w / 2, h * 0.1);

    canvas.drawPath(path, paint);
  }
}

class _HumidityPainter extends _BaseIconPainter {
  _HumidityPainter({required super.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = strokePaint;
    final w = size.width;
    final h = size.height;

    // Two overlapping water drops for humidity
    // Main drop
    final path1 = Path();
    path1.moveTo(w * 0.4, h * 0.15);
    path1.quadraticBezierTo(w * 0.75, h * 0.45, w * 0.65, h * 0.6);
    path1.quadraticBezierTo(w * 0.55, h * 0.75, w * 0.4, h * 0.75);
    path1.quadraticBezierTo(w * 0.25, h * 0.75, w * 0.15, h * 0.6);
    path1.quadraticBezierTo(w * 0.05, h * 0.45, w * 0.4, h * 0.15);
    canvas.drawPath(path1, paint);

    // Smaller drop
    final path2 = Path();
    path2.moveTo(w * 0.7, h * 0.4);
    path2.quadraticBezierTo(w * 0.9, h * 0.6, w * 0.85, h * 0.7);
    path2.quadraticBezierTo(w * 0.8, h * 0.8, w * 0.7, h * 0.8);
    path2.quadraticBezierTo(w * 0.6, h * 0.8, w * 0.55, h * 0.7);
    path2.quadraticBezierTo(w * 0.5, h * 0.6, w * 0.7, h * 0.4);
    canvas.drawPath(path2, paint);
  }
}

class _LocationPinPainter extends _BaseIconPainter {
  _LocationPinPainter({required super.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = strokePaint;
    final w = size.width;
    final h = size.height;

    // Pin outline
    final path = Path();
    path.moveTo(w / 2, h * 0.9);
    path.lineTo(w * 0.25, h * 0.5);
    path.arcToPoint(
      Offset(w * 0.75, h * 0.5),
      radius: Radius.circular(w * 0.3),
      clockwise: true,
    );
    path.close();

    canvas.drawPath(path, paint);

    // Inner circle
    canvas.drawCircle(Offset(w / 2, h * 0.4), w * 0.12, paint);
  }
}

class _SearchPainter extends _BaseIconPainter {
  _SearchPainter({required super.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = strokePaint;
    final w = size.width;
    final h = size.height;

    // Circle
    canvas.drawCircle(Offset(w * 0.4, h * 0.4), w * 0.3, paint);

    // Handle
    canvas.drawLine(
      Offset(w * 0.6, h * 0.6),
      Offset(w * 0.85, h * 0.85),
      paint,
    );
  }
}

class _ArrowBackPainter extends _BaseIconPainter {
  _ArrowBackPainter({required super.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = strokePaint;
    final w = size.width;
    final h = size.height;

    // Arrow
    final path = Path();
    path.moveTo(w * 0.6, h * 0.2);
    path.lineTo(w * 0.25, h * 0.5);
    path.lineTo(w * 0.6, h * 0.8);

    canvas.drawPath(path, paint);

    // Line
    canvas.drawLine(
      Offset(w * 0.25, h * 0.5),
      Offset(w * 0.85, h * 0.5),
      paint,
    );
  }
}

class _ClosePainter extends _BaseIconPainter {
  _ClosePainter({required super.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = strokePaint;
    final w = size.width;
    final h = size.height;

    // X shape
    canvas.drawLine(Offset(w * 0.25, h * 0.25), Offset(w * 0.75, h * 0.75), paint);
    canvas.drawLine(Offset(w * 0.75, h * 0.25), Offset(w * 0.25, h * 0.75), paint);
  }
}

class _ChevronRightPainter extends _BaseIconPainter {
  _ChevronRightPainter({required super.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = strokePaint;
    final w = size.width;
    final h = size.height;

    final path = Path();
    path.moveTo(w * 0.35, h * 0.2);
    path.lineTo(w * 0.65, h * 0.5);
    path.lineTo(w * 0.35, h * 0.8);

    canvas.drawPath(path, paint);
  }
}

class _MyLocationPainter extends _BaseIconPainter {
  _MyLocationPainter({required super.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = strokePaint;
    final w = size.width;
    final h = size.height;
    final center = Offset(w / 2, h / 2);

    // Outer circle
    canvas.drawCircle(center, w * 0.35, paint);

    // Inner circle (dot)
    canvas.drawCircle(center, w * 0.12, paint);

    // Crosshairs
    canvas.drawLine(Offset(w / 2, h * 0.05), Offset(w / 2, h * 0.2), paint);
    canvas.drawLine(Offset(w / 2, h * 0.8), Offset(w / 2, h * 0.95), paint);
    canvas.drawLine(Offset(w * 0.05, h / 2), Offset(w * 0.2, h / 2), paint);
    canvas.drawLine(Offset(w * 0.8, h / 2), Offset(w * 0.95, h / 2), paint);
  }
}

class _CityPainter extends _BaseIconPainter {
  _CityPainter({required super.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = strokePaint;
    final w = size.width;
    final h = size.height;

    // Buildings silhouette
    final path = Path();

    // Left building
    path.moveTo(w * 0.1, h * 0.9);
    path.lineTo(w * 0.1, h * 0.5);
    path.lineTo(w * 0.3, h * 0.5);
    path.lineTo(w * 0.3, h * 0.9);

    // Middle tall building
    path.moveTo(w * 0.35, h * 0.9);
    path.lineTo(w * 0.35, h * 0.2);
    path.lineTo(w * 0.5, h * 0.15);
    path.lineTo(w * 0.65, h * 0.2);
    path.lineTo(w * 0.65, h * 0.9);

    // Right building
    path.moveTo(w * 0.7, h * 0.9);
    path.lineTo(w * 0.7, h * 0.4);
    path.lineTo(w * 0.9, h * 0.4);
    path.lineTo(w * 0.9, h * 0.9);

    // Ground line
    path.moveTo(w * 0.05, h * 0.9);
    path.lineTo(w * 0.95, h * 0.9);

    canvas.drawPath(path, paint);
  }
}

class _CloudOffPainter extends _BaseIconPainter {
  _CloudOffPainter({required super.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = strokePaint..strokeWidth = 2.0;
    final w = size.width;
    final h = size.height;

    // Cloud shape
    final cloudPath = Path();
    cloudPath.moveTo(w * 0.25, h * 0.65);
    cloudPath.quadraticBezierTo(w * 0.1, h * 0.65, w * 0.1, h * 0.5);
    cloudPath.quadraticBezierTo(w * 0.1, h * 0.35, w * 0.25, h * 0.35);
    cloudPath.quadraticBezierTo(w * 0.3, h * 0.2, w * 0.5, h * 0.2);
    cloudPath.quadraticBezierTo(w * 0.75, h * 0.2, w * 0.8, h * 0.35);
    cloudPath.quadraticBezierTo(w * 0.95, h * 0.35, w * 0.95, h * 0.5);
    cloudPath.quadraticBezierTo(w * 0.95, h * 0.65, w * 0.75, h * 0.65);
    cloudPath.close();

    canvas.drawPath(cloudPath, paint);

    // Slash through
    canvas.drawLine(
      Offset(w * 0.2, h * 0.8),
      Offset(w * 0.8, h * 0.2),
      paint,
    );
  }
}

class _RefreshPainter extends _BaseIconPainter {
  _RefreshPainter({required super.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = strokePaint;
    final w = size.width;
    final h = size.height;
    final center = Offset(w / 2, h / 2);
    final radius = w * 0.35;

    // Arc
    final rect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(rect, -math.pi / 2, math.pi * 1.5, false, paint);

    // Arrow head
    final arrowPath = Path();
    arrowPath.moveTo(w * 0.5, h * 0.15);
    arrowPath.lineTo(w * 0.65, h * 0.25);
    arrowPath.moveTo(w * 0.5, h * 0.15);
    arrowPath.lineTo(w * 0.5, h * 0.35);

    canvas.drawPath(arrowPath, paint);
  }
}

class _ErrorOutlinePainter extends _BaseIconPainter {
  _ErrorOutlinePainter({required super.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = strokePaint..strokeWidth = 2.0;
    final w = size.width;
    final h = size.height;
    final center = Offset(w / 2, h / 2);

    // Circle
    canvas.drawCircle(center, w * 0.4, paint);

    // Exclamation mark
    // Vertical line
    canvas.drawLine(
      Offset(w / 2, h * 0.25),
      Offset(w / 2, h * 0.55),
      paint,
    );

    // Dot
    canvas.drawCircle(Offset(w / 2, h * 0.7), w * 0.04, paint..style = PaintingStyle.fill);
  }
}

// ============ Weather Condition Icon Painters ============

class _SunPainter extends _BaseIconPainter {
  _SunPainter({required super.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = strokePaint;
    final w = size.width;
    final h = size.height;
    final center = Offset(w / 2, h / 2);

    // Center circle
    canvas.drawCircle(center, w * 0.22, paint);

    // Sun rays
    const rayCount = 8;
    for (var i = 0; i < rayCount; i++) {
      final angle = (i * math.pi * 2) / rayCount;
      final innerRadius = w * 0.32;
      final outerRadius = w * 0.45;

      final start = Offset(
        center.dx + innerRadius * math.cos(angle),
        center.dy + innerRadius * math.sin(angle),
      );
      final end = Offset(
        center.dx + outerRadius * math.cos(angle),
        center.dy + outerRadius * math.sin(angle),
      );

      canvas.drawLine(start, end, paint);
    }
  }
}

class _CloudPainter extends _BaseIconPainter {
  _CloudPainter({required super.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = strokePaint;
    final w = size.width;
    final h = size.height;

    final path = Path();
    path.moveTo(w * 0.2, h * 0.65);
    path.quadraticBezierTo(w * 0.05, h * 0.65, w * 0.1, h * 0.5);
    path.quadraticBezierTo(w * 0.1, h * 0.35, w * 0.25, h * 0.35);
    path.quadraticBezierTo(w * 0.3, h * 0.2, w * 0.5, h * 0.2);
    path.quadraticBezierTo(w * 0.75, h * 0.2, w * 0.85, h * 0.35);
    path.quadraticBezierTo(w * 0.95, h * 0.4, w * 0.9, h * 0.55);
    path.quadraticBezierTo(w * 0.9, h * 0.65, w * 0.75, h * 0.65);
    path.lineTo(w * 0.2, h * 0.65);

    canvas.drawPath(path, paint);
  }
}

class _FogPainter extends _BaseIconPainter {
  _FogPainter({required super.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = strokePaint;
    final w = size.width;
    final h = size.height;

    // Three horizontal wavy lines
    for (var i = 0; i < 3; i++) {
      final y = h * (0.3 + i * 0.2);
      final path = Path();
      path.moveTo(w * 0.1, y);
      path.quadraticBezierTo(w * 0.25, y - h * 0.05, w * 0.4, y);
      path.quadraticBezierTo(w * 0.55, y + h * 0.05, w * 0.7, y);
      path.quadraticBezierTo(w * 0.85, y - h * 0.05, w * 0.9, y);
      canvas.drawPath(path, paint);
    }
  }
}

class _SnowflakePainter extends _BaseIconPainter {
  _SnowflakePainter({required super.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = strokePaint;
    final w = size.width;
    final h = size.height;
    final center = Offset(w / 2, h / 2);
    final radius = w * 0.4;

    // 6 main arms
    for (var i = 0; i < 6; i++) {
      final angle = (i * math.pi) / 3;
      final end = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );
      canvas.drawLine(center, end, paint);

      // Small branches on each arm
      final branchStart = Offset(
        center.dx + radius * 0.6 * math.cos(angle),
        center.dy + radius * 0.6 * math.sin(angle),
      );
      final branchAngle1 = angle + math.pi / 6;
      final branchAngle2 = angle - math.pi / 6;
      final branchLen = radius * 0.25;

      canvas.drawLine(
        branchStart,
        Offset(
          branchStart.dx + branchLen * math.cos(branchAngle1),
          branchStart.dy + branchLen * math.sin(branchAngle1),
        ),
        paint,
      );
      canvas.drawLine(
        branchStart,
        Offset(
          branchStart.dx + branchLen * math.cos(branchAngle2),
          branchStart.dy + branchLen * math.sin(branchAngle2),
        ),
        paint,
      );
    }
  }
}

class _RainPainter extends _BaseIconPainter {
  _RainPainter({required super.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = strokePaint;
    final w = size.width;
    final h = size.height;

    // Small cloud
    final cloudPath = Path();
    cloudPath.moveTo(w * 0.15, h * 0.4);
    cloudPath.quadraticBezierTo(w * 0.05, h * 0.35, w * 0.15, h * 0.25);
    cloudPath.quadraticBezierTo(w * 0.25, h * 0.1, w * 0.5, h * 0.15);
    cloudPath.quadraticBezierTo(w * 0.75, h * 0.1, w * 0.8, h * 0.25);
    cloudPath.quadraticBezierTo(w * 0.95, h * 0.3, w * 0.85, h * 0.4);
    cloudPath.lineTo(w * 0.15, h * 0.4);
    canvas.drawPath(cloudPath, paint);

    // Rain drops (diagonal lines)
    final dropPositions = [
      [0.25, 0.5, 0.35, 0.7],
      [0.45, 0.55, 0.55, 0.75],
      [0.65, 0.5, 0.75, 0.7],
    ];

    for (final pos in dropPositions) {
      canvas.drawLine(
        Offset(w * pos[0], h * pos[1]),
        Offset(w * pos[2], h * pos[3]),
        paint,
      );
    }
  }
}

class _ThunderstormPainter extends _BaseIconPainter {
  _ThunderstormPainter({required super.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = strokePaint;
    final w = size.width;
    final h = size.height;

    // Cloud
    final cloudPath = Path();
    cloudPath.moveTo(w * 0.15, h * 0.35);
    cloudPath.quadraticBezierTo(w * 0.05, h * 0.3, w * 0.15, h * 0.2);
    cloudPath.quadraticBezierTo(w * 0.25, h * 0.05, w * 0.5, h * 0.1);
    cloudPath.quadraticBezierTo(w * 0.75, h * 0.05, w * 0.8, h * 0.2);
    cloudPath.quadraticBezierTo(w * 0.95, h * 0.25, w * 0.85, h * 0.35);
    cloudPath.lineTo(w * 0.15, h * 0.35);
    canvas.drawPath(cloudPath, paint);

    // Lightning bolt
    final boltPath = Path();
    boltPath.moveTo(w * 0.55, h * 0.4);
    boltPath.lineTo(w * 0.4, h * 0.6);
    boltPath.lineTo(w * 0.5, h * 0.6);
    boltPath.lineTo(w * 0.4, h * 0.85);
    boltPath.lineTo(w * 0.6, h * 0.55);
    boltPath.lineTo(w * 0.5, h * 0.55);
    boltPath.lineTo(w * 0.55, h * 0.4);
    canvas.drawPath(boltPath, paint);
  }
}

class _MoonPainter extends _BaseIconPainter {
  _MoonPainter({required super.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = strokePaint;
    final w = size.width;
    final h = size.height;

    // Crescent moon shape using two overlapping circles
    final moonPath = Path();
    final center = Offset(w * 0.45, h * 0.5);
    final radius = w * 0.35;

    // Outer arc (visible part of moon)
    moonPath.addArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi * 0.7,
      math.pi * 1.4,
    );

    // Inner arc (shadow cutout) - creates crescent shape
    final innerCenter = Offset(w * 0.6, h * 0.45);
    final innerRadius = w * 0.28;
    moonPath.arcTo(
      Rect.fromCircle(center: innerCenter, radius: innerRadius),
      math.pi * 0.7,
      -math.pi * 1.4,
      false,
    );

    canvas.drawPath(moonPath, paint);

    // Small stars around the moon
    _drawStar(canvas, Offset(w * 0.85, h * 0.25), w * 0.06, paint);
    _drawStar(canvas, Offset(w * 0.75, h * 0.75), w * 0.04, paint);
  }

  void _drawStar(Canvas canvas, Offset center, double size, Paint paint) {
    // Simple 4-point star
    canvas.drawLine(
      Offset(center.dx - size, center.dy),
      Offset(center.dx + size, center.dy),
      paint,
    );
    canvas.drawLine(
      Offset(center.dx, center.dy - size),
      Offset(center.dx, center.dy + size),
      paint,
    );
  }
}

class _PartlyCloudyPainter extends _BaseIconPainter {
  final bool isDay;

  _PartlyCloudyPainter({required super.color, required this.isDay});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = strokePaint;
    final w = size.width;
    final h = size.height;

    if (isDay) {
      // Sun peeking from behind cloud (top-right)
      final sunCenter = Offset(w * 0.75, h * 0.25);
      final sunRadius = w * 0.15;
      canvas.drawCircle(sunCenter, sunRadius, paint);

      // Sun rays (partial, visible ones)
      for (var i = 0; i < 5; i++) {
        final angle = -math.pi * 0.1 + (i * math.pi * 0.25);
        final innerRadius = sunRadius + w * 0.04;
        final outerRadius = sunRadius + w * 0.1;
        canvas.drawLine(
          Offset(
            sunCenter.dx + innerRadius * math.cos(angle),
            sunCenter.dy + innerRadius * math.sin(angle),
          ),
          Offset(
            sunCenter.dx + outerRadius * math.cos(angle),
            sunCenter.dy + outerRadius * math.sin(angle),
          ),
          paint,
        );
      }
    } else {
      // Moon peeking from behind cloud (top-right)
      final moonPath = Path();
      final moonCenter = Offset(w * 0.78, h * 0.22);
      final moonRadius = w * 0.12;

      moonPath.addArc(
        Rect.fromCircle(center: moonCenter, radius: moonRadius),
        -math.pi * 0.5,
        math.pi * 1.2,
      );

      final innerCenter = Offset(w * 0.85, h * 0.2);
      moonPath.arcTo(
        Rect.fromCircle(center: innerCenter, radius: moonRadius * 0.75),
        math.pi * 0.7,
        -math.pi * 1.2,
        false,
      );

      canvas.drawPath(moonPath, paint);
    }

    // Cloud in foreground (larger, lower)
    final cloudPath = Path();
    cloudPath.moveTo(w * 0.15, h * 0.7);
    cloudPath.quadraticBezierTo(w * 0.02, h * 0.7, w * 0.08, h * 0.55);
    cloudPath.quadraticBezierTo(w * 0.08, h * 0.4, w * 0.25, h * 0.4);
    cloudPath.quadraticBezierTo(w * 0.32, h * 0.28, w * 0.5, h * 0.32);
    cloudPath.quadraticBezierTo(w * 0.68, h * 0.28, w * 0.75, h * 0.45);
    cloudPath.quadraticBezierTo(w * 0.92, h * 0.45, w * 0.9, h * 0.58);
    cloudPath.quadraticBezierTo(w * 0.92, h * 0.7, w * 0.78, h * 0.7);
    cloudPath.lineTo(w * 0.15, h * 0.7);

    canvas.drawPath(cloudPath, paint);
  }
}

class _HeartOutlinePainter extends _BaseIconPainter {
  _HeartOutlinePainter({required super.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = strokePaint;
    final w = size.width;
    final h = size.height;

    final path = Path();
    // Heart shape using bezier curves
    path.moveTo(w * 0.5, h * 0.85);
    // Left side
    path.cubicTo(
      w * 0.15, h * 0.6,
      w * 0.1, h * 0.25,
      w * 0.3, h * 0.2,
    );
    path.cubicTo(
      w * 0.4, h * 0.15,
      w * 0.5, h * 0.25,
      w * 0.5, h * 0.35,
    );
    // Right side
    path.cubicTo(
      w * 0.5, h * 0.25,
      w * 0.6, h * 0.15,
      w * 0.7, h * 0.2,
    );
    path.cubicTo(
      w * 0.9, h * 0.25,
      w * 0.85, h * 0.6,
      w * 0.5, h * 0.85,
    );

    canvas.drawPath(path, paint);
  }
}

class _HeartFilledPainter extends _BaseIconPainter {
  _HeartFilledPainter({required super.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final w = size.width;
    final h = size.height;

    final path = Path();
    // Heart shape using bezier curves
    path.moveTo(w * 0.5, h * 0.85);
    // Left side
    path.cubicTo(
      w * 0.15, h * 0.6,
      w * 0.1, h * 0.25,
      w * 0.3, h * 0.2,
    );
    path.cubicTo(
      w * 0.4, h * 0.15,
      w * 0.5, h * 0.25,
      w * 0.5, h * 0.35,
    );
    // Right side
    path.cubicTo(
      w * 0.5, h * 0.25,
      w * 0.6, h * 0.15,
      w * 0.7, h * 0.2,
    );
    path.cubicTo(
      w * 0.9, h * 0.25,
      w * 0.85, h * 0.6,
      w * 0.5, h * 0.85,
    );

    canvas.drawPath(path, paint);
  }
}

class _GridPainter extends _BaseIconPainter {
  _GridPainter({required super.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = strokePaint;
    final w = size.width;
    final h = size.height;

    // 2x2 grid of rounded rectangles
    final cornerRadius = w * 0.08;
    final gap = w * 0.1;
    final cellSize = (w - gap) / 2 - w * 0.1;

    // Top-left cell
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.1, h * 0.1, cellSize, cellSize),
        Radius.circular(cornerRadius),
      ),
      paint,
    );

    // Top-right cell
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.5 + gap / 2, h * 0.1, cellSize, cellSize),
        Radius.circular(cornerRadius),
      ),
      paint,
    );

    // Bottom-left cell
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.1, h * 0.5 + gap / 2, cellSize, cellSize),
        Radius.circular(cornerRadius),
      ),
      paint,
    );

    // Bottom-right cell
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.5 + gap / 2, h * 0.5 + gap / 2, cellSize, cellSize),
        Radius.circular(cornerRadius),
      ),
      paint,
    );
  }
}
