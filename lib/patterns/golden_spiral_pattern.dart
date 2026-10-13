import 'dart:math';
import 'dart:ui';

import 'package:flutter_golden_ratio_visualization/math/golden.dart';
import 'package:flutter_golden_ratio_visualization/patterns/pattern.dart';

/// A logarithmic spiral that grows by a factor of phi every quarter turn.
class GoldenSpiralPattern extends Pattern {
  static const int turns = 3;
  static const int stepsPerTurn = 720;

  @override
  String get name => "Spiral";

  @override
  String get description => "Every quarter turn, the radius grows by φ.";

  @override
  Duration get duration => const Duration(seconds: 6);

  @override
  PointMode get pointMode => PointMode.polygon;

  @override
  double get strokeWidth => 2;

  @override
  late final List<Offset> points = List.generate(turns * stepsPerTurn + 1, (i) {
    final double angle = 2 * pi * i / stepsPerTurn;
    final double quartersFromEnd = (angle - 2 * pi * turns) / (pi / 2);
    return polar(pow(phi, quartersFromEnd).toDouble(), angle);
  });
}
