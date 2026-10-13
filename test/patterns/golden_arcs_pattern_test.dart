import 'package:flutter_golden_ratio_visualization/math/golden.dart';
import 'package:flutter_golden_ratio_visualization/patterns/golden_arcs_pattern.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final GoldenArcsPattern pattern = GoldenArcsPattern();
  const int steps = GoldenArcsPattern.stepsPerArc;

  double chord(int arc) =>
      (pattern.points[(arc + 1) * steps] - pattern.points[arc * steps]).distance;

  test("has no gaps between arcs", () {
    for (int i = 1; i < pattern.points.length; i++) {
      expect((pattern.points[i] - pattern.points[i - 1]).distance, lessThan(0.05));
    }
  });

  test("each arc is phi times smaller than the previous one", () {
    for (int arc = 0; arc < GoldenArcsPattern.arcs - 1; arc++) {
      expect(chord(arc) / chord(arc + 1), closeTo(phi, 1e-9));
    }
  });

  test("ends at the center and fills the unit circle", () {
    expect(pattern.points.last.distance, closeTo(0, 1e-12));
    final double reach = pattern.points.map((p) => p.distance).reduce((a, b) => a > b ? a : b);
    expect(reach, closeTo(1, 1e-12));
  });
}
