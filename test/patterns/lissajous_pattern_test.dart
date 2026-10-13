import 'package:flutter_golden_ratio_visualization/patterns/lissajous_pattern.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final LissajousPattern pattern = LissajousPattern();

  test("starts at the center", () {
    expect(pattern.points.first.distance, closeTo(0, 1e-12));
  });

  test("does not repeat after one turn", () {
    expect(
      (pattern.points[LissajousPattern.stepsPerTurn] - pattern.points.first).distance,
      greaterThan(0.1),
    );
  });
}
