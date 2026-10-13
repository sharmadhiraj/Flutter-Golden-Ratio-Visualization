import 'dart:ui';

import 'package:flutter_golden_ratio_visualization/math/golden.dart';
import 'package:flutter_golden_ratio_visualization/patterns/pattern.dart';

/// Points on a circle a golden angle apart, joined in order. Their chords weave
/// a web whose envelope is a smaller circle.
class ChordsPattern extends Pattern {
  static const int pointTotal = 377;

  @override
  String get name => "Chords";

  @override
  String get description => "377 points on a circle, each a golden angle past the last.";

  @override
  Duration get duration => const Duration(seconds: 12);

  @override
  PointMode get pointMode => PointMode.polygon;

  @override
  double get strokeWidth => 1;

  @override
  late final List<Offset> points = List.generate(
    pointTotal,
    (i) => polar(1, i * goldenAngle),
  );
}
