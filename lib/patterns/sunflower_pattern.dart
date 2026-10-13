import 'dart:math';
import 'dart:ui';

import 'package:flutter_golden_ratio_visualization/math/golden.dart';
import 'package:flutter_golden_ratio_visualization/patterns/pattern.dart';

/// Seeds placed one golden angle apart pack evenly, as in a sunflower head.
class SunflowerPattern extends Pattern {
  static const int seedCount = 1597;

  @override
  String get name => "Sunflower";

  @override
  String get description => "Each seed turns by the golden angle (137.5°).";

  @override
  Duration get duration => const Duration(seconds: 10);

  @override
  PointMode get pointMode => PointMode.points;

  @override
  double get strokeWidth => 5;

  @override
  late final List<Offset> points = List.generate(
    seedCount,
    (i) => polar(sqrt(i / (seedCount - 1)), i * goldenAngle),
  );
}
