import 'dart:math';
import 'dart:ui' show PointMode;

import 'package:flutter/material.dart';
import 'package:flutter_golden_ratio_visualization/patterns/pattern.dart';

class PatternPainter extends CustomPainter {
  PatternPainter({required this.pattern, required this.progress}) : super(repaint: progress);

  static const int _colorBands = 64;
  static const double _maxHue = 300;
  static const double _margin = 0.92;

  final Pattern pattern;
  final Animation<double> progress;

  int get visibleCount =>
      (progress.value * pattern.points.length).ceil().clamp(0, pattern.points.length);

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.shortestSide / 2 * _margin;
    canvas
      ..translate(size.width / 2, size.height / 2)
      ..scale(radius);

    final List<Offset> points = pattern.points;
    final int bandSize = (points.length / _colorBands).ceil();
    final Paint paint = Paint()
      ..strokeCap = StrokeCap.round
      ..strokeWidth = pattern.strokeWidth / radius;

    for (int start = 0; start < visibleCount; start += bandSize) {
      final int end = min(start + bandSize + 1, min(visibleCount + 1, points.length));
      paint.color = HSVColor.fromAHSV(1, _maxHue * start / points.length, 0.65, 1).toColor();
      canvas.drawPoints(pattern.pointMode, points.sublist(start, end), paint);
    }

    if (visibleCount > 0 && visibleCount < points.length) {
      paint
        ..color = Colors.white
        ..strokeWidth = 1.5 / radius;
      final List<Offset> arms = [Offset.zero, ...pattern.jointsAt(visibleCount - 1)];
      canvas.drawPoints(PointMode.polygon, arms, paint);
    }
  }

  @override
  bool shouldRepaint(PatternPainter oldDelegate) {
    return oldDelegate.pattern != pattern;
  }
}
