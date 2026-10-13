import 'dart:math';
import 'dart:ui';

import 'package:flutter_golden_ratio_visualization/math/golden.dart';
import 'package:flutter_golden_ratio_visualization/patterns/pattern.dart';

/// A rose curve r = cos(phi * theta). Irrational petal count, so it never closes.
class RosePattern extends Pattern {
  static const int turns = 34;
  static const int stepsPerTurn = 360;

  @override
  String get name => "Rose";

  @override
  String get description => "A rose with φ petals per turn: it never closes.";

  @override
  Duration get duration => const Duration(seconds: 20);

  @override
  PointMode get pointMode => PointMode.polygon;

  @override
  double get strokeWidth => 1;

  @override
  late final List<Offset> points = List.generate(turns * stepsPerTurn, (i) {
    final double angle = 2 * pi * i / stepsPerTurn;
    return polar(cos(phi * angle), angle);
  });
}
