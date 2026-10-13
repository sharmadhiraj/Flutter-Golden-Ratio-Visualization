import 'package:flutter_golden_ratio_visualization/math/golden.dart';
import 'package:flutter_golden_ratio_visualization/patterns/golden_spiral_pattern.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final GoldenSpiralPattern pattern = GoldenSpiralPattern();
  const int quarterTurn = GoldenSpiralPattern.stepsPerTurn ~/ 4;

  test("ends on the unit circle", () {
    expect(pattern.points.last.distance, closeTo(1, 1e-9));
  });

  test("radius grows by phi every quarter turn", () {
    for (final i in [0, 100, 500]) {
      final double ratio = pattern.points[i + quarterTurn].distance / pattern.points[i].distance;
      expect(ratio, closeTo(phi, 1e-9));
    }
  });
}
