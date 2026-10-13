import 'dart:math';
import 'dart:ui';

import 'package:flutter_golden_ratio_visualization/math/golden.dart';
import 'package:flutter_golden_ratio_visualization/patterns/pattern.dart';

/// A pentagram drawn as a spiral: each lap of five points shrinks by phi squared,
/// the same ratio as the star nested inside a pentagram.
class StarWhirlPattern extends Pattern {
  static const int laps = 8;
  static const int stepsPerEdge = 30;
  static const int _edgesPerLap = 5;

  @override
  String get name => "Star";

  @override
  String get description => "A pentagram spiral, each lap shrinks by φ².";

  @override
  Duration get duration => const Duration(seconds: 8);

  @override
  PointMode get pointMode => PointMode.polygon;

  @override
  double get strokeWidth => 2;

  @override
  late final List<Offset> points = _edges();

  List<Offset> _edges() {
    final List<Offset> corners = List.generate(laps * _edgesPerLap + 1, (i) {
      final double radius = pow(phi, -2 * i / _edgesPerLap).toDouble();
      return polar(radius, -pi / 2 + i * 4 * pi / _edgesPerLap);
    });
    return [
      for (int i = 0; i < corners.length - 1; i++)
        for (int step = 0; step < stepsPerEdge; step++)
          Offset.lerp(corners[i], corners[i + 1], step / stepsPerEdge)!,
      corners.last,
    ];
  }
}
