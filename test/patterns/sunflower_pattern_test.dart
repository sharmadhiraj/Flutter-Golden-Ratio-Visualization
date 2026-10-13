import 'dart:math';

import 'package:flutter_golden_ratio_visualization/math/golden.dart';
import 'package:flutter_golden_ratio_visualization/patterns/sunflower_pattern.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final SunflowerPattern pattern = SunflowerPattern();

  test("has a seed count that is a Fibonacci number", () {
    expect(pattern.points.length, 1597);
  });

  test("radius grows monotonically from the center to the edge", () {
    final List<double> radii = pattern.points.map((p) => p.distance).toList();
    expect(radii.first, 0);
    expect(radii.last, closeTo(1, 1e-9));
    for (int i = 1; i < radii.length; i++) {
      expect(radii[i], greaterThan(radii[i - 1]));
    }
  });

  test("consecutive seeds are one golden angle apart", () {
    final double turn = pattern.points[11].direction - pattern.points[10].direction;
    expect(atan2(sin(turn), cos(turn)), closeTo(goldenAngle, 1e-9));
  });
}
