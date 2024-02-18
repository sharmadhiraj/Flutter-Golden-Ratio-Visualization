import 'dart:ui';

import 'package:flutter/material.dart';

class AppPainter extends CustomPainter {
  final List<Offset> points;

  AppPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1;

    canvas.drawPoints(PointMode.points, points, paint);
  }

  @override
  bool shouldRepaint(AppPainter oldDelegate) {
    return oldDelegate.points != points;
  }
}
