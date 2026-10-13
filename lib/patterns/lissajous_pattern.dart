import 'dart:math';
import 'dart:ui';

import 'package:flutter_golden_ratio_visualization/math/golden.dart';
import 'package:flutter_golden_ratio_visualization/patterns/pattern.dart';

/// x oscillates once while y oscillates phi times: the curve weaves without repeating.
class LissajousPattern extends Pattern {
  static const int turns = 55;
  static const int stepsPerTurn = 360;

  @override
  String get name => "Weave";

  @override
  String get description => "Two waves with frequencies 1 and φ.";

  @override
  Duration get duration => const Duration(seconds: 20);

  @override
  PointMode get pointMode => PointMode.polygon;

  @override
  double get strokeWidth => 1;

  @override
  late final List<Offset> points = List.generate(turns * stepsPerTurn, (i) {
    final double angle = 2 * pi * i / stepsPerTurn;
    return Offset(sin(angle), sin(phi * angle)) / sqrt2;
  });
}
